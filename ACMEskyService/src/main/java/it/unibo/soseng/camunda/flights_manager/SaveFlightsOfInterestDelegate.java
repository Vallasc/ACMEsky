package it.unibo.soseng.camunda.flights_manager;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.model.Flight;

import static it.unibo.soseng.camunda.ProcessVariables.FLIGHTS_TO_SAVE;

import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

@Named("saveFlightsOfInterestDelegate")
public class SaveFlightsOfInterestDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("saveFlightsOfInterestDelegate"); 

    @Inject
    DatabaseManager manager;

    @Override
    public void execute(DelegateExecution execution){
      LOGGER.info ("saveFlightsOfInterestDelegate in esecuzione");
      manager.insertFlightOffer((List<Flight>) execution.getVariable(FLIGHTS_TO_SAVE));
      
    }
}

