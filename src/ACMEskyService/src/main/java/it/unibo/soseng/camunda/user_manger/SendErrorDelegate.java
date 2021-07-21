package it.unibo.soseng.camunda.user_manger;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.camunda.ProcessState;
import static it.unibo.soseng.camunda.ProcessVariables.ERRORS_IN_PAYMENT_REQ;;


@Named("sendErrorDelegate")
public class SendErrorDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(SendErrorDelegate.class.getName());

    @Inject
    ProcessState processState;
    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("There are problems involved in ticket request activity");
        boolean err =(boolean) execution.getVariable(ERRORS_IN_PAYMENT_REQ);
        if(err == true){
            //TODO manda errore
        }
        
    }
    
}
