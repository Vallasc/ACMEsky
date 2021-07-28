package it.unibo.soseng.camunda.offers_manager;

import org.camunda.bpm.engine.delegate.JavaDelegate;
import org.camunda.bpm.engine.delegate.DelegateExecution;

import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.logic.airline.AirlineManager;

import static it.unibo.soseng.camunda.utils.ProcessVariables.ASYNC_RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_BUY_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;

import java.util.logging.Logger;
import javax.inject.Inject;
import javax.inject.Named;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.core.Response;

@Named("sendOfferResponseDelegate")
public class SendOfferResponseDelegate implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger("sendOfferResponseDelegate"); 
    
    @Inject
    private ProcessState processState;

    @Inject
    AirlineManager airlineManager;
    
    @Override
    public void execute(DelegateExecution execution){

        LOGGER.info("Execute sendOfferResponseDelegate");

        String email = (String) execution.getVariable(USERNAME);
        Response response = (Response) processState.getStateAndRemove(PROCESS_BUY_OFFER, email, RESPONSE);
        AsyncResponse asyncResponse = (AsyncResponse) processState.getStateAndRemove(PROCESS_BUY_OFFER, email, ASYNC_RESPONSE);
        asyncResponse.resume(response);  
    }

}