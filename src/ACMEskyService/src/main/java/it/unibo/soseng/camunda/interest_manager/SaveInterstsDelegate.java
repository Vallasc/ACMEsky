package it.unibo.soseng.camunda.interest_manager;

import java.util.logging.Logger;

import javax.inject.Named;
import javax.inject.Inject;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.airline.AirlineManager;
import it.unibo.soseng.gateway.user.dto.InterestsRequest;
import static it.unibo.soseng.camunda.ProcessVariables.USER_INTERESTS_REQUEST;
import static it.unibo.soseng.camunda.ProcessVariables.USERNAME;

@Named("saveInterstsDelegate")
public class SaveInterstsDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(SaveInterstsDelegate.class.getName());

    @Inject 
    AirlineManager airlineManager;

    @Override
    public void execute(DelegateExecution execution){
        LOGGER.info("Execute");
        InterestsRequest interest = (InterestsRequest) execution.getVariable(USER_INTERESTS_REQUEST);
        String username = (String) execution.getVariable(USERNAME);
        try {
            airlineManager.saveUserInterests(interest, username);
        } catch (Exception e) {
            //TODO: handle exception
        }
    }
  
}
