package it.unibo.soseng.camunda.user_manager.confirm_offer;

import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_CONFIRM_BUY_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER_REQUEST;
import static it.unibo.soseng.camunda.utils.ProcessVariables.OFFER_TOKEN;

import java.util.logging.Logger;

import javax.inject.Named;
import javax.ws.rs.core.Response;
import javax.inject.Inject;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.OfferManager;
import it.unibo.soseng.logic.DatabaseManager.OfferNotFoundException;
import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.gateway.user.dto.UserOfferDTO;

/**
 * JavaDelegate associato al task "Retrieve offer" del diagramma BPMN
 * confirm_offer.bpmn. Questo task si occupa di iniziare la procedura di
 * recuperare la richiesta dell'utente e verificare che l'offerta di volo sia
 * ancora valida prima di prima di continuare il flusso di esecuzione.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Named("retrieveOfferDelegate")
public class RetrieveOfferDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(RetrieveOfferDelegate.class.getName());

    @Inject
    OfferManager offerManager;

    @Inject
    private ProcessState processState;

    /**
     * Recupera il token dell'offerta che vuole acquistare, l'username e la
     * richiesta dell'utente. In seguito verifica lo stato della richiesta e lo
     * imposta come stato del processo
     * 
     */
    @Override
    public void execute(DelegateExecution execution) throws OfferNotFoundException {
        LOGGER.info("Execute RetrieveOffer");
        UserOfferDTO offerRequest = (UserOfferDTO) execution.getVariable(USER_OFFER_REQUEST);
        String token = (String) execution.getVariable(OFFER_TOKEN);
        String email = (String) execution.getVariable(USERNAME);
        Response response = offerManager.handleConfirmOffer(token, email, offerRequest, execution);
        processState.setState(PROCESS_CONFIRM_BUY_OFFER, email, RESPONSE, response);
    }

}
