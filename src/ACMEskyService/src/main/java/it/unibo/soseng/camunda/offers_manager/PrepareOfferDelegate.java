package it.unibo.soseng.camunda.offers_manager;
import org.camunda.bpm.engine.delegate.BpmnError;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import static it.unibo.soseng.camunda.utils.ErrorsEvents.PREPARE_OFFER_ERROR;
import static it.unibo.soseng.camunda.utils.ProcessVariables.AVAILABLE_FLIGHTS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.GENERATED_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_ERROR;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.utils.ProcessVariables.CURRENT_USER_INTEREST;

import java.util.List;
import javax.inject.Inject;
import javax.inject.Named;
import javax.persistence.PersistenceException;

import it.unibo.soseng.logic.OfferManager;
import it.unibo.soseng.logic.DatabaseManager.FlightNotExistException;
import it.unibo.soseng.logic.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.model.UserInterest;

import java.util.logging.Logger;


@Named("prepareOfferDelegate")
public class PrepareOfferDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger(PrepareOfferDelegate.class.getName()); 
    
    @Inject
    OfferManager offerManager;

    @Override
    public void execute(DelegateExecution execution) {
      LOGGER.info ("Execute prepareOfferDelegate");

      @SuppressWarnings (value="unchecked")
      List<Flight> matchedFlights = (List<Flight>) execution.getVariable(AVAILABLE_FLIGHTS);
      UserInterest userinterest = (UserInterest) execution.getVariable(CURRENT_USER_INTEREST);
      try{
        String username = (String) execution.getVariable(USERNAME);
        GeneratedOffer offer = offerManager.generateOffer(matchedFlights.get(0), matchedFlights.get(1), username);
        offerManager.setUsedUserInterest(userinterest);
        execution.setVariable(GENERATED_OFFER, offer);
      } catch (FlightNotExistException | PersistenceException | UserNotFoundException e){
        execution.setVariable(PROCESS_ERROR,  e.toString());
        throw new BpmnError(PREPARE_OFFER_ERROR);
      }
    } 
}





