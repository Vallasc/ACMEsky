package it.unibo.soseng.camunda.user_manger.premium_service;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.gateway.user.dto.AddressDTO;
import it.unibo.soseng.logic.database.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.logic.offer.OfferManager;

import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.ProcessVariables.USER_ADDRESS;
import static it.unibo.soseng.camunda.ProcessVariables.GENERATED_OFFER;
import static it.unibo.soseng.camunda.ProcessVariables.USERNAME;


@Named("askRentDelegate")
public class AskRentDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(AskRentDelegate.class.getName());

    @Inject
    OfferManager offerManager;
    
    @Override
    public void execute(DelegateExecution execution){
        LOGGER.info("Execute AskRentDelegate");
        AddressDTO address = (AddressDTO) execution.getVariable(USER_ADDRESS);
        GeneratedOffer offer = (GeneratedOffer) execution.getVariable(GENERATED_OFFER);
        String email = (String) execution.getVariable(USERNAME);

        try {
            offerManager.bookAllRent(email, address, offer, execution);
        } catch (UserNotFoundException e) {
            LOGGER.info(e.toString());
        }
    }
  
}
