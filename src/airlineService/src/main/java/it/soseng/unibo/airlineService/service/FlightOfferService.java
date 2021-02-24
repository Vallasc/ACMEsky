package it.soseng.unibo.airlineService.service;

import java.io.IOException;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import it.soseng.unibo.airlineService.model.FlightUtility;
import it.soseng.unibo.airlineService.model.FlightOffer;
import it.soseng.unibo.airlineService.model.Iban;
import it.soseng.unibo.airlineService.DTO.UserRequest;
import it.soseng.unibo.airlineService.repository.FlightOfferRepository;

@Service
@Transactional
public class FlightOfferService implements FlightOfferServiceInterface {

    @Autowired
    private FlightOfferRepository repo;

    private FlightUtility u = new FlightUtility();

    private final RestTemplate restTemplate = new RestTemplate();

    public FlightOffer createFlightOffer() throws JsonProcessingException, IOException {
        JsonNode n = u.GetRandomJsonObject(u.GetFile());
        FlightOffer o = u.createOffer(n);
        if(u.LastMinuteCheck(o)){
            sendLastMinuteOffer(o);
        }else{}

        return repo.save(o);

        
    }

    public void deleteFlightOffer(long id) {
        repo.deleteById(id);
        
    }


    public List<FlightOffer> getAll(){
        return repo.findAll();
    }

    public Iban sendIban(){
        Iban iban = Iban.getInstance();
        return iban;
    }


    @Override
    public List<FlightOffer> searchFlightOffers(UserRequest r){

        return repo.searchFlightOffers(r.departureCity, r.destinationCity, r.departureDate, r.destinationDate)
                    .stream()
                    .filter(w -> u.LastMinuteCheck(w) == false)
                    .collect(Collectors.toList());
                    
    }

    public void sendLastMinuteOffer(FlightOffer o) {
        // String url = "https://jsonplaceholder.typicode.com";
    
        // // create headers
        // HttpHeaders headers = new HttpHeaders();
        // // set `content-type` header
        // headers.setContentType(MediaType.APPLICATION_JSON);
        // // set `accept` header
        // headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
    
        // // build the request
        // HttpEntity<FlightOffer> entity = new HttpEntity<>(o, headers);
    
        // // send POST request
        // ResponseEntity<FlightOffer> result = restTemplate.postForEntity(url, entity, FlightOffer.class);
        // return result;
    
    }

    
}
