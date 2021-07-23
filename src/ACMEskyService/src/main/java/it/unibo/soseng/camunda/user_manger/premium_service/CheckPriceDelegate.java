package it.unibo.soseng.camunda.user_manger.premium_service;

import java.util.logging.Logger;

import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.gateway.user.dto.AddressDTO;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.AirportNotFoundException;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.GeneratedOffer;

import javax.inject.Inject;

import static it.unibo.soseng.camunda.ProcessVariables.USER_ADDRESS;
import static it.unibo.soseng.camunda.ProcessVariables.GENERATED_OFFER;
import static it.unibo.soseng.camunda.ProcessVariables.USERNAME;

@Named("checkPriceDelegate")
public class CheckPriceDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(CheckPriceDelegate.class.getName());

    @Inject 
    DatabaseManager databaseManager;

    @Override
    public void execute(DelegateExecution execution){
        LOGGER.info("Execute CheckPriceDelegate");
        
        // TODO Questa e' una roba di prova
        // Imposto indirizzo utente
        AddressDTO address = new AddressDTO();
        address.setAddress("Via filippo turati 50/2");
        address.setCityName("Bologna");
        address.setPostCode("40134");
        address.setCountry("Italy");
        execution.setVariable(USER_ADDRESS, address);
        execution.setVariable(USERNAME, "Paolo");

        GeneratedOffer offer = new GeneratedOffer();

        try {
            Flight outboundFlight = new Flight();
            outboundFlight.setDepartureAirport(databaseManager.getAirport("BLQ"));
            outboundFlight.setArrivalAirport(databaseManager.getAirport("AMS"));
            offer.setOutboundFlightId(outboundFlight);

            Flight flightBack = new Flight();
            flightBack.setDepartureAirport(databaseManager.getAirport("AMS"));
            flightBack.setArrivalAirport(databaseManager.getAirport("BLQ"));
            offer.setFlightBackId(flightBack);
            offer.setTotalPrice(10000);

            execution.setVariable(GENERATED_OFFER, offer);
        } catch (AirportNotFoundException e) {
            e.printStackTrace();
        }


    }
  
}
