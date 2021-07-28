package it.unibo.soseng.camunda.offers_manager;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_INTERESTS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_INTEREST_INDEX;

import java.util.List;
import java.util.logging.Logger;
import javax.inject.Inject;
import javax.inject.Named;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.model.UserInterest;

@Named("initializeOfferServiceDelegate")
public class InitializeOfferService implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger(InitializeOfferService.class.getName()); 
    
    @Inject
    DatabaseManager dbManager; 
    
    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("Execute InitializeOfferServiceDelegate");
        List<UserInterest> usersInterests = dbManager.retrieveUserInterests();
        execution.setVariable(USER_INTEREST_INDEX, 0);
        execution.setVariable(USER_INTERESTS, usersInterests);   
    }
    
}
