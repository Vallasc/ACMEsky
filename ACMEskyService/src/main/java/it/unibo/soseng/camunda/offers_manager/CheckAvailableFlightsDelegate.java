package it.unibo.soseng.camunda.offers_manager;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import java.util.logging.Logger;
import javax.inject.Named;

@Named("checkAvailableFlightsDelegate")
public class CheckAvailableFlightsDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("checkAvailableFlightsDelegate"); 
    //@Inject
   // DatabaseManager dbManager; 

    
    
    @Override
    public void execute(DelegateExecution execution){
      //dbManager.checkAvailableFlights ();
      LOGGER.info ("checkAvailableFlightsDelegate in esecuzione");
      execution.setVariable("availableFlight", true);
        }
}






