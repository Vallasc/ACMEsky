package it.unibo.soseng.logic;

import java.time.OffsetDateTime;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.security.enterprise.SecurityContext;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.runtime.ProcessInstanceWithVariables;

import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.gateway.user.dto.AirportDTO;
import it.unibo.soseng.gateway.user.dto.UserInterestDTO;
import it.unibo.soseng.logic.DatabaseManager.AirportNotFoundException;
import it.unibo.soseng.logic.DatabaseManager.InterestNotFoundException;
import it.unibo.soseng.logic.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.model.Airport;
import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.User;
import it.unibo.soseng.model.UserInterest;
import it.unibo.soseng.utils.Env;
import it.unibo.soseng.utils.Errors;

import static it.unibo.soseng.camunda.utils.Events.SAVE_INTERESTS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.ASYNC_RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_ERROR;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_SAVE_INTEREST;
import static it.unibo.soseng.camunda.utils.ProcessVariables.URI_INFO;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_INTERESTS_REQUEST;

/**
 * Logica che utilizza le classi del model e del gateway per gestire gli
 * interessi degli utenti
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

@Stateless
public class InterestManager {

    private final static Logger LOGGER = Logger.getLogger(InterestManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;

    @Inject
    private SecurityContext securityContext;

    @Inject
    private ProcessState processState;

    /**
     * Start Camunda process
     * 
     * avvia la procedura di salvataggio dell'offerta di volo di interesse
     * dell'utente generando il processo Camunda che si occuperà di salvarla in DB
     * 
     * @param request
     * @param response
     * @param uriInfo
     * @throws BadRequestException
     */
    public void startSaveUserInterests(UserInterestDTO request, AsyncResponse response, UriInfo uriInfo)
            throws BadRequestException {

        LOGGER.info("StartSaveUserInterests");
        String email = securityContext.getCallerPrincipal().getName();

        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();

        Map<String, Object> processVariables = new HashMap<String, Object>();
        processVariables.put(USER_INTERESTS_REQUEST, request);
        processVariables.put(USERNAME, email);
        processState.setState(PROCESS_SAVE_INTEREST, email, URI_INFO, uriInfo);
        processState.setState(PROCESS_SAVE_INTEREST, email, ASYNC_RESPONSE, response);

        // Start the process instance
        ProcessInstanceWithVariables instance = runtimeService.createProcessInstanceByKey(SAVE_INTERESTS)
                .setVariables(processVariables).executeWithVariablesInReturn();
        processVariables = instance.getVariables();
        String error = (String) processVariables.get(PROCESS_ERROR);
        if (error != null)
            throw new BadRequestException();
    }

    /**
     * effettua i controlli necessari sull'offerta di volo da salvare in DB
     * 
     * @param username
     * @param interest
     * @return
     */
    public Response handleUserInterests(String username, UserInterestDTO interest) {
        // Control date time
        OffsetDateTime now = OffsetDateTime.now();
        OffsetDateTime outboundDateTime = interest.getOutboundFlight().getDepartureOffsetDateTime();
        OffsetDateTime flightBackDateTime = interest.getFlightBack().getDepartureOffsetDateTime();
        flightBackDateTime = flightBackDateTime.minusDays(1);
        if (outboundDateTime.compareTo(flightBackDateTime) > 0) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).entity(Errors.DATE_ERROR).build();
        }

        if (outboundDateTime.compareTo(now) < 0) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).entity(Errors.DATE_TO_EARLY).build();
        }

        OffsetDateTime end = now.plusDays(Env.INTEREST_WINDOW);
        if (outboundDateTime.compareTo(end) > 0) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).entity(Errors.DATE_TO_LATE).build();
        }
        // Control Airport codes
        if (interest.getOutboundFlight().getArrivalAirportCode()
                .compareTo(interest.getFlightBack().getDepartureAirportCode()) != 0
                || interest.getOutboundFlight().getDepartureAirportCode()
                        .compareTo(interest.getFlightBack().getArrivalAirportCode()) != 0) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).entity(Errors.AIRPORT_CODE_ERROR)
                    .build();
        }

        try {
            UserInterest userInterest = this.saveUserInterests(username, interest);

            UriInfo uriInfo = (UriInfo) processState.getState(PROCESS_SAVE_INTEREST, username, URI_INFO);
            return Response.status(Response.Status.CREATED.getStatusCode()).header("Location",
                    String.format("%s/%s", uriInfo.getAbsolutePath().toString(), userInterest.getId())).build();
        } catch (AirportNotFoundException e) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).entity(Errors.AIRPORT_NOT_FOUND)
                    .build();
        } catch (UserNotFoundException e) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).entity(Errors.USER_NOT_FOUND).build();
        } catch (DateTimeParseException e) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).entity(Errors.DATE_FORMAT_ERROR)
                    .build();
        }
    }

    /**
     * prepara l'offerta di interesse dell'utente generando gli oggetti dei campi
     * che la formano e ne richiede il salvataggio al DbManager
     * 
     * @param username
     * @param request
     * @return
     * @throws AirportNotFoundException
     * @throws UserNotFoundException
     * @throws DateTimeParseException
     */
    public UserInterest saveUserInterests(String username, UserInterestDTO request)
            throws AirportNotFoundException, UserNotFoundException, DateTimeParseException {

        // Check airport
        Airport airportOut1 = databaseManager.getAirport(request.getOutboundFlight().getDepartureAirportCode());
        Airport airportOut2 = databaseManager.getAirport(request.getOutboundFlight().getArrivalAirportCode());

        Airport airportBack1 = databaseManager.getAirport(request.getFlightBack().getDepartureAirportCode());
        Airport airportBack2 = databaseManager.getAirport(request.getFlightBack().getArrivalAirportCode());

        String email = securityContext.getCallerPrincipal().getName();

        // Get User
        User user = databaseManager.getUser(email);

        UserInterest interest = new UserInterest();
        interest.setUsed(false);

        interest.setExpireDate(request.getOutboundFlight().getDepartureOffsetDateTime());
        interest.setUser(user);

        interest.setPriceLimit(request.getPriceLimit());

        FlightInterest flightOutInterest = new FlightInterest();
        flightOutInterest.setUsed(false);
        flightOutInterest.setUser(user);
        flightOutInterest.setDepartureAirport(airportOut1);
        flightOutInterest.setArrivalAirport(airportOut2);
        flightOutInterest.setDepartureDateTime(request.getOutboundFlight().getDepartureOffsetDateTime());

        interest.setOutboundFlightInterest(flightOutInterest);

        FlightInterest flightBackInterest = new FlightInterest();
        flightBackInterest.setUsed(false);
        flightBackInterest.setUser(user);
        flightBackInterest.setDepartureAirport(airportBack1);
        flightBackInterest.setArrivalAirport(airportBack2);
        flightBackInterest.setDepartureDateTime(request.getFlightBack().getDepartureOffsetDateTime());

        interest.setFlightBackInterest(flightBackInterest);

        databaseManager.saveUserInterest(interest);
        return interest;
    }

    /**
     * recupera la lista di offerte di interesse degli utenti dal DB e la converte
     * in una lista composta dai corrispondenti oggetti DTO
     * 
     * @return
     */
    public List<UserInterestDTO> getUserInterests() {
        String email = securityContext.getCallerPrincipal().getName();
        List<UserInterest> interests = databaseManager.getUserInterests(email);
        return interests.stream().map(interest -> UserInterestDTO.from(interest)).collect(Collectors.toList());
    }

    /**
     * recupera l'offerta di volo di interesse con l'identificativo specificato
     * 
     * @param id
     * @return
     * @throws InterestNotFoundException
     */
    public UserInterestDTO getUserInterest(String id) throws InterestNotFoundException {
        String email = securityContext.getCallerPrincipal().getName();
        UserInterest interest = databaseManager.getUserInterest(email, id);
        return UserInterestDTO.from(interest);
    }

    /**
     * elimina l'offerta di volo di interesse con l'identificativo specificato
     * 
     * @param id
     * @throws InterestNotFoundException
     */
    public void deleteUserInterest(String id) throws InterestNotFoundException {
        String email = securityContext.getCallerPrincipal().getName();
        UserInterest interest = databaseManager.getUserInterest(email, id);
        interest.setUsed(true);
        interest.getFlightBackInterest().setUsed(true);
        interest.getOutboundFlightInterest().setUsed(true);
        databaseManager.updateUserInterest(interest);
    }

    /**
     * recupera la lista di aereoporti a partire dalla query specificata come
     * argomento della funzione
     * 
     * @param query
     * @return
     */
    public List<AirportDTO> getAirportsFromQuery(String query) {
        List<Airport> airports = databaseManager.getAirportsFromQuery(query);
        return airports.stream().map(airport -> AirportDTO.from(airport)).collect(Collectors.toList());
    }

    /**
     * recupera l'oggetto DTO dell'aereoporto con il codice specificato come
     * argomento della funzione
     * 
     * @param code
     * @return
     * @throws AirportNotFoundException
     */
    public AirportDTO getAirport(String code) throws AirportNotFoundException {
        Airport airport = databaseManager.getAirport(code);
        return AirportDTO.from(airport);
    }

    public class BadRequestException extends Exception {
        private static final long serialVersionUID = 1L;
    }

}
