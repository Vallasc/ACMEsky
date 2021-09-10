package it.unibo.soseng.camunda.user_manager.save_interest;

import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_SAVE_INTEREST;
import static it.unibo.soseng.camunda.utils.ProcessVariables.RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_INTERESTS_REQUEST;

import java.util.logging.Logger;

import javax.inject.Named;
import javax.ws.rs.core.Response;
import javax.inject.Inject;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.gateway.user.dto.UserInterestDTO;
import it.unibo.soseng.logic.InterestManager;

@Named("saveInterestsDelegate")
public class SaveInterestsDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(SaveInterestsDelegate.class.getName());

    @Inject 
    InterestManager interestManager;

    @Inject
    private ProcessState processState;

    @Override
    public void execute(DelegateExecution execution){
        LOGGER.info("Execute SaveInterests");
        UserInterestDTO interestRequest = (UserInterestDTO) execution.getVariable(USER_INTERESTS_REQUEST);
        String email = (String) execution.getVariable(USERNAME);
        Response response = interestManager.handleUserInterests(email, interestRequest);
        processState.setState(PROCESS_SAVE_INTEREST, email, RESPONSE, response);
    }
  
}
