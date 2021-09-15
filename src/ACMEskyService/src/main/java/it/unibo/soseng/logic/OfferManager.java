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

/**
 * Logica che utilizza le classi del model e del gateway per interagire con le
 * compagnie aeree
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

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

    /**
     * genera l'offerta di volo che soddisfa un'offerta di interesse di un utente
     * 
     * @param outBound
     * @param flightBack
     * @param username
     * @return
     * @throws PersistenceException
     * @throws FlightNotExistException
     * @throws UserNotFoundException
     */
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

    /**
     * data un'offerta di interesse degli utenti restituisce tutti i voli
     * compatibili con quelli dell'offerta
     * 
     * @param ui
     * @return
     */
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

    /**
     * verifica se un volo di interesse, passato come argomento, corrisponde al volo
     * passato come parametro
     * 
     * @param f
     * @param fi
     * @return
     */
    private boolean isMatched(Flight f, FlightInterest fi) {
        OffsetDateTime flightDate = f.getDepartureDateTime();
        OffsetDateTime interestDateStart = fi.getDepartureDateTime();
        OffsetDateTime interestDateEnd = interestDateStart.plusDays(1);

        return f.getDepartureAirport() == fi.getDepartureAirport() && f.getArrivalAirport() == fi.getArrivalAirport()
                && interestDateStart.compareTo(flightDate) <= 0 && interestDateEnd.compareTo(flightDate) >= 0;
    }

    /**
     * imposta lo stato di disponibilità del volo in non disponibile
     */
    public void setFlightUnavailable(Flight f) {
        f.setAvailable(false);
        databaseManager.updateFlight(f);
    }

    /**
     * restituisce la lista di voli da rimuovere, ovvero quelli scaduti
     * 
     * @return
     */
    public List<GeneratedOffer> removeExpiredOffers() {
        OffsetDateTime now = OffsetDateTime.now();
        List<GeneratedOffer> expFlights = databaseManager.getAvailableOffers().stream()
                .filter(f -> f.getExpireDate().isBefore(now)).collect(Collectors.toList());

        return expFlights;
    }

    /**
     * imposta i voli dell'offerta come non disponibili
     */
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

    /**
     * aggiorna lo stato delle offerte di interesse degli utenti che sono già state
     * richieste ai servizi delle compagnie aeree
     */
    public void setUsedUserInterest(UserInterest userInterest) {
        userInterest.setUsed(true);
        userInterest.getOutboundFlightInterest().setUsed(true);
        userInterest.getFlightBackInterest().setUsed(true);
        databaseManager.updateUserInterest(userInterest);
    }

    /**
     * avvia il processo di conferma e pagamento dell'offerta generata per cui
     * l'utente ha manifestato la volontà di acquistare
     */
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
        if (processActive != null) {
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
        runtimeService.correlateMessage(START_PAY_OFFER, PROCESS_CONFIRM_BUY_OFFER + email + token, processVariables);
    }

    /**
     * gestisce la parte di conferma del processo di acquisto dell'offerta di volo
     */
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

        if (offerToReturn.getBooked() || !offerToReturn.getAvailable()) {
            return Response.status(Response.Status.NOT_FOUND.getStatusCode()).entity(Errors.INVALID_TOKEN).build();
        }

        OffsetDateTime now = OffsetDateTime.now();
        if (offerToReturn.getExpireDate().compareTo(now) < 0) {
            execution.setVariable(IS_OFFER_EXPIRED, true);
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).entity(Errors.OFFER_EXPIRED).build();
        }
        execution.setVariable(USER_OFFER, offerToReturn);
        return Response.status(Response.Status.OK.getStatusCode()).entity(OfferDTO.fromOffer(offerToReturn)).build();
    }

    /**
     * inizia la procedura di pagamento dell'offerta di volo
     */
    public void startPaymentRequest(AddressDTO address, AsyncResponse response) {
        String email = securityContext.getCallerPrincipal().getName();

        try {
            databaseManager.getOfferByTokenEmail(address.getOfferToken(), email);
        } catch (OfferNotFoundException e) {
            response.resume(Response.status(Response.Status.NOT_FOUND.getStatusCode()).build());
            return;
        }

        Integer processActive = (Integer) processState.getState(PROCESS_CONFIRM_BUY_OFFER, email,
                address.getOfferToken());
        if (processActive == null) {
            response.resume(Response.status(Response.Status.METHOD_NOT_ALLOWED.getStatusCode()).build());
            return;
        }
        if (processActive == 2) {
            response.resume(Response.status(Response.Status.CONFLICT.getStatusCode()).build());
            return;
        }

        processState.setState(PROCESS_CONFIRM_BUY_OFFER, email, address.getOfferToken(), 2);
        processState.setState(PROCESS_CONFIRM_BUY_OFFER, email, ASYNC_RESPONSE, response);

        Map<String, Object> processVariables = new HashMap<String, Object>();
        processVariables.put(USER_ADDRESS, address);

        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        runtimeService.correlateMessage(PAY_OFFER, PROCESS_CONFIRM_BUY_OFFER + email + address.getOfferToken(),
                processVariables);
    }

    /**
     * ferma il processo di pagamento a seguito di un qualche errore
     * 
     * @param offer
     * @param response
     */
    public void resetProcess(UserOfferDTO offer, AsyncResponse response) {
        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        String email = securityContext.getCallerPrincipal().getName();
        try {
            databaseManager.getOfferByTokenEmail(offer.getOfferToken(), email);
        } catch (OfferNotFoundException e) {
            response.resume(Response.status(Response.Status.NOT_FOUND.getStatusCode()).build());
            return;
        }

        Integer processActive = (Integer) processState.getState(PROCESS_CONFIRM_BUY_OFFER, email,
                offer.getOfferToken());
        if (processActive == null) {
            response.resume(Response.status(Response.Status.NOT_FOUND.getStatusCode()).build());
            return;
        }
        response.resume(Response.status(Response.Status.OK.getStatusCode()).build());
        if (processActive == 1) {
            runtimeService.correlateMessage(RESET_1, PROCESS_CONFIRM_BUY_OFFER + email + offer.getOfferToken());
        }
        if (processActive == 2) {
            runtimeService.correlateMessage(RESET_2, PROCESS_CONFIRM_BUY_OFFER + email + offer.getOfferToken());
        }
    }

    /**
     * recupera l'offerta di volo che l'utente vuole confermare dal token
     * specificato come argomento della funzione
     * 
     * @param token
     * @return
     */
    public Response requestOffer(String token) {
        String email = securityContext.getCallerPrincipal().getName();
        try {
            GeneratedOffer offer = databaseManager.getOfferByTokenEmail(token, email);
            if (offer.getBooked()) {
                return Response.status(Response.Status.OK.getStatusCode()).entity(OfferDTO.fromOffer(offer)).build();
            } else {
                return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
            }
        } catch (OfferNotFoundException e) {
            return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
        }
    }

    /**
     * recupera tutte le offerte generate per l'utente
     */
    public Response requestOffers() {
        String email = securityContext.getCallerPrincipal().getName();
        List<GeneratedOffer> offers = (List<GeneratedOffer>) databaseManager.getOffersByEmail(email);
        offers.removeIf(offer -> !offer.getBooked());
        List<OfferDTO> out = offers.stream().map((offer) -> OfferDTO.fromOffer(offer)).collect(Collectors.toList());
        return Response.status(Response.Status.OK.getStatusCode()).entity(out).build();
    }

    /**
     * recupera il biglietto dell'offerta di volo con il token fornito come
     * parametro
     */
    public Response requestTicket(String token) {
        String email = securityContext.getCallerPrincipal().getName();
        try {
            GeneratedOffer offer = databaseManager.getOfferByTokenEmail(token, email);
            if (offer.getBooked()) {
                File file = new File(offer.getToken() + ".pdf");
                return Response.ok(file, MediaType.APPLICATION_OCTET_STREAM)
                        .header("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"").build();
            }
            return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
        } catch (OfferNotFoundException e) {
        }
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

    /**
     * si occupa della prenotazione del servizio di rent per il volo di andata e
     * ritorno dell'offerta dell'utente il cui indirizzo e la cui email è
     * specificata come argomento della funzione
     */
    public void bookAllRent(String email, AddressDTO address, GeneratedOffer offer, DelegateExecution execution)
            throws UserNotFoundException {
        User user = databaseManager.getUser(email);
        String userAddress = address.getAddress() + ", " + address.getPostCode() + " " + address.getCityName() + ", "
                + address.getCountry();
        Airport airport = offer.getOutboundFlight().getDepartureAirport();
        String airportAddress = String.valueOf(airport.getLatitude()) + ',' + String.valueOf(airport.getLongitude());
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
        String dateTimeOutbound = fmt.format(offer.getOutboundFlight().getDepartureDateTime());
        String dateTimeFligntBack = fmt.format(offer.getFlightBack().getArrivalDateTime());

        List<RentService> rentServices = databaseManager.getAllRentServices();
        // Outbound
        for (RentService rent : rentServices) {
            String name = rent.getEntity().getUsername();
            BookRentResponse response = rentClient.bookRent(name, user, userAddress, airportAddress, dateTimeOutbound);
            if (response.getStatus().equals("OK")) {
                execution.setVariable(RENT_OUTBOUND, response);
                break;
            }
        }

        // Flyback
        for (RentService rent : rentServices) {
            String name = rent.getEntity().getUsername();
            BookRentResponse response = rentClient.bookRent(name, user, airportAddress, userAddress,
                    dateTimeFligntBack);
            if (response.getStatus().equals("OK")) {
                execution.setVariable(RENT_BACK, response);
                break;
            }
        }
        offer.setRent(true);
    }

    /**
     * imposta un'offerta di volo come offerta prenotata dall'utente a cui è
     * destinata
     */
    public void setBooked(GeneratedOffer offer) {
        offer.setBooked(true);
        offer.setAvailable(false);
        offer.getOutboundFlight().setBooked(true);
        offer.getOutboundFlight().setAvailable(false);
        offer.getFlightBack().setBooked(true);
        offer.getFlightBack().setAvailable(false);
        databaseManager.updateOffer(offer);
    }

    public class DistanceServiceException extends Exception {
    }

    public class SendTicketException extends Exception {
    }

}