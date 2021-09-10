package it.unibo.soseng.camunda.user_manager.book_payment;

import static it.unibo.soseng.camunda.utils.ProcessVariables.ASYNC_RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_CONFIRM_BUY_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;
import it.unibo.soseng.camunda.utils.ProcessState;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.core.Response;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

@Named("sendResponseDelegate")
public class SendResponseDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(SendResponseDelegate.class.getName());

    @Inject
    ProcessState processState;
    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("Execute SendResponseDelegate");

        String email = (String) execution.getVariable(USERNAME);
        Response response = (Response) processState.getStateAndRemove(PROCESS_CONFIRM_BUY_OFFER, email, RESPONSE);
        AsyncResponse asyncResponse = (AsyncResponse) processState.getStateAndRemove(PROCESS_CONFIRM_BUY_OFFER, email, ASYNC_RESPONSE);
        asyncResponse.resume(response);
    }

}
