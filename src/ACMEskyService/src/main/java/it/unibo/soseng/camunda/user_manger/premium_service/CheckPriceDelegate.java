package it.unibo.soseng.camunda.user_manger.premium_service;

import java.util.logging.Logger;

import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import javax.inject.Inject;

import static it.unibo.soseng.camunda.ProcessVariables.OFFER_PRICE;

@Named("checkPriceDelegate")
public class CheckPriceDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(CheckPriceDelegate.class.getName());


    @Override
    public void execute(DelegateExecution execution){
        LOGGER.info("Execute CheckPriceDelegate");
        
        // TODO 
        // Imposto la variabile del prezzo
        execution.setVariable(OFFER_PRICE, 10001);
        // TODO
        // Imposto indirizzo utente
        execution.setVariable(OFFER_PRICE, 10001);
    }
  
}
