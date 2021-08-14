package it.unibo.soseng.camunda.flights_manager.search_flights;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.gateway.airline.dto.InterestDTO;
import it.unibo.soseng.logic.airline.AirlineManager;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.model.Airline;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;

import static it.unibo.soseng.camunda.utils.ProcessVariables.AIRLINE_SERVICES;
import static it.unibo.soseng.camunda.utils.ProcessVariables.AIRLINE_SERVICES_INDEX;
import static it.unibo.soseng.camunda.utils.ProcessVariables.FLIGHTS_TO_SAVE;
import static it.unibo.soseng.camunda.utils.ProcessVariables.INTEREST_FLIGHTS_LIST;

import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

@Named("searchFlightsDelegate")
public class SearchFlightsDelegate implements JavaDelegate{
  private final static Logger LOGGER = Logger.getLogger(SearchFlightsDelegate.class.getName()); 

    @Inject
    AirlineManager manager;

    @Inject
    DatabaseManager dbManager;

    @Override
    public void execute(DelegateExecution execution) {
      LOGGER.info ("Execute searchFlightsDelegate");

      @SuppressWarnings (value="unchecked")
      List<Airline> airlines = (List<Airline>) execution.getVariable(AIRLINE_SERVICES);
      Airline a = airlines.get((int) execution.getVariable(AIRLINE_SERVICES_INDEX));

      @SuppressWarnings (value="unchecked")
      List<FlightInterest> interestsList = (List<FlightInterest>) execution.getVariable(INTEREST_FLIGHTS_LIST);
      List<InterestDTO> listDTO = manager.convertIntToIntDTO(interestsList);
      List<Flight> retrieveFlights;
      retrieveFlights = manager.retrieveFlightsList(listDTO, a.getWsAddress());
      int index = (int) execution.getVariable(AIRLINE_SERVICES_INDEX) + 1;
      execution.setVariable(AIRLINE_SERVICES_INDEX, index);
    
      execution.setVariable(FLIGHTS_TO_SAVE, retrieveFlights);
    }
}
