package it.unibo.soseng.camunda.flights_manager.search_flights;

import static it.unibo.soseng.camunda.utils.ProcessVariables.FLIGHTS_TO_SAVE;

import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.model.Flight;


@Named("saveFlightsDelegate")
public class SaveFlightsDelegate implements JavaDelegate {
  private final static Logger LOGGER = Logger.getLogger(SaveFlightsDelegate.class.getName()); 

    @Inject
    DatabaseManager databaseManager;

    @Override
    public void execute(DelegateExecution execution){
      LOGGER.info ("saveFlightsDelegate in esecuzione");
      @SuppressWarnings (value="unchecked")
      List<Flight> flights = (List<Flight>) execution.getVariable(FLIGHTS_TO_SAVE);
      databaseManager.insertFlightOffer( flights );
    }
}
