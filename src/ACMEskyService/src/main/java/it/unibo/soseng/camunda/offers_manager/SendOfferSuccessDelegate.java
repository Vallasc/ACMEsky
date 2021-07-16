package it.unibo.soseng.camunda.offers_manager;

import org.camunda.bpm.engine.delegate.JavaDelegate;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import it.unibo.soseng.camunda.ProcessState;
import java.util.logging.Logger;
import javax.inject.Inject;
import javax.inject.Named;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.core.Response;
import static it.unibo.soseng.camunda.ProcessVariables.PROCESS_CONFIRM_FLIGHT;
import static it.unibo.soseng.camunda.ProcessVariables.RESPONSE;
import static it.unibo.soseng.camunda.ProcessVariables.ASYNC_RESPONSE;
import static it.unibo.soseng.camunda.ProcessVariables.URI_INFO;
import static it.unibo.soseng.camunda.ProcessVariables.USER_OFFER_TOKEN;
import static it.unibo.soseng.camunda.ProcessVariables.IS_VALID_TOKEN;
import static it.unibo.soseng.camunda.ProcessVariables.IS_OFFER_EXPIRED;

@Named("sendOfferSuccessDelegate")
public class SendOfferSuccessDelegate implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger("sendOfferSuccessDelegate"); 
    
    @Inject
    private ProcessState processState;
    
    @Override
    public void execute(DelegateExecution execution){

        LOGGER.info("Execute sendOfferSuccessDelegate");
        boolean isValidToken = (boolean) execution.getVariable(IS_VALID_TOKEN);
        boolean isOfferExpired = (boolean) execution.getVariable(IS_OFFER_EXPIRED);
        String token = (String) execution.getVariable(USER_OFFER_TOKEN);

        if (isValidToken == true && isOfferExpired == false) { 
            Response response = (Response) processState.getStateAndRemove(PROCESS_CONFIRM_FLIGHT, token, RESPONSE);
            AsyncResponse asyncResponse = (AsyncResponse) processState.getStateAndRemove(PROCESS_CONFIRM_FLIGHT, token, ASYNC_RESPONSE);
            asyncResponse.resume(response);  
            processState.getStateAndRemove(PROCESS_CONFIRM_FLIGHT, token, URI_INFO); 
        }


    }
    
}