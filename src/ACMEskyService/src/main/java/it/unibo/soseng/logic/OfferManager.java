package it.unibo.soseng.logic;

import static it.unibo.soseng.camunda.utils.ProcessVariables.RENT_BACK;
import static it.unibo.soseng.camunda.utils.ProcessVariables.RENT_OUTBOUND;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_ADDRESS;

import java.io.File;
import java.io.IOException;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import java.util.UUID;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.PersistenceException;
import javax.security.enterprise.SecurityContext;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.delegate.DelegateExecution;

import java.util.HashMap;
import java.util.Map;

import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.gateway.distance.DistanceClient;
import it.unibo.soseng.gateway.distance.DistanceClient.GeoserverErrorException;
import it.unibo.soseng.gateway.distance.dto.DistanceDTO;
import it.unibo.soseng.gateway.rent.RentClient;
import it.unibo.soseng.gateway.user.dto.AddressDTO;
import it.unibo.soseng.gateway.user.dto.OfferDTO;
import it.unibo.soseng.gateway.user.dto.UserOfferDTO;
import it.unibo.soseng.logic.DatabaseManager.FlightNotExistException;
import it.unibo.soseng.logic.DatabaseManager.OfferNotFoundException;
import it.unibo.soseng.logic.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.model.Airport;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.model.RentService;
import it.unibo.soseng.model.User;
import it.unibo.soseng.model.UserInterest;
import it.unibo.soseng.utils.Env;
import it.unibo.soseng.utils.Errors;
import it.unibo.soseng.ws.generated.BookRentResponse;

import static it.unibo.soseng.camunda.utils.Events.PAY_OFFER;
import static it.unibo.soseng.camunda.utils.Events.START_PAY_OFFER;
import static it.unibo.soseng.camunda.utils.Events.RESET_1;
import static it.unibo.soseng.camunda.utils.Events.RESET_2;
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
        generatedOffer.setRent(false);
        generatedOffer.setAvailable(true);
        generatedOffer.setOutboundFlight(outBound);
        generatedOffer.setFlightBack(flightBack);
        generatedOffer.setExpireDate(OffsetDateTime.now().plusHours(24));
        generatedOffer.setTotalPrice(flightBack.getPrice() + outBound.getPrice() + Env.ACMESKY_ADDITIONAL_PRICE);
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

    public void startConfirmOffer(UserOfferDTO request, AsyncResponse response, UriInfo uriInfo) {
        LOGGER.info("StartConfirmOffer");
        String email = securityContext.getCallerPrincipal().getName();
        String token = request.getOfferToken();

        try {
            databaseManager.getOfferByTokenEmail(token, email);
        } catch (OfferNotFoundException e) {
            response.resume(Response.status(Response.Status.NOT_FOUND.getStatusCode()).build());
            return;
        }

        Integer processActive = (Integer) processState.getState(PROCESS_CONFIRM_BUY_OFFER, email, token);
        if(processActive != null) {
            response.resume(Response.status(Response.Status.CONFLICT.getStatusCode()).build());
            return;
        }
        processState.setState(PROCESS_CONFIRM_BUY_OFFER, email, token, 1);

        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        Map<String, Object> processVariables = new HashMap<String, Object>();
        processVariables.put(USER_OFFER_REQUEST, request);
        processVariables.put(OFFER_TOKEN, token);
        processVariables.put(USERNAME, email);
        processVariables.put(BUSINESS_KEY, PROCESS_CONFIRM_BUY_OFFER + email + token);
        processState.setState(PROCESS_CONFIRM_BUY_OFFER, email, ASYNC_RESPONSE, response);


        // Start the process instance
        runtimeService.correlateMessage(START_PAY_OFFER, 
                                        PROCESS_CONFIRM_BUY_OFFER + email + token,
                                        processVariables);
    }  
    
    public Response handleConfirmOffer(String token, String email, UserOfferDTO offer, DelegateExecution execution) throws OfferNotFoundException{
        // Control token
        execution.setVariable(IS_VALID_TOKEN, true);
        execution.setVariable(IS_OFFER_EXPIRED, false);

        if (token == null || token == "") {
            execution.setVariable(IS_VALID_TOKEN, false);               
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
                    .entity(Errors.INVALID_TOKEN)
                    .build();
        }

        GeneratedOffer offerToReturn;
        try {
            offerToReturn = databaseManager.getOfferByTokenEmail(token, email);

        } catch (OfferNotFoundException e) {
            execution.setVariable(IS_VALID_TOKEN, false);               
            return Response.status(Response.Status.NOT_FOUND.getStatusCode())
                    .entity(Errors.INVALID_TOKEN)
                    .build();
        }

        if(offerToReturn.getBooked() || !offerToReturn.getAvailable()){
            return Response.status(Response.Status.NOT_FOUND.getStatusCode())
                    .entity(Errors.INVALID_TOKEN)
                    .build();
        }

        OffsetDateTime now = OffsetDateTime.now();
        if (offerToReturn.getExpireDate().compareTo(now) < 0) {
            execution.setVariable(IS_OFFER_EXPIRED, true);
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).entity(Errors.OFFER_EXPIRED).build();
        }
        execution.setVariable(USER_OFFER, offerToReturn);
        return Response.status(Response.Status.OK.getStatusCode())
                        .entity(OfferDTO.fromOffer(offerToReturn))
                        .build();
    }

    public void startPaymentRequest(AddressDTO address, AsyncResponse response) {
        String email = securityContext.getCallerPrincipal().getName();

        try {
            databaseManager.getOfferByTokenEmail(address.getOfferToken(), email);
        } catch (OfferNotFoundException e) {
            response.resume(Response.status(Response.Status.NOT_FOUND.getStatusCode()).build());
            return;
        }

        Integer processActive = (Integer) processState.getState(PROCESS_CONFIRM_BUY_OFFER, email, address.getOfferToken());
        if(processActive == null){
            response.resume(Response.status(Response.Status.METHOD_NOT_ALLOWED.getStatusCode()).build());
            return;
        }
        if(processActive == 2){
            response.resume(Response.status(Response.Status.CONFLICT.getStatusCode()).build());
            return;
        }
        
        processState.setState(PROCESS_CONFIRM_BUY_OFFER, email, address.getOfferToken(), 2);
        processState.setState(PROCESS_CONFIRM_BUY_OFFER, email, ASYNC_RESPONSE, response);

        Map<String,Object> processVariables = new HashMap<String,Object>();
        processVariables.put(USER_ADDRESS, address);

        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        runtimeService.correlateMessage(PAY_OFFER, 
                                        PROCESS_CONFIRM_BUY_OFFER + email + address.getOfferToken(),
                                        processVariables);
    }

    public void resetProcess(UserOfferDTO offer, AsyncResponse response){
        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        String email = securityContext.getCallerPrincipal().getName();
        try {
            databaseManager.getOfferByTokenEmail(offer.getOfferToken(), email);
        } catch (OfferNotFoundException e) {
            response.resume(Response.status(Response.Status.NOT_FOUND.getStatusCode()).build());
            return;
        }

        Integer processActive = (Integer) processState.getState(PROCESS_CONFIRM_BUY_OFFER, email, offer.getOfferToken());
        if(processActive == null){
            response.resume(Response.status(Response.Status.NOT_FOUND.getStatusCode()).build());
            return;
        }
        response.resume(Response.status(Response.Status.OK.getStatusCode()).build());
        if(processActive == 1){
            runtimeService.correlateMessage(RESET_1, PROCESS_CONFIRM_BUY_OFFER + email + offer.getOfferToken());
        }
        if(processActive == 2){
            runtimeService.correlateMessage(RESET_2, PROCESS_CONFIRM_BUY_OFFER + email + offer.getOfferToken());
        }
    }

    public Response requestOffer(String token){
        String email = securityContext.getCallerPrincipal().getName();
        try {
            GeneratedOffer offer = databaseManager.getOfferByTokenEmail(token, email);
            if(offer.getBooked()) {
                return Response.status(Response.Status.OK.getStatusCode())
                                .entity(OfferDTO.fromOffer(offer))
                                .build();
            } else {
                return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
            }
        } catch (OfferNotFoundException e) {
            return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
        }
    }

    public Response requestOffers(){
        String email = securityContext.getCallerPrincipal().getName();
        List<GeneratedOffer> offers = (List<GeneratedOffer>) databaseManager.getOffersByEmail(email);
        offers.removeIf(offer -> !offer.getBooked());
        List<OfferDTO> out = offers.stream()
                                    .map((offer) -> OfferDTO.fromOffer(offer))
                                    .collect(Collectors.toList());
        return Response.status(Response.Status.OK.getStatusCode())
                            .entity(out)
                            .build();
    }

    public Response requestTicket(String token){
        String email = securityContext.getCallerPrincipal().getName();
        try {
            GeneratedOffer offer = databaseManager.getOfferByTokenEmail(token, email);
            if(offer.getBooked()){ 
                File file = new File(offer.getToken() + ".pdf");
                return Response.ok(file, MediaType.APPLICATION_OCTET_STREAM)
                    .header("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"" )
                    .build();
            }
            return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
        } catch (OfferNotFoundException e) {}
        return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
    }

    /**
     * Ritona la distanza tra l'aereoporto dell'offerta e línidirizzo inserito
     * 
     * @throws DistanceServiceException
     */
    public float getDistance(AddressDTO userAddress, GeneratedOffer offer) throws DistanceServiceException {
        Float latitude = offer.getOutboundFlight().getDepartureAirport().getLatitude();
        Float longitude = offer.getOutboundFlight().getDepartureAirport().getLongitude();
        String fullAddress = userAddress.toString();
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

    public RentService getNearestRent(AddressDTO userAddress) {
        List<RentService> rentServices = databaseManager.getAllRentServices();
        RentService nearest = null;
        float minDistance = Float.MAX_VALUE;
        for(RentService rent : rentServices){
            try {
                DistanceDTO distance = 
                    distanceClient.requestDistance(userAddress.toString(), rent.getAddress());
                if (!distance.getStatus().equals("OK"))
                    continue;
                if(distance.getValue() < minDistance) {
                    nearest = rent;
                    minDistance = distance.getValue();
                }
            } catch (IOException | GeoserverErrorException e) {
                LOGGER.severe(e.toString());
            }
        }
        return nearest;
    }

    public void bookAllRent(String email, AddressDTO address, GeneratedOffer offer, RentService rent, DelegateExecution execution) 
                                                                    throws UserNotFoundException {
        User user = databaseManager.getUser(email);
        String userAddress = address.toString();
        Airport airport = offer.getOutboundFlight().getDepartureAirport();
        String airportAddress = String.valueOf(airport.getLatitude()) +','+ String.valueOf(airport.getLongitude());
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
        String dateTimeOutbound = fmt.format(offer.getOutboundFlight().getDepartureDateTime());
        String dateTimeFligntBack = fmt.format(offer.getFlightBack().getArrivalDateTime());

        // Outbound
        String name = rent.getEntity().getUsername();
        BookRentResponse response = rentClient.bookRent(name, user, userAddress, airportAddress, dateTimeOutbound);
        if(response.getStatus().equals("OK")){
            execution.setVariable(RENT_OUTBOUND, response);
        }

        // Flyback
        response = rentClient.bookRent(name, user, airportAddress, userAddress, dateTimeFligntBack);
        if(response.getStatus().equals("OK")){
            execution.setVariable(RENT_BACK, response);
        }
        offer.setRent(true);
    }

    public void setBooked(GeneratedOffer offer){
        offer.setBooked(true);
        offer.setAvailable(false);
        offer.getOutboundFlight().setBooked(true);
        offer.getOutboundFlight().setAvailable(false);
        offer.getFlightBack().setBooked(true);
        offer.getFlightBack().setAvailable(false);
        databaseManager.updateOffer(offer);
    }

    public class DistanceServiceException extends Exception {}
    public class SendTicketException extends Exception {}    
   
}