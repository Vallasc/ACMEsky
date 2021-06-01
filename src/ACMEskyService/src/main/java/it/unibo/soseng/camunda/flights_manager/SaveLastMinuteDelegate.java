package it.unibo.soseng.camunda.flights_manager;

import java.util.logging.Logger;
import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.gateway.airline.dto.AirlineFlightOffer;
import it.unibo.soseng.logic.airline.AirlineManager;

import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_FLIGHT_OFFERS;
import static it.unibo.soseng.camunda.ProcessVariables.AIRLINE_NAME;

@Named("saveLastMinuteDelegate")
public class SaveLastMinuteDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(SaveLastMinuteDelegate.class.getName());

    @Inject
    AirlineManager airlineManager;

    @Override
    public void execute(DelegateExecution execution){
        String airlineName = (String) execution.getVariable(AIRLINE_NAME);
        @SuppressWarnings (value="unchecked")
        List<AirlineFlightOffer> airlineOffers = 
            (List<AirlineFlightOffer>) execution.getVariable(AIRLINE_FLIGHT_OFFERS);

        airlineManager.saveAirlineOffers(airlineOffers, airlineName);
    }

}