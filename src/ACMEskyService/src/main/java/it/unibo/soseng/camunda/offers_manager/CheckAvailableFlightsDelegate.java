package it.unibo.soseng.camunda.offers_manager;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.offer.OfferManager;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.UserInterest;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import javax.inject.Inject;
import javax.inject.Named;
import static it.unibo.soseng.camunda.ProcessVariables.AVAILABLE_FLIGHTS;
import static it.unibo.soseng.camunda.ProcessVariables.USER_INTEREST;
import static it.unibo.soseng.camunda.ProcessVariables.USER_INTEREST_INDEX;
import static it.unibo.soseng.camunda.ProcessVariables.THERE_IS_FHLIGHTS;

@Named("checkAvailableFlightsDelegate")
public class CheckAvailableFlightsDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("checkAvailableFlightsDelegate"); 
    
    @Inject
    DatabaseManager dbManager; 
    OfferManager offerManager;

    @Override
    public void execute(DelegateExecution execution){
      LOGGER.info ("checkAvailableFlightsDelegate in esecuzione");
      List <UserInterest> userInterests = (List<UserInterest>) execution.getVariable(USER_INTEREST);
      List <Flight> matchedFlight = new ArrayList <Flight> ();
      UserInterest ui = userInterests.get( (int) execution.getVariable(USER_INTEREST_INDEX));
      matchedFlight.add (offerManager.matchOffer(ui.getOutboundFlightInterest()));
      if (ui.getFlightBackInterest() != null) {
        matchedFlight.add (offerManager.matchOffer(ui.getFlightBackInterest()));        
      }
      execution.setVariable(AVAILABLE_FLIGHTS, matchedFlight);
      execution.setVariable(THERE_IS_FHLIGHTS, true);
    }
}






