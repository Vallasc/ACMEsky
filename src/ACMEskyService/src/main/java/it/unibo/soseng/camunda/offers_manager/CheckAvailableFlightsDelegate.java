package it.unibo.soseng.camunda.offers_manager;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.FlightNotExistException;
import it.unibo.soseng.logic.offer.OfferManager;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.UserInterest;

import static it.unibo.soseng.camunda.utils.ProcessVariables.AVAILABLE_FLIGHTS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.THERE_IS_FLIGHTS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_INTEREST;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_INTEREST_INDEX;

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
    
    @Inject
    OfferManager offerManager;

    @Override
    public void execute(DelegateExecution execution) throws FlightNotExistException{
      LOGGER.info ("checkAvailableFlightsDelegate in esecuzione");
      List <UserInterest> userInterests = (List<UserInterest>) execution.getVariable(USER_INTEREST);
      List <Flight> matchedFlight = new ArrayList <Flight> ();
      UserInterest ui = userInterests.get( (int) execution.getVariable(USER_INTEREST_INDEX));
      execution.setVariable(USERNAME, ui.getUser().getEntity().getUsername());
      Flight outBound = offerManager.matchOffer(ui.getOutboundFlightInterest());
      Flight back = offerManager.matchOffer(ui.getFlightBackInterest());
      if ( outBound != null && back != null) {
        matchedFlight.add (outBound);
        matchedFlight.add (back);
        offerManager.setFlightAvailability(outBound);
        offerManager.setFlightAvailability(back);
        //var che controllo il gateway
        execution.setVariable(AVAILABLE_FLIGHTS, matchedFlight);
        execution.setVariable(THERE_IS_FLIGHTS, true);
      }else{
        execution.setVariable(THERE_IS_FLIGHTS, false);
      }
    }
}






