package it.unibo.soseng.camunda.user_manager;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.OfferManager;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER;

/**
 * JavaDelegate associato al task "Change offer state" del diagramma BPMN
 * confirm_offer.bpmn. Il task si occupa di aggiornare lo stato di disponibilità
 * dell'oggetto per non prendere più in considerazione quell'offerta come se
 * fosse una di quelle da gestire.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Named("changeOfferStateDelegate")
public class ChangeOfferStateDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(ChangeOfferStateDelegate.class.getName());

    @Inject
    OfferManager offerManager;

    /**
     * aggiorna lo stato dell'offerta (e relativi voli di andata e ritorno) per
     * considerarla come venduta e non più acquistabile o prenotabile dagli altri
     * utenti
     */
    @Override
    public void execute(DelegateExecution execution) {
        LOGGER.info("Execute ChangeOfferStateDelegate");

        GeneratedOffer offer = (GeneratedOffer) execution.getVariable(USER_OFFER);
        offerManager.setBooked(offer);
    }

}
