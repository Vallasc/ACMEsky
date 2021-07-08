package it.unibo.soseng.camunda.offers_manager;
import static it.unibo.soseng.camunda.ProcessVariables.USER_INTEREST;
import static it.unibo.soseng.camunda.ProcessVariables.USER_INTEREST_LEN;
import static it.unibo.soseng.camunda.ProcessVariables.USER_INTEREST_INDEX;
import java.util.List;
import java.util.logging.Logger;
import javax.inject.Inject;
import javax.inject.Named;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.model.UserInterest;

@Named("initializeFlightInterestServiceDelegate")
public class InitializeOfferService implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger("retrieveFlightsOfInterestDelegate"); 
    
    @Inject
    DatabaseManager dbManager; 
    
    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("retrieveFlightsOfInterestDelegateExecution");
        List <UserInterest> usersInterests = dbManager.retrieveUserInterests();
        execution.setVariable(USER_INTEREST_LEN, usersInterests.size());
        execution.setVariable(USER_INTEREST_INDEX, 0);
        execution.setVariable(USER_INTEREST, usersInterests);   
    }
    
}
