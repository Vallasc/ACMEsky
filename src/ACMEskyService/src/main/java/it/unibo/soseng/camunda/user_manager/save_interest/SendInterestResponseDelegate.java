package it.unibo.soseng.camunda.user_manager.save_interest;

import static it.unibo.soseng.camunda.utils.ProcessVariables.ASYNC_RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_SAVE_INTEREST;
import static it.unibo.soseng.camunda.utils.ProcessVariables.RESPONSE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.URI_INFO;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.core.Response;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.camunda.utils.ProcessState;

/**
 * JavaDelegate associato al task "Send response" del diagramma BPMN
 * save_interest.bpmn. Questo task si occupa di informare l'utente dello stato
 * di accettazione e presa in carico dell'offerta che desira in modo da farne
 * riprendere o no il processo di ricerca di offerte disponibili corrispondenti.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Named("sendInterestResponseDelegate")
public class SendInterestResponseDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(SendInterestResponseDelegate.class.getName());

    @Inject
    private ProcessState processState;

    /**
     * Prende lo stato del processo e l'username dell'utente per informarlo dello
     * stato della sua richiesta e a seconda dell'esito procedere con la ricerca di
     * offerte compatibili o meno.
     */
    @Override
    public void execute(DelegateExecution execution) {
        LOGGER.info("Execute SendInterestResponse");

        String email = (String) execution.getVariable(USERNAME);
        Response response = (Response) processState.getStateAndRemove(PROCESS_SAVE_INTEREST, email, RESPONSE);
        AsyncResponse asyncResponse = (AsyncResponse) processState.getStateAndRemove(PROCESS_SAVE_INTEREST, email,
                ASYNC_RESPONSE);
        asyncResponse.resume(response);

        processState.getStateAndRemove(PROCESS_SAVE_INTEREST, email, URI_INFO);
    }
}
