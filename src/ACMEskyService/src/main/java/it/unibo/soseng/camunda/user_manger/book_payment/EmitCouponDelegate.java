package it.unibo.soseng.camunda.user_manger.book_payment;

import java.util.logging.Logger;

import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

@Named("emitCouponDelegate")
public class EmitCouponDelegate implements JavaDelegate{

    private final static Logger LOGGER = Logger.getLogger(EmitCouponDelegate.class.getName());

    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("emitCouponDelegate is working");

        
    }
    
}
