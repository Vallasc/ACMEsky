package it.unibo.soseng.camunda.offers_manager;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.UserInterest;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import javax.inject.Inject;
import javax.inject.Named;

@Named("checkAvailableFlightsDelegate")
public class CheckAvailableFlightsDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("checkAvailableFlightsDelegate"); 
    
    @Inject
     DatabaseManager dbManager; 

    @Override
    public void execute(DelegateExecution execution){
      // LOGGER.info ("checkAvailableFlightsDelegate in esecuzione");
      // List <UserInterest> usersInterests = dbManager.retrieveUserInterests();
      // List <Flight> availableFlight = new ArrayList <Flight> ();
      // for (UserInterest ui:usersInterests) {
      //   availableFlight.addAll(dbManager.availableFlights(ui.getId()));
      // }
      // execution.setVariable(AVAILABLE_FLIGHTS, availableFlight);
        }
}






