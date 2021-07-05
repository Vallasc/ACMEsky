package it.unibo.soseng.logic.airline;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.security.enterprise.SecurityContext;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;

import it.unibo.soseng.gateway.airline.AirlineClient;
import it.unibo.soseng.gateway.airline.dto.AirlineDTO;
import it.unibo.soseng.gateway.airline.dto.AirlineFlightOffer;
import it.unibo.soseng.gateway.airline.dto.InterestDTO;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.AirlineNotFoundException;
import it.unibo.soseng.logic.database.DatabaseManager.AirportNotFoundException;
import it.unibo.soseng.model.Airline;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;


import static it.unibo.soseng.camunda.StartEvents.SAVE_LAST_MINUTE;

import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_FLIGHT_OFFERS;
import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_NAME;

@Stateless
public class AirlineManager {
    private final static Logger LOGGER = Logger.getLogger(AirlineManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;
    
    @Inject
    private SecurityContext securityContext;

    @Inject
    AirlineClient api;

    // Camunda
    public void startSaveLastMinuteProcess(List<AirlineFlightOffer> airlineLastMinuteOffers, String airlineName){
        LOGGER.info("StartSaveLastMinuteProcess");
        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        Map<String,Object> processVariables = new HashMap<String,Object>();
        processVariables.put(AIRLINE_FLIGHT_OFFERS, airlineLastMinuteOffers);
        processVariables.put(AIRLINE_NAME, airlineName);
        runtimeService.startProcessInstanceByMessage(SAVE_LAST_MINUTE, processVariables);
    }


    public void saveAirlineOffers(List<AirlineFlightOffer> airlineLastMinuteOffers, String airlineName){
        LOGGER.log(Level.INFO, "Save offer of airline {0}", airlineName);
    }

    public List<InterestDTO> convertIntToIntDTO(List<FlightInterest> interests) {
        ArrayList<InterestDTO> list = new ArrayList<>();
        for(FlightInterest i : interests){
            InterestDTO dto = new InterestDTO(i.getDepartureAirport().getAirportCode(), i.getArrivalAirport().getAirportCode(),
                                                    i.getDepartureDateTime().toString()); 
            list.add(dto);
        }
        return list;
    }


    public List<AirlineDTO> convertToAirlineDTO(List<Airline> airlines) {
        ArrayList<AirlineDTO> list = new ArrayList<>();
        for(Airline i : airlines){
            AirlineDTO dto = new AirlineDTO(i.getId(), i.getWsAddress()); 
            list.add(dto);
        }
        return list;
    }

    public List<Flight> retrieveFlightsList(List<InterestDTO> listDTO, String wsAddress) throws IOException, InterruptedException, AirportNotFoundException, AirlineNotFoundException {
        String resp = api.getFlightList(listDTO, wsAddress);
        List<Flight> list = new ArrayList<>();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(resp);
        for(JsonNode n: root){
            Flight f = new Flight();
                f.setDepartureAirport(databaseManager.getAirport(n.get("departureCode").textValue()));
                f.setDepartureDateTime(n.get("departureTime").textValue());
                f.setArrivalAirport(databaseManager.getAirport(n.get("arrivalCode").textValue()));
                f.setArrivalDateTime(n.get("arrivalTime").textValue());
                f.setAirline(databaseManager.getAirline(n.get("airline_id").textValue()));
                f.setPrice(n.get("price").floatValue());
                f.setExpireDate(n.get("expDate").textValue());
                f.setBooked(false);
                f.setFlightCode(n.get("id").asText());
                list.add(f);
            }
        return list;
    }

    public class UserNotAllowedException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    public class BadRequestException extends Exception {
        private static final long serialVersionUID = 1L;
    }

}
