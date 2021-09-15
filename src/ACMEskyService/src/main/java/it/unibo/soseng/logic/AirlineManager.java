package it.unibo.soseng.logic;

import java.io.IOException;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ListIterator;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.ejb.Stateless;
import javax.inject.Inject;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.runtime.ProcessInstanceWithVariables;
import javax.security.enterprise.SecurityContext;

import it.unibo.soseng.gateway.airline.AirlineClient;
import it.unibo.soseng.gateway.airline.AirlineClient.AirlineErrorException;
import it.unibo.soseng.gateway.airline.AirlineClient.BookTicketsException;
import it.unibo.soseng.gateway.airline.dto.AirlineFlightOfferDTO;
import it.unibo.soseng.gateway.airline.dto.InterestDTO;
import it.unibo.soseng.logic.DatabaseManager.AirlineNotFoundException;
import it.unibo.soseng.logic.DatabaseManager.AirportNotFoundException;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.utils.Events.SAVE_LAST_MINUTE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.AIRLINE_FLIGHT_OFFERS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.AIRLINE_NAME;

/**
 * Logica che utilizza le classi del model e del gateway per interagire con le
 * compagnie aeree
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

@Stateless
public class AirlineManager {
    private final static Logger LOGGER = Logger.getLogger(AirlineManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;

    @Inject
    private SecurityContext securityContext;

    @Inject
    private AirlineClient client;

    /**
     * Procedura che fa iniziare il processo di salvataggio dell'offerta last-minute
     * inviata dall'AirlineService del caso
     * 
     * @param request
     * @throws BadRequestException
     */
    // Camunda
    public void startSaveLastMinuteOffer(List<AirlineFlightOfferDTO> request) throws BadRequestException {
        LOGGER.info("StartSaveLastMinuteProcess");
        String airlineCompanyName = securityContext.getCallerPrincipal().getName();
        final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        Map<String, Object> processVariables = new HashMap<String, Object>();

        processVariables.put(AIRLINE_FLIGHT_OFFERS, request);
        processVariables.put(AIRLINE_NAME, airlineCompanyName);
        // Start the process instance
        ProcessInstanceWithVariables instance = runtimeService.createProcessInstanceByKey(SAVE_LAST_MINUTE)
                .setVariables(processVariables).executeWithVariablesInReturn();
        processVariables = instance.getVariables();
        // String error = (String) processVariables.get(PROCESS_ERROR);
        // if (error != null)
        // throw new BadRequestException();

    }

    /**
     * Procedura che comunica con il DB Manager al fine di convertire l'oggetto
     * ricevuto dalla compagnia aerea nel volo che verrà salvato in DB
     * 
     * @param airlineName
     * @param airlineOffers
     */

    public void handleConfirmLastMinuteOffer(String airlineName, List<AirlineFlightOfferDTO> airlineOffers) {
        // Control date time
        List<Flight> flights = new ArrayList<>();
        for (int i = 0; i < airlineOffers.size(); i++) {
            try {
                Flight flight = new Flight();
                flight.setAirline(databaseManager.getAirline(airlineOffers.get(i).getAirlineName()));
                flight.setArrivalAirport(databaseManager.getAirport(airlineOffers.get(i).getArrivalCode()));
                flight.setDepartureAirport(databaseManager.getAirport(airlineOffers.get(i).getDepartureCode()));
                flight.setAvailable(true);
                flight.setBooked(false);
                flight.setFlightCode(airlineOffers.get(i).getId());
                flight.setPrice(airlineOffers.get(i).getPrice());
                flight.setDepartureDateTime(airlineOffers.get(i).getDepartureOffsetDateTime());
                flight.setArrivalDateTime(airlineOffers.get(i).getArrivalOffsetDateTime());
                flight.setExpireDate(airlineOffers.get(i).getExpiredOffsetDateTime());
                // Control date time
                OffsetDateTime now = OffsetDateTime.now();

                if (flight.getExpireDate().compareTo(now) > 0) {
                    flights.add(flight);
                }

            } catch (AirportNotFoundException | AirlineNotFoundException e1) {
                LOGGER.warning(e1.toString());
            }

        }

        databaseManager.insertFlights(flights);
    }

    /**
     * Stampa il log dell'avvenuto salvataggio dell'offerta last-minute
     * 
     * @param airlineLastMinuteOffers
     * @param airlineName
     */
    public void saveAirlineOffers(List<AirlineFlightOfferDTO> airlineLastMinuteOffers, String airlineName) {
        LOGGER.log(Level.INFO, "Save offer of airline {0}", airlineName);
    }

    /**
     * converte il volo di interesse di un'offerta nel corrispettivo oggetto DTO
     * 
     * @param interests
     * @return
     */
    public List<InterestDTO> convertIntToIntDTO(List<FlightInterest> interests) {
        ArrayList<InterestDTO> list = new ArrayList<>();
        for (FlightInterest i : interests) {
            InterestDTO dto = new InterestDTO(i.getDepartureAirport().getAirportCode(),
                    i.getArrivalAirport().getAirportCode(), i.getDepartureDateTime().toString());
            list.add(dto);
        }
        return list;
    }

    /**
     * recupera la lista dei voli inviati ad ACMEsky in seguito ad una richiesta di
     * ricerca verso una compagnia aerea e li converte nei corrispondenti oggetti
     * registrabili sul DB
     * 
     * @param listDTO
     * @param wsAddress
     * @return
     */

    public List<Flight> retrieveFlightsList(List<InterestDTO> listDTO, String wsAddress) {
        List<Flight> list = new ArrayList<>();
        ObjectMapper mapper = new ObjectMapper();
        try {
            String resp = client.getFlightList(listDTO, wsAddress);
            JsonNode root = mapper.readTree(resp);
            for (JsonNode node : root) {
                Flight f = new Flight();
                try {
                    LOGGER.severe(node.toString());
                    f.setDepartureAirport(databaseManager.getAirport(node.get("departureCode").textValue()));

                    OffsetDateTime departureDateTime = OffsetDateTime.parse(node.get("departureTime").textValue());
                    f.setDepartureDateTime(departureDateTime);
                    f.setArrivalAirport(databaseManager.getAirport(node.get("arrivalCode").textValue()));

                    OffsetDateTime arrivalDateTime = OffsetDateTime.parse(node.get("arrivalTime").textValue());
                    f.setArrivalDateTime(arrivalDateTime);
                    f.setAirline(databaseManager.getAirline(node.get("airlineName").textValue()));
                    f.setPrice(node.get("price").floatValue());
                    OffsetDateTime expireDateTime = OffsetDateTime.parse(node.get("expDate").textValue());
                    f.setExpireDate(expireDateTime);
                    f.setBooked(false);
                    f.setAvailable(true);
                    f.setFlightCode(node.get("id").asText());
                    list.add(f);
                } catch (AirportNotFoundException e) {
                    LOGGER.info("Airport not found: " + node.get("departureCode").textValue() + " or "
                            + node.get("arrivalCode").textValue());
                } catch (AirlineNotFoundException e) {
                    LOGGER.info("Airline not found: " + node.get("airline_id").textValue());
                }
            }
        } catch (InterruptedException | IOException | AirlineErrorException e) {
            LOGGER.info("IOException contacting airline:" + wsAddress);
        }
        return list;
    }

    /**
     * rimuove i voli delle offerte scadute
     */
    public void removeExpiredFlights() {
        OffsetDateTime now = OffsetDateTime.now();
        List<Flight> expFlights = databaseManager.getAvailableFlights();
        for (ListIterator<Flight> iter = expFlights.listIterator(); iter.hasNext();) {
            Flight f = iter.next();
            if (f.getExpireDate().isBefore(now)) {
                f.setAvailable(false);
                databaseManager.updateFlight(f);
            }
        }
    }

    /**
     * effettua la richiesta per recuperare i biglietti dei voli che compongono
     * l'offerta che l'utente intende acquistare e aggiorna lo stato di
     * prenotabilità dei voli stessi
     * 
     * @param offer
     * @return
     * @throws IOException
     * @throws SendTicketException
     * @throws BookTicketsException
     */
    public byte[] bookOfferTicket(GeneratedOffer offer) throws IOException, SendTicketException, BookTicketsException {

        byte[] pdfTicket = client.getFlightTickets(offer.getOutboundFlight().getAirlineId().getWsAddress(),
                offer.getUser().getProntogramUsername(), offer.getOutboundFlight().getFlightCode(),
                offer.getFlightBack().getFlightCode());
        offer.setBooked(true);
        offer.getOutboundFlight().setBooked(true);
        offer.getFlightBack().setBooked(true);

        return pdfTicket;
    }

    /**
     * aggiorna lo stato di prenotabilità dei voli da non disponibili a disponibili
     * 
     * @param offer
     * @throws IOException
     */
    public void unbookOffer(GeneratedOffer offer) throws IOException {
        client.unbookFlights(offer);
        offer.setBooked(false);
        offer.getOutboundFlight().setBooked(false);
        offer.getFlightBack().setBooked(false);
    }

    public class UserNotAllowedException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    public class BadRequestException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    public class SendTicketException extends Exception {
        private static final long serialVersionUID = 1L;
    }

}
