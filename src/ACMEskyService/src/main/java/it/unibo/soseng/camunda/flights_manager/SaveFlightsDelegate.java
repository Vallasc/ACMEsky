package it.unibo.soseng.camunda.flights_manager;

import java.util.logging.Logger;

import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

@Named("saveFlightsDelegate")
public class SaveFlightsDelegate implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger("saveFlightsDelegate");

    @Override
    public void execute(DelegateExecution execution){
      LOGGER.info ("saveFlightsDelegate in esecuzione");
      
    }
}
