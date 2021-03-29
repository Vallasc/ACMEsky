package it.unibo.soseng.camunda.flights_manager;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import java.util.logging.Logger;
import javax.inject.Named;

@Named("SaveFlightsOfInterestDelegate")
public class SaveFlightsOfInterestDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("SaveFlightsOfInterestDelegate"); 

  @Override
  public void execute(DelegateExecution execution){
    LOGGER.info ("SaveFlightsOfInterestDelegate in esecuzione");
  }
}

