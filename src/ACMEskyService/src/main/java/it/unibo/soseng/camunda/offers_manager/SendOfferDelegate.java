package it.unibo.soseng.camunda.offers_manager;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import static it.unibo.soseng.camunda.ProcessVariables.
import static it.unibo.soseng.camunda.ProcessVariables.USER_INTEREST;
import static it.unibo.soseng.camunda.ProcessVariables.USER_INTEREST_INDEX;

import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.model.UserInterest;

import java.util.List;
import java.util.logging.Logger;
import javax.inject.Named;

@Named("sendOfferDelegate")
public class SendOfferDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("sendOfferDelegate"); 

  @Override
  public void execute(DelegateExecution execution){
    LOGGER.info ("sendOfferDelegate in esecuzione");
    GeneratedOffer offer = (GeneratedOffer) execution.getVariable(GENERATED_OFFER);

    List <UserInterest> userInterests = (List<UserInterest>) execution.getVariable(USER_INTEREST);
    int userInterestIndex = (int) execution.getVariable(USER_INTEREST_INDEX) ;
    String offerToken = String.valueOf(offer.getId());
    Notification offerToSend = new Notification();
    offerToSend.setOfferToken(offerToken);
    offerToSend.setUsername(userInterests.get(userInterestIndex).getUser().getEntity().getUsername());
    offerToSend.setFlyOutBound(offer.getOutboundFlightId());
    offerToSend.setFlyBack(offer.getFlightBackId());
    prontogramClient.sendNotificationOffer(offerToSend);
    execution.setVariable(USER_INTEREST_INDEX, userInterestIndex + 1);
    
  }
}
