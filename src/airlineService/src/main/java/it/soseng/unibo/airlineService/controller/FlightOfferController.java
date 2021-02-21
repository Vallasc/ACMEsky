package it.soseng.unibo.airlineService.controller;

import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.core.JsonProcessingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import it.soseng.unibo.airlineService.DTO.UserRequest;
import it.soseng.unibo.airlineService.model.FlightOffer;
import it.soseng.unibo.airlineService.model.Iban;
import it.soseng.unibo.airlineService.service.FlightOfferService;

@RestController
public class FlightOfferController {

    @Autowired
    private FlightOfferService s;

    @Scheduled(fixedRate = 1000)
    @PostMapping("/createOffer")
    private FlightOffer autoCreateOffer() throws JsonProcessingException, IOException {
        
    return s.createFlightOffer();
        
    }

    @PostMapping("/searchFlight")
    public List<FlightOffer> getOffers (@RequestBody UserRequest r){

        return s.searchFlightOffers(r);

    }

    @GetMapping("/getAll")
    public List<FlightOffer> getAll (){

        return s.getAll();

    }

    @DeleteMapping("/removeOfferByID")
    public void getOfferById (@RequestParam(name = "id") long id){
        s.deleteFlightOffer(id);
    }

    

    @PostMapping("/iban")
    public Iban sendIban(){
        return s.sendIban();
    }
}
