package it.unibo.soseng.camunda.user_manager.confirm_offer;

import org.camunda.bpm.engine.delegate.JavaDelegate;
import org.camunda.bpm.engine.delegate.DelegateExecution;

import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.logic.AirlineManager;

import static it.unibo.soseng.camunda.utils.ProcessVariables.ASYNC_RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_CONFIRM_BUY_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;

import java.util.logging.Logger;
import javax.inject.Inject;
import javax.inject.Named;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.core.Response;

/**
 * JavaDelegate associato al task "Send error" e "Send success" del diagramma
 * BPMN confirm_offer.bpmn. Si occupa di far riprendere il processo di acquisto
 * in caso l'offerta sia ancora valida, o di fermare il tutto in caso di errore.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Named("sendOfferResponseDelegate")
public class SendOfferResponseDelegate implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger(SendOfferResponseDelegate.class.getName());

    @Inject
    private ProcessState processState;

    @Inject
    AirlineManager airlineManager;

    /**
     * recupera lo stato della richiesta, positivo o negativo che sia, lo elimina e
     * infine lo comunica all'utente che riprendere la procedura di acquisto o
     * fermarsi a causa di errori.
     */
    @Override
    public void execute(DelegateExecution execution) {

        LOGGER.info("Execute sendOfferResponseDelegate");

        String email = (String) execution.getVariable(USERNAME);
        Response response = (Response) processState.getStateAndRemove(PROCESS_CONFIRM_BUY_OFFER, email, RESPONSE);
        AsyncResponse asyncResponse = (AsyncResponse) processState.getStateAndRemove(PROCESS_CONFIRM_BUY_OFFER, email,
                ASYNC_RESPONSE);
        asyncResponse.resume(response);
    }

}