package it.soseng.unibo.airlineService.service;

import java.io.IOException;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.ListIterator;
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

/**
 * Questa classe definisce le caratteristiche delle offerte di volo
 * @author Andrea Di Ubaldo
 * andrea.diubaldo@studio.unibo.it
 */
@Service
@Transactional
public class FlightOfferService {

    @Autowired
    private FlightOfferRepository repo;

    private FlightUtility u = new FlightUtility();

    
    /** 
     * genera un offerta di volo randomicamente e manda l'offerta attraverso
     * sendLastMinuteOffer se risulta essere un'offerta last-minute
     * rispetto alla data in cui l'offerta viene creata
     * @return FlightOffer che viene salvata nella rispettiva tabella del db
     * @throws JsonProcessingException
     * @throws IOException
     */
    public void createFlightOffer(String s) throws JsonProcessingException, IOException {
        JsonNode n = u.GetRandomJsonObject(u.GetFile(s));
        List<FlightOffer> o = u.createOffer(n);
        for(FlightOffer i : o ){
            if(u.LastMinuteCheck(i)){
                // sendLastMinuteOffer(o);
            }else{}
            repo.save(i);
        }
        
    }

    
    /** 
     * cancella l'offerta di volo corrispondente all'id fornito come parametro
     * @param id
     */
    public void deleteFlightOffer(long id) {
        repo.deleteById(id);
        
    }


    
    /** 
     * restituisce la lista di tutte le offerte di volo presenti nel db
     * @return List<FlightOffer>
     */
    public List<FlightOffer> getAll(){
        return repo.findAll();
    }

    
    /** 
     * restituisce l'unica istanza Iban contenente le coordinate bancarie 
     * del servizio airline 
     * @param iban
     * @return Iban
     */
    public Iban sendIban(String iban){
        Iban.getInstance().setIban(iban);
        return Iban.getInstance();
    }


    
    /** 
     * ricerca le offerte di lavoro che hanno una corrispondenza del volo richiesto dall'utente
     * i cui parametri sono specificati dalla userRequest
     * @param r richiesta dell'utente
     * @return List<FlightOffer> la lista delle offerte di volo escludendo le offerte last-minute
     * (già inviate ad ACMEsky al momento della loro generazione) e le offerte già prenotate
     */
    public List<FlightOffer> searchFlightOffers(List<UserRequest> r){

        ArrayList<FlightOffer> list = new ArrayList<>();
        
            for(UserRequest req : r){
                list.addAll(repo.searchFlightOffers(req.departureCity, req.destinationCity, req.departureDate, req.destinationDate)
                .stream().filter(w -> u.LastMinuteCheck(w) == false && w.getBookedFlagValue() == false).collect(Collectors.toList()));
            }
            return list;
        }
        


    
    /** 
     * invia le offerte last-minute generate precedentemente ad ACMEsky
     * @param o l'offerta da inviare sulla route specifica
     */
    public void sendLastMinuteOffer(FlightOffer o) {

        String url = "http://localhost:8080/airline/offers";
    
        // // create headers
        HttpHeaders headers = new HttpHeaders();
        // // set `content-type` header
        headers.setContentType(MediaType.APPLICATION_JSON);
        // // set `accept` header
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        // // build the request
        HttpEntity<FlightOffer> entity = new HttpEntity<>(o, headers);
        // // send POST request
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<FlightOffer> result = restTemplate.postForEntity(url, entity, FlightOffer.class);    
    }

	
    /** 
     * prenota un'offerta di volo(se non è già stata prenotata)
     * @param id corrispondente all'offerta di cui si vuole conoscere lo stato
     * @return boolean lo stato dell'offerta
     */
    public boolean bookOffer(long id) {
        FlightOffer o = repo.findById(id).get();
        if(o.getBookedFlagValue() == false){
            u.getOfferExpiry(o);
            return true;
        }else{
            return false;
        }        
	}

    /** 
     * cancella la prenotazione delle offerte che non sono state acquistate entro il tempo della scadenza(10 min)
     */
    public void DeleteExpiredBooking(){
        OffsetDateTime now = OffsetDateTime.now();
        ListIterator<FlightOffer> iterator= repo.findAll().listIterator();

        while(iterator.hasNext()){
            FlightOffer o = iterator.next();
            if(o.getBookedFlagValue()==true){
                OffsetDateTime expiryBookingOffer = o.getExpiryBooking().plusMinutes(1);
                if(now.equals(expiryBookingOffer) || now.isAfter(expiryBookingOffer)){
                    o.setBookedFlag(false);
                    o.setExpiryBooking(null);
                }
            }else{}
        }
    }

    /** 
     * cancella le offerte di volo scadute
     */
    public void DeleteExpiredOffers() {
        OffsetDateTime now = OffsetDateTime.now();
        ListIterator<FlightOffer> iterator= repo.findAll().listIterator();

        while(iterator.hasNext()){
            FlightOffer o = iterator.next();
            if(now.equals(o.getExpiryDate()) || now.isAfter(o.getExpiryDate())){
                repo.deleteById(o.getId());
            }
        }
    }

    


    public List<FlightOffer> getOffers(long ... l){

        ArrayList<FlightOffer> flights = new ArrayList<>();
        
        for( long id : l){
          flights.add(repo.findById(id).get());
        }
          return flights;
    }


    

    
    
}
