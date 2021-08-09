package it.unibo.soseng.camunda.user_manger;

import java.util.logging.Logger;

import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

@Named("changeOfferStateDelegate")
public class ChangeOfferStateDelegate implements JavaDelegate{

    private final static Logger LOGGER = Logger.getLogger(ChangeOfferStateDelegate.class.getName());

    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("ChangeOfferStateDelegate working");
        
    }
    
}
