package it.unibo.soseng.logic.airline;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceContext;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;

import it.unibo.soseng.model.Airport;

//import it.unibo.soseng.model.Flight;

@Stateless
@TransactionManagement(value=TransactionManagementType.CONTAINER)
public class AirlineManager {
    private final static Logger LOGGER = Logger.getLogger(AirlineManager.class.getName());
    
    /*public void saveAirlineOffer(Flight flightOffer){
        RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        
        Map<String,Object> processVariables = new HashMap<String,Object>();
        processVariables.put("flightId", flightOffer.getId());
        runtimeService.startProcessInstanceByMessage("StartSaveOffer", processVariables);
    }*/

    @PersistenceContext(unitName = "primary")
    private EntityManager entityManager;

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
