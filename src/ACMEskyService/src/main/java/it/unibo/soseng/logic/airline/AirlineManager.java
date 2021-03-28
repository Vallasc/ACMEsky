package it.unibo.soseng.logic.airline;

import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;

import it.unibo.soseng.gateway.airline.dto.AirlineFlightOffer;
import it.unibo.soseng.model.Airport;
import static it.unibo.soseng.camunda.StartEvents.SAVE_LAST_MINUTE;
import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_FLIGHT_OFFERS;
import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_NAME;

@Stateless
@TransactionManagement(value = TransactionManagementType.CONTAINER)
public class AirlineManager {
    private final static Logger LOGGER = Logger.getLogger(AirlineManager.class.getName());
    
    @PersistenceContext(unitName = "primary")
    private EntityManager entityManager;


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
}
