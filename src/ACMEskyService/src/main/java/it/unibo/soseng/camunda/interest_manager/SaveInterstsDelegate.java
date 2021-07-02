package it.unibo.soseng.camunda.interest_manager;

import java.util.logging.Logger;

import javax.inject.Named;
import javax.ws.rs.core.Response;
import javax.inject.Inject;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.interest.InterestManager;
import it.unibo.soseng.camunda.ProcessState;
import it.unibo.soseng.camunda.ProcessState.AsyncResponseDTO;
import it.unibo.soseng.gateway.user.dto.UserInterestDTO;

import static it.unibo.soseng.camunda.ProcessVariables.USER_INTERESTS_REQUEST;
import static it.unibo.soseng.camunda.ProcessVariables.USERNAME;

@Named("saveInterstsDelegate")
public class SaveInterstsDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(SaveInterstsDelegate.class.getName());

    @Inject 
    InterestManager interestManager;

    @Inject
    private ProcessState processState;

    @Override
    public void execute(DelegateExecution execution){
        LOGGER.info("Execute save interest");
        UserInterestDTO interest = (UserInterestDTO) execution.getVariable(USER_INTERESTS_REQUEST);
        String email = (String) execution.getVariable(USERNAME);
        AsyncResponseDTO asyncResponse = processState.getResponse(email);
        Response response = interestManager.handleUserInterests(asyncResponse, email, interest);
        asyncResponse.getResponse().resume(response);
    }
  
}
