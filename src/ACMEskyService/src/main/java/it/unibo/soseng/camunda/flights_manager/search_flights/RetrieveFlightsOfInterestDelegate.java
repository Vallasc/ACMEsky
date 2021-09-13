package it.unibo.soseng.camunda.flights_manager.search_flights;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.DatabaseManager;

import static it.unibo.soseng.camunda.utils.ProcessVariables.INTEREST_FLIGHTS_LIST;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

/**
 * JavaDelegate associato al task "Retrieve flights of interest from DB" del
 * diagramma BPMN search_flights.bpmn. Recupera la lista dei voli di interesse
 * degli utenti per fare la ricerca
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

@Named("retrieveFlightsOfInterestDelegate")
public class RetrieveFlightsOfInterestDelegate implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger(RetrieveFlightsOfInterestDelegate.class.getName());

    @Inject
    private DatabaseManager dbManager;

    /**
     * Assegna alla variabile di Camunda la lista dei voli di interesse
     */
    @Override
    public void execute(DelegateExecution execution) {
        LOGGER.info("Execute retrieveFlightsOfInterestDelegate");
        execution.setVariable(INTEREST_FLIGHTS_LIST, dbManager.retrieveFlightInterests());
    }
}