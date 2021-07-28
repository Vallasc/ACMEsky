package it.unibo.soseng.camunda.offers_manager;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;


import io.jsonwebtoken.io.IOException;
import it.unibo.soseng.gateway.prontogram.ProntogramClient;
import it.unibo.soseng.gateway.prontogram.dto.NotificationDTO;
import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.model.UserInterest;

import static it.unibo.soseng.camunda.utils.ProcessVariables.GENERATED_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_ERROR;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_INTERESTS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_INTEREST_INDEX;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PRONTOGRAM_USERNAME;

import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;


@Named("sendOfferDelegate")
public class SendOfferDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger(SendOfferDelegate.class.getName()); 
    
    @Inject
    ProntogramClient prontogramClient;
    
    @Override
    public void execute(DelegateExecution execution) throws IOException, InterruptedException, java.io.IOException{
    LOGGER.info ("Execute sendOfferDelegate");

    String prontogramUsername = (String) execution.getVariable(PRONTOGRAM_USERNAME);

    GeneratedOffer offer = (GeneratedOffer) execution.getVariable(GENERATED_OFFER);

    NotificationDTO notification = NotificationDTO.fromOffer(offer, prontogramUsername);
    prontogramClient.sendNotificationOffer(notification);
  } 
}
