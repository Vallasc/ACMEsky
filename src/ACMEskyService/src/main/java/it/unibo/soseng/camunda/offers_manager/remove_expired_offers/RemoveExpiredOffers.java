package it.unibo.soseng.camunda.offers_manager.remove_expired_offers;

import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.OfferManager;
import it.unibo.soseng.model.GeneratedOffer;

/**
 * JavaDelegate associato al task "Remove expired offers" del diagramma BPMN
 * remove_expired_offers.bpmn. Quando si attiva il task ACMEsky rimuove le
 * offerte di volo (che comprende i voli di andata e ritorno) cambiandone lo
 * stato di disponibilità
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Named("removeExpiredOffersDelegate")
public class RemoveExpiredOffers implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(RemoveExpiredOffers.class.getName());

    @Inject
    OfferManager offerManager;

    /**
     * recupera le offerte scadute ancora disponibili e che non sono prenotate al
     * momento dell'invocazione e ne modifica la disponibilità. Chiaramente anche i
     * voli che le compongono non sono più disponibili per la prenotazione e
     * acquisto.
     */
    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("RemoveExpiredOffers is working");
        List<GeneratedOffer> offersNotAvailable = offerManager.removeExpiredOffers();
        offerManager.setUnavailableOfferFlights(offersNotAvailable);

    }

}
