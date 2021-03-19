package it.unibo.soseng.camunda;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

//import it.unibo.soseng.logic.Prova;

import java.util.logging.Logger;

//import javax.inject.Inject;

public class SaveOfferDelegate implements JavaDelegate {
  //@Inject
 // private Prova prova;
  
  private final static Logger LOGGER = Logger.getLogger("SaveOfferDelegate");

  public void execute(DelegateExecution execution) throws Exception {
    
    LOGGER.info("STRONZOOOOOO");
  }

}