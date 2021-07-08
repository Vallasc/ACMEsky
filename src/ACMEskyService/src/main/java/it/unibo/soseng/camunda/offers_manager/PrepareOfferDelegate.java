package it.unibo.soseng.camunda.offers_manager;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import java.util.List;
import javax.inject.Inject;
import javax.inject.Named;
import it.unibo.soseng.logic.database.DatabaseManager.OfferAlreadyInException;
import it.unibo.soseng.logic.offer.OfferManager;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.GeneratedOffer;

import java.util.logging.Logger;
import static it.unibo.soseng.camunda.ProcessVariables.AVAILABLE_FLIGHTS;
import static it.unibo.soseng.camunda.ProcessVariables.GENERATED_OFFER;

@Named("prepareOfferDelegate")
public class PrepareOfferDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("prepareOfferDelegate"); 
    
    @Inject
    OfferManager offerManager;

    @Override
    public void execute(DelegateExecution execution) throws OfferAlreadyInException{
      LOGGER.info ("prepareOfferDelegate in esecuzione");
      @SuppressWarnings (value="unchecked")
      List<Flight> matchedFlights = (List<Flight>) execution.getVariable(AVAILABLE_FLIGHTS);
      GeneratedOffer offer;
      if (matchedFlights.size() > 1) {
        offer = offerManager.generateOffer(matchedFlights.get(0), matchedFlights.get(1));
      }
      else {
        offer = offerManager.generateOffer(matchedFlights.get(0), null);
      }

      execution.setVariable(GENERATED_OFFER, offer);

  }
}





