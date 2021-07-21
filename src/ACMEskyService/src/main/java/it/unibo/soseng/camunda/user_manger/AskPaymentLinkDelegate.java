package it.unibo.soseng.camunda.user_manger;

import java.util.logging.Logger;

import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

@Named("askPaymentLinkDelegate")
public class AskPaymentLinkDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(AskPaymentLinkDelegate.class.getName());


    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("askPaymentLinkDelegate is working");
    }
    
}
