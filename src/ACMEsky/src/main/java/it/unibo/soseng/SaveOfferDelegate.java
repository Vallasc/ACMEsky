package it.unibo.soseng;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import java.util.logging.Logger;

public class SaveOfferDelegate implements JavaDelegate {

  private final static Logger LOGGER = Logger.getLogger("SaveOfferDelegate");

  public void execute(DelegateExecution execution) throws Exception {
    LOGGER.info("STRONZOOOOOO");
  }

}