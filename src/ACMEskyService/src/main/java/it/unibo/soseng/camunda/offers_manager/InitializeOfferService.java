package it.unibo.soseng.camunda.offers_manager;
import static it.unibo.soseng.camunda.ProcessVariables.OFFER_SERVICE;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import javax.inject.Named;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.model.FlightInterest;

@Named("initializeFlightInterestServiceDelegate")
public class InitializeOfferService implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger("retrieveFlightsOfInterestDelegate"); 

    @Override
    public void execute(DelegateExecution execution) throws Exception {
        List<FlightInterest> flights = new ArrayList<>();
        execution.setVariable(OFFER_SERVICE, flights);
        
    }
    
}
