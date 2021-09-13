package it.unibo.soseng.camunda.user_manager.premium_service;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.BpmnError;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.gateway.user.dto.AddressDTO;
import it.unibo.soseng.logic.OfferManager;
import it.unibo.soseng.logic.OfferManager.DistanceServiceException;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.utils.ErrorsEvents.DISTANCE_ERROR;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PREMIUM_SERVICE_ERROR;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_ADDRESS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_DISTANCE;

/**
 * JavaDelegate associato al task "Compute distance" del diagramma BPMN
 * confirm_offer.bpmn. Il task preleva le informazioni sull'indirizzo
 * dell'utente e degli aereoporti di partenza e arrivo dei voli dell'offerta e
 * calcola la distanza.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Named("computeDistanceDelegate")
public class ComputeDistanceDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(ComputeDistanceDelegate.class.getName());

    @Inject
    private OfferManager offerManager;

    /**
     * Il metodo recupera l'indirizzo dell'utente e degli aereoporti di partenza e
     * arrivo dei voli, calcola la distanza e nel caso positivo, la assegna alla
     * variabile di processo e stabilisce che non ci sono problemi, altrimenti
     * restituisce un errore.
     */
    @Override
    public void execute(DelegateExecution execution) {
        LOGGER.info("Execute ComputeDistanceDelegate");
        AddressDTO address = (AddressDTO) execution.getVariable(USER_ADDRESS);
        GeneratedOffer offer = (GeneratedOffer) execution.getVariable(USER_OFFER);
        try {
            float distance = offerManager.getDistance(address, offer);
            execution.setVariable(USER_DISTANCE, distance);
            LOGGER.info("Distance: " + String.valueOf(distance));
            execution.setVariable(PREMIUM_SERVICE_ERROR, false);

        } catch (DistanceServiceException e) {
            LOGGER.severe(e.toString());
            execution.setVariable(PREMIUM_SERVICE_ERROR, true);
            throw new BpmnError(DISTANCE_ERROR);
        }
    }

}
