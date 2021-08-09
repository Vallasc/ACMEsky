package it.unibo.soseng.camunda.user_manger;

import java.util.logging.Logger;

import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

@Named("prepareTicketsDelegate")
public class PrepareTicketsDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(PrepareTicketsDelegate.class.getName());

    @Override
    public void execute(DelegateExecution execution) throws Exception {
    LOGGER.info("PrepareTicketsDelegate is working");        
    }
    
}
