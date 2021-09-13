package it.unibo.soseng.camunda.offers_manager;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.DatabaseManager;
import it.unibo.soseng.logic.OfferManager;
import it.unibo.soseng.logic.DatabaseManager.FlightNotExistException;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.UserInterest;

import static it.unibo.soseng.camunda.utils.ProcessVariables.AVAILABLE_FLIGHTS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.THERE_IS_FLIGHTS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PRONTOGRAM_USERNAME;
import static it.unibo.soseng.camunda.utils.ProcessVariables.CURRENT_USER_INTEREST;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_INTERESTS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_INTEREST_INDEX;

import java.util.List;
import java.util.logging.Logger;
import javax.inject.Inject;
import javax.inject.Named;

/**
 * JavaDelegate associato al task "Check available flights matching user
 * interest" del diagramma BPMN offer_manager.bpmn. Quando si attiva il task
 * ACMEsky controlla se tra i voli proposti dalle compagnie aeree vi sono quelli
 * che combaciano con i voli delle offerte di interesse degli utenti, e questo
 * per ogni offerta richiesta.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

@Named("checkAvailableFlightsDelegate")
public class CheckAvailableFlightsDelegate implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger(CheckAvailableFlightsDelegate.class.getName());

    @Inject
    DatabaseManager dbManager;

    @Inject
    OfferManager offerManager;

    /**
     * Il metodo recupera la lista dei voli di interesse e assegna l'ennesima
     * offerta ad una variabile, successivamente aumenta la variabile usata come
     * indice per poter acquisire l'offerta successiva nella prossima chiamata del
     * metodo. Infine prende i voli che combaciano con quelli dell'ennesima offerta
     * di interesse presente nella lista delle offerte richieste e li assegna alla
     * variabile AVAILABLE_FLIGHTS.
     */
    @Override
    public void execute(DelegateExecution execution) throws FlightNotExistException {
        LOGGER.info("Execute checkAvailableFlightsDelegate");

        @SuppressWarnings("unchecked")
        List<UserInterest> userInterests = (List<UserInterest>) execution.getVariable(USER_INTERESTS);
        int index = (int) execution.getVariable(USER_INTEREST_INDEX);
        execution.setVariable(USER_INTEREST_INDEX, index + 1);

        UserInterest ui = userInterests.get(index);
        execution.setVariable(CURRENT_USER_INTEREST, ui);
        execution.setVariable(USERNAME, ui.getUser().getEntity().getUsername());
        execution.setVariable(PRONTOGRAM_USERNAME, ui.getUser().getProntogramUsername());

        List<Flight> matchedFlights = offerManager.checkFlightsRequirements(ui);
        if (matchedFlights.size() != 0) {
            execution.setVariable(AVAILABLE_FLIGHTS, matchedFlights);
            execution.setVariable(THERE_IS_FLIGHTS, true);
        } else {
            execution.setVariable(THERE_IS_FLIGHTS, false);
        }
    }
}
