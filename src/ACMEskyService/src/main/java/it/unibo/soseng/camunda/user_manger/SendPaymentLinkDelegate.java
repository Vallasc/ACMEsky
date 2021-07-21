package it.unibo.soseng.camunda.user_manger;

import java.util.logging.Logger;

import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import static it.unibo.soseng.camunda.ProcessVariables.ERRORS_IN_PAYMENT_REQ;


@Named("sendPaymentLinkDelegate")
public class SendPaymentLinkDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(SendPaymentLinkDelegate.class.getName());

    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("sendPaymentLinkDelegate is working");
        boolean err =(boolean) execution.getVariable(ERRORS_IN_PAYMENT_REQ);
        if(err != true){
            //TODO manda errore
        }
        
    }
    
}
