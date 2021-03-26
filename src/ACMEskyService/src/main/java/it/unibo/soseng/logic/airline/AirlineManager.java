package it.unibo.soseng.logic.airline;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

import javax.ejb.Stateless;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;

import it.unibo.soseng.model.Flight;

@Stateless
public class AirlineManager {
    private final static Logger LOGGER = Logger.getLogger(AirlineManager.class.getName());
    
    public void saveAirlineOffer(Flight flightOffer){
        RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        
        Map<String,Object> processVariables = new HashMap<String,Object>();
        processVariables.put("flightId", flightOffer.getId());
        runtimeService.startProcessInstanceByMessage("StartSaveOffer", processVariables);
    }
}
