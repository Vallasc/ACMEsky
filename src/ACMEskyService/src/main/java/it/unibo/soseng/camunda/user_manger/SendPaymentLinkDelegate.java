package it.unibo.soseng.camunda.user_manger;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.core.Response;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.camunda.ProcessState;

import static it.unibo.soseng.camunda.ProcessVariables.PROCESS_BUY_OFFER;
import static it.unibo.soseng.camunda.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.ProcessVariables.ASYNC_RESPONSE;
import static it.unibo.soseng.camunda.ProcessVariables.PAYMENT_LINK;


@Named("sendPaymentLinkDelegate")
public class SendPaymentLinkDelegate implements JavaDelegate {

    @Inject
    ProcessState processState;

    private final static Logger LOGGER = Logger.getLogger(SendPaymentLinkDelegate.class.getName());

    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("sendPaymentLinkDelegate is working");
        String path = (String) execution.getVariable(PAYMENT_LINK);
        Response res = Response.status(Response.Status.OK.getStatusCode())
                            .entity(path)
                            .build();
        AsyncResponse async = (AsyncResponse) processState.getStateAndRemove(PROCESS_BUY_OFFER, (String) execution.getVariable(USERNAME), ASYNC_RESPONSE);
        async.resume(res);
        
    }
    
}
