package it.unibo.soseng.logic.airline;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;

import it.unibo.soseng.gateway.airline.AirlineAPI;
import it.unibo.soseng.gateway.airline.dto.AirlineFlightOffer;
import it.unibo.soseng.gateway.airline.dto.InterestDTO;
import it.unibo.soseng.model.Airport;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;

import static it.unibo.soseng.camunda.StartEvents.SAVE_LAST_MINUTE;
import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_FLIGHT_OFFERS;
import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_NAME;

@Stateless
@TransactionManagement(value = TransactionManagementType.CONTAINER)
public class AirlineManager {
    private final static Logger LOGGER = Logger.getLogger(AirlineManager.class.getName());
    
    @PersistenceContext(unitName = "primary")
    private EntityManager entityManager;

    @Inject
    AirlineAPI api;


    /**
     * Invia il messaggio di start per il processo SaveOffer
     * @param airlineLastMinuteOffers
     */
    public void startSaveLastMinuteProcess(List<AirlineFlightOffer> airlineLastMinuteOffers, String airlineName){
        LOGGER.info("StartSaveLastMinuteProcess");
        RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        Map<String,Object> processVariables = new HashMap<String,Object>();
        processVariables.put(AIRLINE_FLIGHT_OFFERS, airlineLastMinuteOffers);
        processVariables.put(AIRLINE_NAME, airlineName);
        runtimeService.startProcessInstanceByMessage(SAVE_LAST_MINUTE, processVariables);
    }

    public void saveAirlineOffers(List<AirlineFlightOffer> airlineLastMinuteOffers, String airlineName){
        LOGGER.log(Level.INFO, "Save offer of airline {0}", airlineName);
    }

    public void createAirport() {
        Airport airport = new Airport();
        airport.setAiportCode("das");
        airport.setName("asddas");
        airport.setAddress("asaaaaa");
        this.entityManager.persist(airport);
        this.entityManager.flush();
        LOGGER.info(airport.getId() + "");
    }

    public List<InterestDTO> convertInterestList(List<FlightInterest> l){

        Iterator<FlightInterest> i = l.iterator();
        List<InterestDTO> result = new ArrayList<>();

        while (i.hasNext()){

            result.iterator().next().setDeparture(l.iterator().next().getDepartureAirport().getAddress());
            result.iterator().next().setDepDateTime(l.iterator().next().getDepartureDateTime());
            result.iterator().next().setArrDateTime(l.iterator().next().getArrivalDateTime());
            result.iterator().next().setArrival(l.iterator().next().getArrivalAirport().getAddress());

        }
        return result;
    }

    public List<Flight> retrieveFlightsList(List<FlightInterest> list) throws IOException, InterruptedException{

        return api.getFlightList(convertInterestList(list));
    }


}
