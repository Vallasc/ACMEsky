package it.unibo.soseng.logic.offer;

import static it.unibo.soseng.camunda.utils.ProcessVariables.RENT_BACK;
import static it.unibo.soseng.camunda.utils.ProcessVariables.RENT_OUTBOUND;

import java.io.IOException;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import java.util.UUID;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.nio.charset.Charset;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.PersistenceException;
import javax.security.enterprise.SecurityContext;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.delegate.DelegateExecution;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.gateway.distance.DistanceClient;
import it.unibo.soseng.gateway.distance.DistanceClient.GeoserverErrorException;
import it.unibo.soseng.gateway.distance.dto.DistanceDTO;
import it.unibo.soseng.gateway.rent.RentClient;
import it.unibo.soseng.gateway.user.dto.AddressDTO;
import it.unibo.soseng.gateway.user.dto.UserOfferDTO;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.FlightNotExistException;
import it.unibo.soseng.logic.database.DatabaseManager.OfferNotFoundException;
import it.unibo.soseng.logic.database.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.model.Airport;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.model.User;
import it.unibo.soseng.model.UserInterest;
import it.unibo.soseng.utils.Errors;
import it.unibo.soseng.ws.generated.BookRent;
import it.unibo.soseng.ws.generated.BookRentResponse;
import it.unibo.soseng.ws.generated.Rent;
import it.unibo.soseng.ws.generated.RentService1;
import it.unibo.soseng.ws.generated.RentService2;

import static it.unibo.soseng.camunda.utils.Events.PAY_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.ASYNC_RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.BUSINESS_KEY;
import static it.unibo.soseng.camunda.utils.ProcessVariables.IS_OFFER_EXPIRED;
import static it.unibo.soseng.camunda.utils.ProcessVariables.IS_VALID_TOKEN;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_CONFIRM_BUY_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER_REQUEST;
import static it.unibo.soseng.camunda.utils.ProcessVariables.OFFER_TOKEN;

@Stateless
public class OfferManager {
    private final static Logger LOGGER = Logger.getLogger(OfferManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;

    @Inject
    private DistanceClient distanceClient;

    @Inject
    private RentClient rentClient;

    @Inject
    private ProcessState processState;

    @Inject
    private SecurityContext securityContext;

    public GeneratedOffer generateOffer(Flight outBound, Flight flightBack, String username)
            throws PersistenceException, FlightNotExistException, UserNotFoundException {
        this.setFlightUnavailable(outBound);
        this.setFlightUnavailable(flightBack);

        GeneratedOffer generatedOffer = new GeneratedOffer();
        generatedOffer.setBooked(false);
        generatedOffer.setAvailable(true);
        generatedOffer.setOutboundFlight(outBound);
        generatedOffer.setFlightBack(flightBack);
        generatedOffer.setExpireDate(OffsetDateTime.now().plusHours(24));
        generatedOffer.setTotalPrice(flightBack.getPrice() + outBound.getPrice());
        User user = databaseManager.getUser(username);
        generatedOffer.setUser(user);

        databaseManager.createOffer(generatedOffer);
        String uniqueToken = UUID.randomUUID().toString().substring(0, 4) + String.valueOf(generatedOffer.getId());
        generatedOffer.setToken(uniqueToken);
        databaseManager.updateOffer(generatedOffer);
        return generatedOffer;
    }

    public List<Flight> checkFlightsRequirements(UserInterest ui) {
        List<Flight> matchedFlights = new ArrayList<Flight>();
        List<Flight> flights = databaseManager.getAvailableFlights();

        for (Flight flight1 : flights) {
            if (this.isMatched(flight1, ui.getOutboundFlightInterest())) {
                for (Flight flight2 : flights) {
                    if (flight1 != flight2 && this.isMatched(flight2, ui.getFlightBackInterest())
                            && flight1.getPrice() + flight2.getPrice() <= ui.getPriceLimit()) {
                        matchedFlights.add(flight1);
                        matchedFlights.add(flight2);
                        return matchedFlights;
                    }
                }
            }
        }

        return matchedFlights;
    }

    private boolean isMatched(Flight f, FlightInterest fi) {
        OffsetDateTime flightDate = f.getDepartureDateTime();
        OffsetDateTime interestDateStart = fi.getDepartureDateTime();
        OffsetDateTime interestDateEnd = interestDateStart.plusDays(1);

        return f.getDepartureAirport() == fi.getDepartureAirport() && f.getArrivalAirport() == fi.getArrivalAirport()
                && interestDateStart.compareTo(flightDate) <= 0 && interestDateEnd.compareTo(flightDate) >= 0;
    }

    public void setFlightUnavailable(Flight f) {
        f.setAvailable(false);
        databaseManager.updateFlight(f);
    }

    public List<GeneratedOffer> removeExpiredOffers() {
        OffsetDateTime now = OffsetDateTime.now();
        List<GeneratedOffer> expFlights = databaseManager.getAvailableOffers().stream()
                .filter(f -> f.getExpireDate().isBefore(now)).collect(Collectors.toList());

        return expFlights;
    }

    public void setUnavailableOfferFlights(List<GeneratedOffer> list) {
        for (ListIterator<GeneratedOffer> iter = list.listIterator(); iter.hasNext();) {
            GeneratedOffer g = iter.next();
            g.setAvailable(false);
            g.getOutboundFlight().setAvailable(false);
            g.getFlightBack().setAvailable(false);
            databaseManager.updateFlight(g.getOutboundFlight());
            databaseManager.updateFlight(g.getFlightBack());
            databaseManager.updateOffer(g);
        }
    }

    public void setUsedUserInterest(UserInterest userInterest) {
        userInterest.setUsed(true);
        userInterest.getOutboundFlightInterest().setUsed(true);
        userInterest.getFlightBackInterest().setUsed(true);
        databaseManager.updateUserInterest(userInterest);
    }

    // TODO: controllare che non ci siano altri processi attivi
    // Start Camunda process
    public void startConfirmOffer(UserOfferDTO request, AsyncResponse response, UriInfo uriInfo) {
        LOGGER.info("StartConfirmOffer");
        String email = securityContext.getCallerPrincipal().getName();
        String token = request.getToken();

        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        Map<String, Object> processVariables = new HashMap<String, Object>();
        processVariables.put(USER_OFFER_REQUEST, request);
        processVariables.put(OFFER_TOKEN, token);
        processVariables.put(USERNAME, email);
        processVariables.put(BUSINESS_KEY, email + PROCESS_CONFIRM_BUY_OFFER);
        processState.setState(PROCESS_CONFIRM_BUY_OFFER, email, ASYNC_RESPONSE, response);

        // Start the process instance
        // TODO Iniziare processo con messaggio se si puo
        runtimeService.createProcessInstanceByKey(PAY_OFFER).businessKey(email + PROCESS_CONFIRM_BUY_OFFER)
                .setVariables(processVariables).executeWithVariablesInReturn();
    }

    public Response handleConfirmOffer(String token, String email, UserOfferDTO offer, DelegateExecution execution)
            throws OfferNotFoundException {
        // Control token
        execution.setVariable(IS_VALID_TOKEN, true);
        execution.setVariable(IS_OFFER_EXPIRED, false);

        if (token == null || token == "") {
            execution.setVariable(IS_VALID_TOKEN, false);
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).entity(Errors.INVALID_TOKEN).build();
        }
        GeneratedOffer offerToReturn;

        try {
            offerToReturn = databaseManager.getOfferByTokenEmail(token, email);

        } catch (OfferNotFoundException e) {
            execution.setVariable(IS_VALID_TOKEN, false);
            return Response.status(Response.Status.NOT_FOUND.getStatusCode()).entity(Errors.INVALID_TOKEN).build();
        }

        OffsetDateTime now = OffsetDateTime.now();
        if (offerToReturn.getExpireDate().compareTo(now) < 0) {
            execution.setVariable(IS_OFFER_EXPIRED, true);
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).entity(Errors.OFFER_EXPIRED).build();
        }
        execution.setVariable(USER_OFFER, offerToReturn);
        return Response.status(Response.Status.OK.getStatusCode()).build();
    }

    public void startPaymentRequest(AsyncResponse response) {
        String email = securityContext.getCallerPrincipal().getName();
        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();

        processState.setState(PROCESS_CONFIRM_BUY_OFFER, email, ASYNC_RESPONSE, response);
        runtimeService.createMessageCorrelation(PAY_OFFER).processInstanceBusinessKey(email + PROCESS_CONFIRM_BUY_OFFER)
                // .setVariable("var", response)
                .correlate();
    }

    /**
     * Ritona la distanza tra l'aereoporto dell'offerta e línidirizzo inserito
     * 
     * @throws DistanceServiceException
     */
    public float getDistance(AddressDTO userAddress, GeneratedOffer offer) throws DistanceServiceException {
        Float latitude = offer.getOutboundFlight().getDepartureAirport().getLatitude();
        Float longitude = offer.getOutboundFlight().getDepartureAirport().getLongitude();
        String fullAddress = userAddress.getAddress() + ", " + userAddress.getPostCode() + " "
                + userAddress.getCityName() + ", " + userAddress.getCountry();
        try {
            DistanceDTO distance = distanceClient.requestDistance(fullAddress,
                    latitude.toString() + ',' + longitude.toString());
            if (!distance.getStatus().equals("OK"))
                throw new DistanceServiceException();
            return distance.getValue();
        } catch (IOException | GeoserverErrorException e) {
            LOGGER.severe(e.toString());
            throw new DistanceServiceException();
        }
    }

    public void bookAllRent(String email, AddressDTO address, GeneratedOffer offer, DelegateExecution execution)
            throws UserNotFoundException {
        User user = databaseManager.getUser(email);
        String userAddress = address.getAddress() + ", " + address.getPostCode() + " " + address.getCityName() + ", "
                + address.getCountry();
        Airport airport = offer.getOutboundFlight().getDepartureAirport();
        String airportAddress = String.valueOf(airport.getLatitude()) + ',' + String.valueOf(airport.getLongitude());
        try {
            BookRentResponse reponse = this.bookRent(RentService1.class, user, userAddress, airportAddress);
            execution.setVariable(RENT_OUTBOUND, reponse);
        } catch (RentServiceException e) {
            LOGGER.info(e.toString());
        }
        try {
            BookRentResponse reponse = this.bookRent(RentService2.class, user, airportAddress, userAddress);
            execution.setVariable(RENT_BACK, reponse);
        } catch (RentServiceException e) {
            LOGGER.info(e.toString());
        }
    }

    public BookRentResponse bookRent(Class service, User user, String addressFrom, String addressTo)
            throws RentServiceException {
        RentService1 rentService1 = new RentService1();
        RentService2 rentService2 = new RentService2();
        Rent ws;
        if (service.getName() == "RentService1")
            ws = rentService1.getRentServicePort();
        else
            ws = rentService2.getRentServicePort();

        BookRent bookRent = new BookRent();
        bookRent.setClientName(user.getName());
        bookRent.setClientSurname(user.getSurname());
        bookRent.setFromAddress(addressFrom);
        bookRent.setToAddress(addressTo);

        return rentClient.rentRequest(ws, bookRent);
    }

    static String getRandomString(int i) {
        // bind the length
        byte[] bytearray;
        bytearray = new byte[256];
        String mystring;
        StringBuffer thebuffer;
        String theAlphaNumericS;

        new Random().nextBytes(bytearray);

        mystring = new String(bytearray, Charset.forName("UTF-8"));

        thebuffer = new StringBuffer();

        // remove all spacial char
        theAlphaNumericS = mystring.replaceAll("[^A-Z0-9]", "");

        // random selection
        for (int m = 0; m < theAlphaNumericS.length(); m++) {

            if (Character.isLetter(theAlphaNumericS.charAt(m)) && (i > 0)
                    || Character.isDigit(theAlphaNumericS.charAt(m)) && (i > 0)) {

                thebuffer.append(theAlphaNumericS.charAt(m));
                i--;
            }
        }

        // the resulting string
        return thebuffer.toString();
    }

    public void setBookedOffer(GeneratedOffer offer) {

        offer.setBooked(true);
        // offer.setAvailable(false);
        databaseManager.updateOffer(offer);
        databaseManager.setBookFlights(true, offer.getOutboundFlight(), offer.getFlightBack());
    }

    public class DistanceServiceException extends Exception {
    }

    public class RentServiceException extends Exception {
    }

}
