package it.soseng.unibo.airlineService.service;

import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.core.JsonProcessingException;

import it.soseng.unibo.airlineService.model.FlightOffer;
import it.soseng.unibo.airlineService.DTO.UserRequest;

public interface FlightOfferServiceInterface {

    public FlightOffer createFlightOffer() throws JsonProcessingException, IOException ;

    public void deleteFlightOffer(long id);

    public List<FlightOffer> searchFlightOffers(UserRequest r);



    
}
