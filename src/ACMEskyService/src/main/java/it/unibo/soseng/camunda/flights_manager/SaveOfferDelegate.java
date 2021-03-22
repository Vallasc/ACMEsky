package it.unibo.soseng.camunda.flights_manager;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.Prova;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

@Named("saveOfferDelegate")
public class SaveOfferDelegate implements JavaDelegate {
  
  @Inject
  private Prova prova;
  
  private final static Logger LOGGER = Logger.getLogger("SaveOfferDelegate");

  @Override
  public void execute(DelegateExecution execution){
    LOGGER.info("EXECUTE"+prova.getN());
  }

}