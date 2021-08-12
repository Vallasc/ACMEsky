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
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.runtime.ProcessInstanceWithVariables;
import javax.security.enterprise.SecurityContext;
import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.gateway.airline.AirlineClient;
import it.unibo.soseng.gateway.airline.AirlineClient.AirlineErrorException;
import it.unibo.soseng.gateway.airline.dto.AirlineFlightOfferDTO;
import it.unibo.soseng.gateway.airline.dto.InterestDTO;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.AirlineNotFoundException;
import it.unibo.soseng.logic.database.DatabaseManager.AirportNotFoundException;
import it.unibo.soseng.logic.offer.OfferManager.SendTicketException;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.utils.Errors;
import static it.unibo.soseng.camunda.utils.Events.SAVE_LAST_MINUTE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.AIRLINE_FLIGHT_OFFERS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.AIRLINE_NAME;
import static it.unibo.soseng.camunda.utils.ProcessVariables.URI_INFO;
import static it.unibo.soseng.camunda.utils.ProcessVariables.ASYNC_RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_SAVE_LAST_MINUTE_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_ERROR;

@Stateless
public class AirlineManager {
    private final static Logger LOGGER = Logger.getLogger(AirlineManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;
    @Inject
    private SecurityContext securityContext;
    @Inject
    private ProcessState processState;

    @Inject
    AirlineClient client;

    // Camunda
    public void startSaveLastMinuteOffer(List<AirlineFlightOfferDTO> request) 
    throws BadRequestException{
        LOGGER.info("StartSaveLastMinuteProcess");
        String airlineCompanyName = securityContext.getCallerPrincipal().getName();
        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        Map<String,Object> processVariables = new HashMap<String,Object>();

        processVariables.put(AIRLINE_FLIGHT_OFFERS, request);
        processVariables.put(AIRLINE_NAME, airlineCompanyName);  
        // Start the process instance
        ProcessInstanceWithVariables instance = runtimeService.createProcessInstanceByKey(SAVE_LAST_MINUTE)
                                                                .setVariables(processVariables)
                                                                .executeWithVariablesInReturn();
        processVariables = instance.getVariables();
        String error = (String) processVariables.get(PROCESS_ERROR);
        if(error != null)
            throw new BadRequestException();
        
    }

    public void handleConfirmLastMinuteOffer(String airlineName, List<AirlineFlightOfferDTO>  airlineOffers) {
        // Control date time
        List<Flight> flights = new ArrayList<>();
        for (int i = 0; i < airlineOffers.size (); i++) {
            try {
                Flight flight = new Flight ();
                flight.setAirline(databaseManager.getAirline(airlineName));
                flight.setArrivalAirport(databaseManager.getAirport(airlineOffers.get(i).getArrivalAirportCode()));
                flight.setDepartureAirport(databaseManager.getAirport(airlineOffers.get(i).getDepartureAirportCode()));
                flight.setAvailable(true);
                flight.setBooked(false);
                flight.setFlightCode(airlineOffers.get(i).getFlightCode());
                flight.setPrice(airlineOffers.get(i).getPrice());
                flight.setDepartureDateTime(airlineOffers.get(i).getDepartureOffsetDateTime());
                flight.setArrivalDateTime(airlineOffers.get(i).getArrivalOffsetDateTime());
                flight.setExpireDate(airlineOffers.get(i).getExpiredOffsetDateTime());
                // Control date time
                OffsetDateTime now = OffsetDateTime.now();

                if(flight.getExpireDate().compareTo(now) > 0 ) {
                   flights.add(flight);
                }
                
                
  
            } catch (AirportNotFoundException | AirlineNotFoundException e1 ) {
                LOGGER.warning(e1.toString());
            } 

        }

        databaseManager.insertFlightOffer(flights);    
    }
    public void saveAirlineOffers(List<AirlineFlightOfferDTO> airlineLastMinuteOffers, String airlineName){
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
            for(JsonNode node: root){
                Flight f = new Flight();
                try{
                f.setDepartureAirport(databaseManager.getAirport(node.get("departureCode").textValue()));
 
                OffsetDateTime departureDateTime = OffsetDateTime.parse(node.get("departureTime").textValue());
                f.setDepartureDateTime(departureDateTime);
                f.setArrivalAirport(databaseManager.getAirport(node.get("arrivalCode").textValue()));
 
                OffsetDateTime arrivalDateTime = OffsetDateTime.parse(node.get("arrivalTime").textValue());
                f.setArrivalDateTime(arrivalDateTime);
                f.setAirline(databaseManager.getAirline(node.get("airline_id").textValue()));
                f.setPrice(node.get("price").floatValue());
 
                OffsetDateTime expireDateTime = OffsetDateTime.parse(node.get("expDate").textValue());
                f.setExpireDate(expireDateTime);
                f.setBooked(false);
                f.setAvailable(true);
                f.setFlightCode(node.get("id").asText());
                list.add(f);
                } catch (AirportNotFoundException e) {
                    LOGGER.info("Airport not found: "+
                    node.get("departureCode").textValue()+" or " + node.get("arrivalCode").textValue());
                } catch (AirlineNotFoundException e) {
                    LOGGER.info("Airline not found: " + node.get("airline_id").textValue());
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
