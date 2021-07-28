package it.unibo.soseng.camunda.offers_manager;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import static it.unibo.soseng.camunda.utils.ProcessVariables.AVAILABLE_FLIGHTS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.GENERATED_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_ERROR;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_INTEREST;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_INTEREST_INDEX;

import java.util.ArrayList;
import java.util.List;
import javax.inject.Inject;
import javax.inject.Named;
import javax.persistence.PersistenceException;

import it.unibo.soseng.logic.database.DatabaseManager.FlightNotExistException;
import it.unibo.soseng.logic.database.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.logic.offer.OfferManager;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.model.UserInterest;

import java.util.logging.Logger;


@Named("prepareOfferDelegate")
public class PrepareOfferDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("prepareOfferDelegate"); 
    
    @Inject
    OfferManager offerManager;

    @Override
    public void execute(DelegateExecution execution) {
      LOGGER.info ("prepareOfferDelegate in esecuzione");
      @SuppressWarnings (value="unchecked")
      List<Flight> matchedFlights = (List<Flight>) execution.getVariable(AVAILABLE_FLIGHTS);
      List <UserInterest> userInterests = (List<UserInterest>) execution.getVariable(USER_INTEREST);
      UserInterest ui = userInterests.get( (int) execution.getVariable(USER_INTEREST_INDEX));
      try{
        String username = (String) execution.getVariable(USERNAME);
        GeneratedOffer offer = offerManager.generateOffer(matchedFlights.get(0), matchedFlights.get(1), username);
        execution.setVariable(GENERATED_OFFER, offer);
      } catch (FlightNotExistException e){
        execution.setVariable(PROCESS_ERROR,  e.toString());
      } catch (PersistenceException e){
        execution.setVariable(PROCESS_ERROR,  e.toString());
      } catch (UserNotFoundException e){
        execution.setVariable(PROCESS_ERROR,  e.toString());
      }
    } 
}





