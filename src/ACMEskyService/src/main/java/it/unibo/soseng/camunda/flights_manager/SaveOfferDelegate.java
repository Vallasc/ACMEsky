package it.unibo.soseng.camunda.flights_manager;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import java.util.logging.Logger;

import javax.inject.Named;

@Named("saveOfferDelegate")
public class SaveOfferDelegate implements JavaDelegate {

  private final static Logger LOGGER = Logger.getLogger(SaveOfferDelegate.class.getName());

  @Override
  public void execute(DelegateExecution execution){
    String id = (String) execution.getVariable("flightId");
    LOGGER.info("Execute" + id);
  }

}