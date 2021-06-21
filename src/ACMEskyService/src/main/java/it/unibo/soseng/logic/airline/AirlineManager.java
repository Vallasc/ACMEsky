package it.unibo.soseng.logic.airline;

import java.io.IOException;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.security.enterprise.SecurityContext;

import com.fasterxml.jackson.databind.node.ArrayNode;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.runtime.ProcessInstance;
import org.camunda.bpm.engine.runtime.ProcessInstanceWithVariables;
import org.camunda.bpm.engine.task.Task;

import it.unibo.soseng.gateway.airline.AirlineAPI;
import it.unibo.soseng.gateway.airline.dto.AirlineFlightOffer;
import it.unibo.soseng.gateway.airline.dto.InterestDTO;
import it.unibo.soseng.gateway.user.dto.InterestsRequest;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.AirportNotFoundException;
import it.unibo.soseng.logic.database.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.model.Airport;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.User;
import it.unibo.soseng.model.UserInterest;

import static it.unibo.soseng.camunda.StartEvents.SAVE_LAST_MINUTE;
import static it.unibo.soseng.camunda.StartEvents.SAVE_INTERESTS;

import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_FLIGHT_OFFERS;
import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_NAME;

import static it.unibo.soseng.camunda.ProcessVariables.USER_INTERESTS_REQUEST;
import static it.unibo.soseng.camunda.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.ProcessVariables.PROCESS_ERROR;

@Stateless
public class AirlineManager {
    private final static Logger LOGGER = Logger.getLogger(AirlineManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;
    
    @Inject
    private SecurityContext securityContext;

    @Inject
    AirlineAPI api;

    // Camunda
    public void startSaveLastMinuteProcess(List<AirlineFlightOffer> airlineLastMinuteOffers, String airlineName){
        LOGGER.info("StartSaveLastMinuteProcess");
        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        Map<String,Object> processVariables = new HashMap<String,Object>();
        processVariables.put(AIRLINE_FLIGHT_OFFERS, airlineLastMinuteOffers);
        processVariables.put(AIRLINE_NAME, airlineName);
        runtimeService.startProcessInstanceByMessage(SAVE_LAST_MINUTE, processVariables);
    }

    //Camunda
    public void startSaveUserInterests(InterestsRequest userInterestsRequest, String username) 
                                                                throws UserNotAllowedException, BadRequestException{
        LOGGER.info("StartSaveUserInterests");

        String loginName = securityContext.getCallerPrincipal().getName();
        if(!username.equals(loginName))
            throw new UserNotAllowedException();

        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        
        Map<String,Object> processVariables = new HashMap<String,Object>();
        processVariables.put(USER_INTERESTS_REQUEST, userInterestsRequest);
        processVariables.put(USERNAME, username);
  
        // Start the process instance
        ProcessInstanceWithVariables instance = runtimeService.createProcessInstanceByKey(SAVE_INTERESTS)
                                                            .setVariables(processVariables)
                                                            .executeWithVariablesInReturn();
        processVariables = instance.getVariables();
        String error = (String) processVariables.get(PROCESS_ERROR);
        if(error != null)
            throw new BadRequestException();
    }

    public void saveAirlineOffers(List<AirlineFlightOffer> airlineLastMinuteOffers, String airlineName){
        LOGGER.log(Level.INFO, "Save offer of airline {0}", airlineName);
    }

    public void saveUserInterests(InterestsRequest request, String username) 
                            throws AirportNotFoundException, UserNotFoundException {

        // Check airport
        Airport airportOut1 = databaseManager.getAirport(request.getOutboundFlight().getArrivalAirportCode());
        Airport airportOut2 = databaseManager.getAirport(request.getOutboundFlight().getDepartureAirportCode());
        Airport airportBack1 = null;
        Airport airportBack2 = null;
        if(request.getFlightBack() != null){
            airportBack1 = databaseManager.getAirport(request.getFlightBack().getArrivalAirportCode());
            airportBack2 = databaseManager.getAirport(request.getFlightBack().getDepartureAirportCode());
        }

        // Get User
        User user = databaseManager.getUser(username);

        UserInterest interest = new UserInterest();

        FlightInterest flightOutInterest = new FlightInterest();
        flightOutInterest.setUser(user);
        flightOutInterest.setDepartureAirport(airportOut1);
        flightOutInterest.setArrivalAirport(airportOut2);

        flightOutInterest.setDepartureDateTime(
            ZonedDateTime.ofInstant(Instant.ofEpochMilli(request.getOutboundFlight().getDepartureTimestamp()), 
            ZoneId.systemDefault()).toOffsetDateTime());
        flightOutInterest.setArrivalDateTime(
            ZonedDateTime.ofInstant(Instant.ofEpochMilli(request.getOutboundFlight().getArrivalTimestamp()), 
            ZoneId.systemDefault()).toOffsetDateTime());
        
        interest.setFlightBackInterest(flightOutInterest);

        if(request.getFlightBack() != null){
            FlightInterest flightBackInterest = new FlightInterest();
            flightBackInterest.setUser(user);
            flightBackInterest.setDepartureAirport(airportBack1);
            flightBackInterest.setArrivalAirport(airportBack2);
    
            flightBackInterest.setDepartureDateTime(
                ZonedDateTime.ofInstant(Instant.ofEpochMilli(request.getFlightBack().getDepartureTimestamp()), 
                ZoneId.systemDefault()).toOffsetDateTime());
                flightBackInterest.setArrivalDateTime(
                ZonedDateTime.ofInstant(Instant.ofEpochMilli(request.getFlightBack().getArrivalTimestamp()), 
                ZoneId.systemDefault()).toOffsetDateTime());

            interest.setFlightBackInterest(flightBackInterest);
        }

        databaseManager.saveUserInterest(interest);
    }

    public class UserNotAllowedException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    public class BadRequestException extends Exception {
        private static final long serialVersionUID = 1L;
    }
}
