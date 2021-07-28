package it.unibo.soseng.camunda.offers_manager;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;


import io.jsonwebtoken.io.IOException;
import it.unibo.soseng.gateway.prontogram.ProntogramClient;
import it.unibo.soseng.gateway.prontogram.dto.Notification;
import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.model.UserInterest;

import static it.unibo.soseng.camunda.utils.ProcessVariables.GENERATED_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_ERROR;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_INTEREST;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_INTEREST_INDEX;

import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;


@Named("sendOfferDelegate")
public class SendOfferDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("sendOfferDelegate"); 
    @Inject
    ProntogramClient prontogramClient;
    
    @Override
    public void execute(DelegateExecution execution) throws IOException, InterruptedException, java.io.IOException{
    LOGGER.info ("sendOfferDelegate in esecuzione");

    if(execution.getVariable(PROCESS_ERROR) != null){
      return ;
    }
    GeneratedOffer offer = (GeneratedOffer) execution.getVariable(GENERATED_OFFER);
    List <UserInterest> userInterests = (List<UserInterest>) execution.getVariable(USER_INTEREST);
    int userInterestIndex = (int) execution.getVariable(USER_INTEREST_INDEX);
    String offerToken = String.valueOf(offer.getId());
    Notification offerToSend = new Notification();
    offerToSend.setOfferToken(offerToken);
    offerToSend.setUsername(userInterests.get(userInterestIndex).getUser().getEntity().getUsername());
    offerToSend.setFlyOutBound(offer.getOutboundFlightId());
    offerToSend.setFlyBack(offer.getFlightBackId());
    // prontogramClient.sendNotificationOffer(offerToSend);
    execution.setVariable(USER_INTEREST_INDEX, userInterestIndex + 1);
  } 
}
