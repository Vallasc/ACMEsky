package it.unibo.soseng.camunda.flights_manager;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.database.DatabaseManager;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;
import static it.unibo.soseng.camunda.ProcessVariables.INTEREST_FLIGHTS_LIST;

@Named("retrieveFlightsOfInterestDelegate")
public class RetrieveFlightsOfInterestDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("retrieveFlightsOfInterestDelegate"); 

    @Inject
    private DatabaseManager dbManager;
    
    @Override
    public void execute(DelegateExecution execution){

        LOGGER.info ("retrieveFlightsOfInterestDelegate in esecuzione");
        execution.setVariable(INTEREST_FLIGHTS_LIST, dbManager.retrieveFlightInterests());
    }
}