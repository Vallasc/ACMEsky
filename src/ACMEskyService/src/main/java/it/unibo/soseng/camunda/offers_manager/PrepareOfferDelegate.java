package it.unibo.soseng.camunda.offers_manager;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import java.util.List;
import javax.inject.Inject;
import javax.inject.Named;

import it.unibo.soseng.logic.database.DatabaseManager.OfferAlreadyInException;
import it.unibo.soseng.logic.offer.OfferManager;
import it.unibo.soseng.model.Flight;
import java.util.logging.Logger;

@Named("prepareOfferDelegate")
public class PrepareOfferDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("prepareOfferDelegate"); 
    
    @Inject
    OfferManager offerManager;

    @Override
    public void execute(DelegateExecution execution) throws OfferAlreadyInException{
      // LOGGER.info ("prepareOfferDelegate in esecuzione");
      // @SuppressWarnings (value="unchecked")
      //   List<Flight> availableFlights = 
      //       (List<Flight>) execution.getVariable(AVAILABLE_FLIGHTS);
      // for (Flight flight:availableFlights ) {
      //   offerManager.generateOffer(flight);
      // }
  }
}





