package it.unibo.soseng.camunda.flights_manager;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.gateway.airline.AirlineAPI;
import it.unibo.soseng.logic.airline.AirlineManager;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;
import static it.unibo.soseng.camunda.ProcessVariables.INTEREST_FLIGHTS_LIST;
import static it.unibo.soseng.camunda.ProcessVariables.FLIGHTS_TO_SAVE;

import javax.inject.Inject;
import javax.inject.Named;

@Named("searchFlightsDelegate")
public class SearchFlightsDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("searchFlightsDelegate"); 

    @Inject
    AirlineManager manager;

    @Override
    public void execute(DelegateExecution execution) throws IOException, InterruptedException{
      LOGGER.info ("searchFlightsDelegate in esecuzione");
      List<Flight> listToSave = manager.retrieveFlightsList((List<FlightInterest>) execution.getVariable(INTEREST_FLIGHTS_LIST));
      execution.setVariable(FLIGHTS_TO_SAVE, listToSave);

    }
}
