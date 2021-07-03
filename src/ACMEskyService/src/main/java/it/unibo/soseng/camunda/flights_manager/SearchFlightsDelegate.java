package it.unibo.soseng.camunda.flights_manager;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.gateway.airline.dto.AirlineDTO;
import it.unibo.soseng.gateway.airline.dto.InterestDTO;
import it.unibo.soseng.logic.airline.AirlineManager;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.AirlineNotFoundException;
import it.unibo.soseng.logic.database.DatabaseManager.AirportNotFoundException;
import it.unibo.soseng.model.Airline;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;
import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_SERVICES;
import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_SERVICES_INDEX;
import static it.unibo.soseng.camunda.ProcessVariables.INTEREST_FLIGHTS_LIST;
import static it.unibo.soseng.camunda.ProcessVariables.FLIGHTS_TO_SAVE;

import javax.inject.Inject;
import javax.inject.Named;

@Named("searchFlightsDelegate")
public class SearchFlightsDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger("searchFlightsDelegate"); 

    @Inject
    AirlineManager manager;

    @Inject
    DatabaseManager dbManager;

    @Override
    public void execute(DelegateExecution execution) throws IOException, InterruptedException, AirportNotFoundException, AirlineNotFoundException{
      LOGGER.info ("searchFlightsDelegate in esecuzione");
      List<AirlineDTO> airlines = manager.convertToAirlineDTO((List<Airline>) execution.getVariable(AIRLINE_SERVICES));
      AirlineDTO a = airlines.get((int) execution.getVariable(AIRLINE_SERVICES_INDEX));

      List<InterestDTO> listDTO = manager.convertIntToIntDTO((List<FlightInterest>) execution.getVariable(INTEREST_FLIGHTS_LIST));
      List<Flight> listToSave = manager.retrieveFlightsList(listDTO, a.getWs_address());
      int index = (int) execution.getVariable(AIRLINE_SERVICES_INDEX) + 1;
      execution.setVariable(AIRLINE_SERVICES_INDEX, index);
      
      execution.setVariable(FLIGHTS_TO_SAVE, listToSave);
      

    }
}
