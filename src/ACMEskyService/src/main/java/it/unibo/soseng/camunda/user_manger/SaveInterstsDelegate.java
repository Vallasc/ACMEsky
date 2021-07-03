package it.unibo.soseng.camunda.user_manger;

import java.util.logging.Logger;

import javax.inject.Named;
import javax.ws.rs.core.Response;
import javax.inject.Inject;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.interest.InterestManager;
import it.unibo.soseng.camunda.ProcessState;
import it.unibo.soseng.gateway.user.dto.UserInterestDTO;

import static it.unibo.soseng.camunda.ProcessVariables.USER_INTERESTS_REQUEST;
import static it.unibo.soseng.camunda.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.ProcessVariables.PROCESS_SAVE_INTERST;
import static it.unibo.soseng.camunda.ProcessVariables.RESPONSE;

@Named("saveInterstsDelegate")
public class SaveInterstsDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(SaveInterstsDelegate.class.getName());

    @Inject 
    InterestManager interestManager;

    @Inject
    private ProcessState processState;

    @Override
    public void execute(DelegateExecution execution){
        LOGGER.info("Execute SaveIntersts");
        UserInterestDTO interestRequest = (UserInterestDTO) execution.getVariable(USER_INTERESTS_REQUEST);
        String email = (String) execution.getVariable(USERNAME);
        Response response = interestManager.handleUserInterests(email, interestRequest);
        processState.setState(PROCESS_SAVE_INTERST, email, RESPONSE, response);
    }
  
}
