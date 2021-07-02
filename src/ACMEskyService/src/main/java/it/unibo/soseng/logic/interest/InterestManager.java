package it.unibo.soseng.logic.interest;

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

import it.unibo.soseng.camunda.ProcessState;
import it.unibo.soseng.camunda.ProcessState.AsyncResponseDTO;
import it.unibo.soseng.gateway.user.dto.AirportDTO;
import it.unibo.soseng.gateway.user.dto.UserInterestDTO;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.AirportNotFoundException;
import it.unibo.soseng.logic.database.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.model.Airport;
import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.User;
import it.unibo.soseng.model.UserInterest;
import it.unibo.soseng.util.Env;
import it.unibo.soseng.util.Errors;

import static it.unibo.soseng.camunda.StartEvents.SAVE_INTERESTS;

import static it.unibo.soseng.camunda.ProcessVariables.USER_INTERESTS_REQUEST;
import static it.unibo.soseng.camunda.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.ProcessVariables.PROCESS_ERROR;

@Stateless
public class InterestManager {
    
    private final static Logger LOGGER = Logger.getLogger(InterestManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;
    
    @Inject
    private SecurityContext securityContext;

    @Inject
    private ProcessState processState;

    // Start Camunda process
    public void startSaveUserInterests(UserInterestDTO request, AsyncResponse response, UriInfo uriInfo) 
                                                                throws BadRequestException{
        LOGGER.info("StartSaveUserInterests");
        String email = securityContext.getCallerPrincipal().getName();

        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        
        Map<String,Object> processVariables = new HashMap<String,Object>();
        processVariables.put(USER_INTERESTS_REQUEST, request);
        processVariables.put(USERNAME, email);
        processState.setResponse(email, response, uriInfo);
  
        // Start the process instance
        ProcessInstanceWithVariables instance = runtimeService.createProcessInstanceByKey(SAVE_INTERESTS)
                                                            .setVariables(processVariables)
                                                            .executeWithVariablesInReturn();
        processVariables = instance.getVariables();
        String error = (String) processVariables.get(PROCESS_ERROR);
        if(error != null)
            throw new BadRequestException();
    }   

    public Response handleUserInterests(AsyncResponseDTO response, String username, UserInterestDTO interest){
        // Control date time
        OffsetDateTime now = OffsetDateTime.now();
        OffsetDateTime outboundDateTime = interest.getOutboundFlight().getDepartureOffsetDateTime();
        if(interest.getFlightBack() != null){
            OffsetDateTime flightBackDateTime = interest.getFlightBack().getDepartureOffsetDateTime();
            flightBackDateTime = flightBackDateTime.minusDays(1);
            if(outboundDateTime.compareTo(flightBackDateTime) > 0)
                return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
                                .entity(Errors.DATE_ERROR)
                                .build();
        }
        if( outboundDateTime.compareTo(now) < 0 ){
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
                .entity(Errors.DATE_TO_EARLY)
                .build();
        }
        OffsetDateTime end = now.plusDays(Env.INTEREST_WINDOW);
        if( outboundDateTime.compareTo(end) > 0 ){
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
                .entity(Errors.DATE_TO_LATE)
                .build();
        }
        // Control Airport codes
        if( interest.getFlightBack() != null &&
            ( interest.getOutboundFlight().getArrivalAirportCode().compareTo(
            interest.getFlightBack().getDepartureAirportCode()) != 0 ||
            interest.getOutboundFlight().getDepartureAirportCode().compareTo(
            interest.getFlightBack().getArrivalAirportCode()) != 0) ){
                return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
                    .entity(Errors.AIRPORT_CODE_ERROR)
                    .build();
        }
        try {
            UserInterest userInterest = this.saveUserInterests(username, interest);
            UriInfo uriInfo = (UriInfo) response.getCompanion();
            return Response.status(Response.Status.CREATED.getStatusCode())
                    .header("Location", String.format("%s/%s", uriInfo.getAbsolutePath().toString(), userInterest.getId()))
                    .build();
        } catch (AirportNotFoundException e) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
                            .entity(Errors.AIRPORT_NOT_FOUND)
                            .build();
        } catch (UserNotFoundException e) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
                            .entity(Errors.USER_NOT_FOUND)
                            .build();
        } catch (DateTimeParseException e){
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode())
                            .entity(Errors.DATE_FORMAT_ERROR)
                            .build();
        }
    }

    public UserInterest saveUserInterests(String username, UserInterestDTO request) throws AirportNotFoundException, UserNotFoundException, DateTimeParseException {

        // Check airport
        Airport airportOut1 = databaseManager.getAirport(request.getOutboundFlight().getArrivalAirportCode());
        Airport airportOut2 = databaseManager.getAirport(request.getOutboundFlight().getDepartureAirportCode());
        Airport airportBack1 = null;
        Airport airportBack2 = null;
        if(request.getFlightBack() != null){
            airportBack1 = databaseManager.getAirport(request.getFlightBack().getArrivalAirportCode());
            airportBack2 = databaseManager.getAirport(request.getFlightBack().getDepartureAirportCode());
        }

        String email = securityContext.getCallerPrincipal().getName();
        
        // Get User
        User user = databaseManager.getUser(email);

        UserInterest interest = new UserInterest();

        interest.setExpireDate(request.getOutboundFlight().getDepartureOffsetDateTime());
        interest.setUser(user);

        FlightInterest flightOutInterest = new FlightInterest();
        flightOutInterest.setUser(user);
        flightOutInterest.setDepartureAirport(airportOut1);
        flightOutInterest.setArrivalAirport(airportOut2);

        flightOutInterest.setDepartureDateTime(request.getOutboundFlight().getDepartureOffsetDateTime());

        interest.setOutboundFlightInterest(flightOutInterest);

        if(request.getFlightBack() != null){
            FlightInterest flightBackInterest = new FlightInterest();
            flightBackInterest.setUser(user);
            flightBackInterest.setDepartureAirport(airportBack1);
            flightBackInterest.setArrivalAirport(airportBack2);

            flightBackInterest.setDepartureDateTime(request.getFlightBack().getDepartureOffsetDateTime());

            interest.setFlightBackInterest(flightBackInterest);
        }

        databaseManager.saveUserInterest(interest);
        return interest;
    }

    public List<UserInterestDTO> getUserInterests(){
        String email = securityContext.getCallerPrincipal().getName();
        List<UserInterest> interests = databaseManager.getUserInterests(email);
        return interests.stream()
                .map( interest -> UserInterestDTO.from(interest) )
                .collect(Collectors.toList());
    }

    public UserInterestDTO getUserInterest(String id){
        String email = securityContext.getCallerPrincipal().getName();
        UserInterest interest = databaseManager.getUserInterest(email, id);
        return UserInterestDTO.from(interest);
    }

    public List<AirportDTO> getAirportsFromQuery(String query){
        List<Airport> airports = databaseManager.getAirportsFromQuery(query);
        return airports.stream()
                .map( airport -> AirportDTO.from(airport) )
                .collect(Collectors.toList());
    }

    public AirportDTO getAirport(String code) throws AirportNotFoundException{
        Airport airport = databaseManager.getAirport(code);
        return AirportDTO.from(airport);
    }

    public class BadRequestException extends Exception {
        private static final long serialVersionUID = 1L;
    }

}
