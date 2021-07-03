package it.unibo.soseng.camunda.flights_manager;

import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.model.Airline;
import it.unibo.soseng.model.Flight;

import static it.unibo.soseng.camunda.ProcessVariables.FLIGHTS_TO_SAVE;


@Named("saveFlightsDelegate")
public class SaveFlightsDelegate implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger("saveFlightsDelegate");

    @Inject
    DatabaseManager manager;

    @Override
    public void execute(DelegateExecution execution){
      LOGGER.info ("saveFlightsDelegate in esecuzione");
      // @SuppressWarnings (value="unchecked")
      manager.insertFlightOffer((List<Flight>) execution.getVariable(FLIGHTS_TO_SAVE));
    }
}
