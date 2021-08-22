package it.unibo.soseng.camunda.flights_manager.remove_expired_flights;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.AirlineManager;

@Named("removeExpiredFlightsDelegate")
public class RemoveExpiredFlights implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(RemoveExpiredFlights.class.getName());

    @Inject
    AirlineManager airlineManager;

    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("RemoveFlights is working");
        airlineManager.removeExpiredFlights();
    }

    
    
}
