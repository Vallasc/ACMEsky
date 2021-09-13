package it.unibo.soseng.camunda.flights_manager.search_flights;

import static it.unibo.soseng.camunda.utils.ProcessVariables.FLIGHTS_TO_SAVE;

import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.DatabaseManager;
import it.unibo.soseng.model.Flight;

/**
 * JavaDelegate associato al task "Save flights info in DB" del diagramma BPMN
 * search_flights.bpmn. Salva i voli ricevuti dall'ennesima AirlineService in
 * DB.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

@Named("saveFlightsDelegate")
public class SaveFlightsDelegate implements JavaDelegate {
  private final static Logger LOGGER = Logger.getLogger(SaveFlightsDelegate.class.getName());

  @Inject
  DatabaseManager databaseManager;

  /**
   * Acquisisce la lista dei voli dalla variabile di Camunda FLIGHTS_TO_SAVE e li
   * salva in DB richiamando il metodo del databaseManager
   */
  @Override
  public void execute(DelegateExecution execution) {
    LOGGER.info("Execute saveFlightsDelegate");
    @SuppressWarnings(value = "unchecked")
    List<Flight> flights = (List<Flight>) execution.getVariable(FLIGHTS_TO_SAVE);
    databaseManager.insertFlights(flights);
  }
}
