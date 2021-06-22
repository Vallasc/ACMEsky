package it.unibo.soseng.camunda.flights_manager;

import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_SERVICES;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.model.Airline;

@Named("initializeAirlineServiceDelegate")
public class InitializeAirlineServices implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger("retrieveFlightsOfInterestDelegate"); 

    @Override
    public void execute(DelegateExecution execution) throws Exception {
        List<Airline> airlineServices = new ArrayList<>();
        execution.setVariable(AIRLINE_SERVICES, airlineServices);
        
    }
    
}
