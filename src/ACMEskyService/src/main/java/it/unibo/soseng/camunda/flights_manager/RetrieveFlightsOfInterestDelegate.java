package it.unibo.soseng.camunda.flights_manager;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.database.DatabaseManager;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

@Named("retrieveFlightsOfInterestDelegate")
public class RetrieveFlightsOfInterestDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("retrieveFlightsOfInterestDelegate"); 

    @Inject
    private DatabaseManager dbManager;
    
    @Override
    public void execute(DelegateExecution execution){

        LOGGER.info ("retrieveFlightsOfInterestDelegate in esecuzione");
        execution.setVariable("InterestList", dbManager.retrieveFlightInterests());
    }
}