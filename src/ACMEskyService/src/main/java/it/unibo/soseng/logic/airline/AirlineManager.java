package it.unibo.soseng.logic.airline;

import java.io.IOException;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ListIterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import javax.ejb.Stateless;
import javax.inject.Inject;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;

import it.unibo.soseng.gateway.airline.AirlineClient;
import it.unibo.soseng.gateway.airline.AirlineClient.AirlineErrorException;
import it.unibo.soseng.gateway.airline.dto.AirlineFlightOffer;
import it.unibo.soseng.gateway.airline.dto.InterestDTO;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.AirlineNotFoundException;
import it.unibo.soseng.logic.database.DatabaseManager.AirportNotFoundException;
import it.unibo.soseng.logic.offer.OfferManager.SendTicketException;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.utils.Events.SAVE_LAST_MINUTE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.AIRLINE_FLIGHT_OFFERS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.AIRLINE_NAME;

@Stateless
public class AirlineManager {
    private final static Logger LOGGER = Logger.getLogger(AirlineManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;
    

    @Inject
    AirlineClient client;

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
            InterestDTO dto = new InterestDTO(i.getDepartureAirport().getAirportCode(), 
                                            i.getArrivalAirport().getAirportCode(),
                                            i.getDepartureDateTime().toString()); 
            list.add(dto);
        }
        return list;
    }

    public List<Flight> retrieveFlightsList(List<InterestDTO> listDTO, String wsAddress) {
        List<Flight> list = new ArrayList<>();
        ObjectMapper mapper = new ObjectMapper();
        try{
            String resp = client.getFlightList(listDTO, wsAddress);
            JsonNode root = mapper.readTree(resp);
            for(JsonNode n: root){
                Flight f = new Flight();
                try{
                f.setDepartureAirport(databaseManager.getAirport(n.get("departureCode").textValue()));
                f.setDepartureDateTime(n.get("departureTime").textValue());
                f.setArrivalAirport(databaseManager.getAirport(n.get("arrivalCode").textValue()));
                f.setArrivalDateTime(n.get("arrivalTime").textValue());
                f.setAirline(databaseManager.getAirline(n.get("airline_id").textValue()));
                f.setPrice(n.get("price").floatValue());
                f.setExpireDate(n.get("expDate").textValue());
                f.setBooked(false);
                f.setAvailable(true);
                f.setFlightCode(n.get("id").asText());
                list.add(f);
                } catch (AirportNotFoundException e) {
                    LOGGER.info("Airport not found: "+
                                n.get("departureCode").textValue()+" or " + n.get("arrivalCode").textValue());
                } catch (AirlineNotFoundException e) {
                    LOGGER.info("Airline not found: " + n.get("airline_id").textValue());
                }
            }
        } catch (InterruptedException | IOException | AirlineErrorException e) {
            LOGGER.info("IOException contacting airline:" + wsAddress);
        }
        return list;
    }

    public void removeExpiredFlights() {
        OffsetDateTime now = OffsetDateTime.now();
        List<Flight> expFlights = databaseManager.getAvailableFlights().stream().dropWhile(f -> f.getExpireDate().isBefore(now)).collect(Collectors.toList());
        for (ListIterator<Flight> iter = expFlights.listIterator(); iter.hasNext(); ) {
            Flight f = iter.next();
            f.setAvailable(false);
            databaseManager.updateFlight(f);
        }
    }

    public byte[] getOfferTicket(GeneratedOffer offer) throws IOException, SendTicketException{

        byte[] fileByte = client.getFlightTickets(offer.getOutboundFlightId().getAirlineId().getWsAddress(), offer.getUser().getProntogramUsername(), offer.getOutboundFlightId().getFlightCode(), 
                                                offer.getFlightBackId().getFlightCode());
        offer.setBooked(true);
        return fileByte;
    }


    public void unbookOffer(GeneratedOffer offer) throws IOException {
        
        client.unbookFlights(offer);
        offer.setBooked(false);
        offer.getOutboundFlightId().setBooked(false);
        offer.getFlightBackId().setBooked(false);
        //TODO fare richiesta fittizia ad airline
    }



    public class UserNotAllowedException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    public class BadRequestException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    

}
