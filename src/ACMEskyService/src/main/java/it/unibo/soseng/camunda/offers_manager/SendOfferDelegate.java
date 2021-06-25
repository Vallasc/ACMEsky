package it.unibo.soseng.camunda.offers_manager;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import java.util.logging.Logger;
import javax.inject.Named;

@Named("sendOfferDelegate")
public class SendOfferDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("sendOfferDelegate"); 

  @Override
  public void execute(DelegateExecution execution){
    LOGGER.info ("sendOfferDelegate in esecuzione");
    
  }
}
