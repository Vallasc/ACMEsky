package it.unibo.soseng.camunda.flights_manager;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import java.util.logging.Logger;
import javax.inject.Named;

@Named("searchFlightsDelegate")
public class SearchFlightsDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("SearchFlightsDelegate"); 

  @Override
  public void execute(DelegateExecution execution){
    LOGGER.info ("SearchFlightsDelegate in esecuzione");
  }
}
