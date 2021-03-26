package it.unibo.soseng.camunda.flights_manager;

import it.unibo.soseng.logic.Prova;
import it.unibo.soseng.logic.airline.AirlineManager;
import it.unibo.soseng.model.UserRequest;

import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

@Named("SaveInterestFlightDelegate")
public class SaveInterestFlightDelegate implements JavaDelegate {
  
  @Inject
  private Prova prova;

  @Inject
  private AirlineManager manager;
  
  private final static Logger LOGGER = Logger.getLogger("SaveInterestFlightDelegate");

  @Override
  public void execute(DelegateExecution execution){

    LOGGER.info("SaveInterestFlightProcess is starting");
    List<UserRequest> l = this.manager.retrieveRequestFromDB();
  }

}
