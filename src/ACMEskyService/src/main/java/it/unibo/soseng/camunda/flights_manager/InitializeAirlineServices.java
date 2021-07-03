package it.unibo.soseng.camunda.flights_manager;
import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_SERVICES;
import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_SERVICES_INDEX;

import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.model.Airline;

@Named("initializeAirlineServiceDelegate")
public class InitializeAirlineServices implements JavaDelegate {

    @Inject
    private DatabaseManager dbManager;
    
    private final static Logger LOGGER = Logger.getLogger("retrieveFlightsOfInterestDelegate"); 

    @Override
    public void execute(DelegateExecution execution) throws Exception {
        List<Airline> airlines = dbManager.getAirlinesList();
        execution.setVariable(AIRLINE_SERVICES_INDEX, 0);
        execution.setVariable(AIRLINE_SERVICES, airlines);

    }
    
}
