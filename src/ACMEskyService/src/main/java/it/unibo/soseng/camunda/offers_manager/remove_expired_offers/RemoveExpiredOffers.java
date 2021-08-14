package it.unibo.soseng.camunda.offers_manager.remove_expired_offers;

import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.offer.OfferManager;
import it.unibo.soseng.model.GeneratedOffer;

@Named("removeExpiredOffersDelegate")
public class RemoveExpiredOffers implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(RemoveExpiredOffers.class.getName());

    @Inject
    OfferManager offerManager;

    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("RemoveExpiredOffers is working");
        List<GeneratedOffer> offersNotAvailable = offerManager.removeExpiredOffers();
        offerManager.setUnavailableOfferFlights(offersNotAvailable);

    }

}
