package it.unibo.soseng.camunda.user_manager.save_interest;

import static it.unibo.soseng.camunda.utils.ProcessVariables.ASYNC_RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_SAVE_INTEREST;
import static it.unibo.soseng.camunda.utils.ProcessVariables.RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.URI_INFO;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.core.Response;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.camunda.utils.ProcessState;

@Named("sendInterestResponseDelegate")
public class SendInterestResponseDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(SendInterestResponseDelegate.class.getName());

    @Inject
    private ProcessState processState;

    @Override
    public void execute(DelegateExecution execution) {
        LOGGER.info("Execute SendInterestResponse");

        String email = (String) execution.getVariable(USERNAME);
        Response response = (Response) processState.getStateAndRemove(PROCESS_SAVE_INTEREST, email, RESPONSE);
        AsyncResponse asyncResponse = (AsyncResponse) processState.getStateAndRemove(PROCESS_SAVE_INTEREST, email,
                ASYNC_RESPONSE);
        asyncResponse.resume(response);

        processState.getStateAndRemove(PROCESS_SAVE_INTEREST, email, URI_INFO);
    }
}
