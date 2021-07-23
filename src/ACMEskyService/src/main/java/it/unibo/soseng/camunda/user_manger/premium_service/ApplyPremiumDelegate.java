package it.unibo.soseng.camunda.user_manger.premium_service;

import java.util.logging.Logger;

import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

@Named("applyPremiumDelegate")
public class ApplyPremiumDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(ApplyPremiumDelegate.class.getName());


    @Override
    public void execute(DelegateExecution execution){
        LOGGER.info("Execute ApplyPremiumDelegate");
    }
  
}
