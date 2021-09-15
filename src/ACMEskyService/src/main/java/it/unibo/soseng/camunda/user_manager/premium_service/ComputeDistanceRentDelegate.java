package it.unibo.soseng.camunda.user_manager.premium_service;

import static it.unibo.soseng.camunda.utils.ProcessVariables.NEAREST_RENT;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_ADDRESS;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.gateway.user.dto.AddressDTO;
import it.unibo.soseng.logic.OfferManager;
import it.unibo.soseng.model.RentService;

/**
 * JavaDelegate associato al task "Compute distance rent" del diagramma BPMN
 * confirm_offer.bpmn. L'esecuzione di questo task controlla la compagnia di 
 * noleggio più vicina all'utente
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Named("computeDistanceRentDelegate")
public class ComputeDistanceRentDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(AskRentDelegate.class.getName());

    @Inject
    OfferManager offerManager;

    /**
     * Il metodo individua la compagnia di noleggio più vicina all'utente
     * e l'assegna alla variabile di processo.
     */
    @Override
    public void execute(DelegateExecution execution) {
        LOGGER.info("Execute ComputeDistanceRentDelegate");
        AddressDTO address = (AddressDTO) execution.getVariable(USER_ADDRESS);
        RentService nearest = offerManager.getNearestRent(address);
        execution.setVariable(NEAREST_RENT, nearest);
    }

}
