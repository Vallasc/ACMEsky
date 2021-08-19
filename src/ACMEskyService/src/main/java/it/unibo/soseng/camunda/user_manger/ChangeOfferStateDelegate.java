package it.unibo.soseng.camunda.user_manger;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.offer.OfferManager;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER;

@Named("changeOfferStateDelegate")
public class ChangeOfferStateDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(ChangeOfferStateDelegate.class.getName());

    @Inject
    OfferManager offerManager;

    @Override
    public void execute(DelegateExecution execution) {
        LOGGER.info("Execute ChangeOfferStateDelegate");

        GeneratedOffer offer = (GeneratedOffer) execution.getVariable(USER_OFFER);
        offerManager.setBooked(offer);
    }

}
