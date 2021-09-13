package it.unibo.soseng.camunda.user_manager;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_CONFIRM_BUY_OFFER;

/**
 * JavaDelegate associato al task "Clean environment" del diagramma BPMN
 * confirm_offer.bpmn. L'esecuzione del task porta alla cancellazione dello
 * stato del processo d'acquisto e conferma, visto che si è appena concluso.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Named("cleanEnvDelegate")
public class CleanEnvDelegate implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger(CleanEnvDelegate.class.getName());

    @Inject
    private ProcessState processState;

    /**
     * recupera l'username e l'offerta per poter rimuove il processo di acquisto e
     * conferma.
     */
    @Override
    public void execute(DelegateExecution execution) {
        LOGGER.info("Execute CleanEnvDelegate");
        String email = (String) execution.getVariable(USERNAME);
        GeneratedOffer offer = (GeneratedOffer) execution.getVariable(USER_OFFER);

        processState.getStateAndRemove(PROCESS_CONFIRM_BUY_OFFER, email, offer.getToken());
    }

}
