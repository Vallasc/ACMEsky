package it.unibo.soseng.camunda.user_manger;

import java.util.logging.Logger;

import javax.ejb.AsyncResult;
import javax.inject.Inject;
import javax.inject.Named;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.core.Response;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.camunda.ProcessState;
import it.unibo.soseng.util.Errors;

import static it.unibo.soseng.camunda.ProcessVariables.ERRORS_IN_PAYMENT_REQ;
import static it.unibo.soseng.camunda.ProcessVariables.ASYNC_RESPONSE;
import static it.unibo.soseng.camunda.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.ProcessVariables.PROCESS_BUY_OFFER;

@Named("sendErrorDelegate")
public class SendErrorDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(SendErrorDelegate.class.getName());

    @Inject
    ProcessState processState;
    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("There are problems involved in ticket request activity");
        Response res = Response.status(Response.Status.BAD_REQUEST.getStatusCode())
                            .entity(Errors.OFFER_NOT_AVAILABLE)
                            .build();
        AsyncResponse async = (AsyncResponse) processState.getStateAndRemove(PROCESS_BUY_OFFER, (String) execution.getVariable(USERNAME), ASYNC_RESPONSE);
        async.resume(res);
    }

}
