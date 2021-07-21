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
import it.soseng.unibo.airlineService.DTO.Flight;
import it.soseng.unibo.airlineService.DTO.UserRequest;
import it.soseng.unibo.airlineService.auth.Auth;
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

    private Auth auth = new Auth();

    
    /** 
     * genera una lista di offerte di volo randomicamente che viene cancellata se scaduta prima di essere salvata sul DB, 
     * converte l'offerta in volo e lo manda attraverso sendLastMinuteOffer se l'offerta risulta essere last-minute
     * rispetto alla data in cui l'offerta viene creata
     * @return FlightOffer che viene salvata nella rispettiva tabella del db
     * @throws JsonProcessingException 
     * @throws IOException
     */
    public void createFlightOffer(String s, String route, String user, String pass) throws JsonProcessingException, IOException {
        JsonNode n = u.GetRandomJsonObject(u.GetFile(s));
        List<FlightOffer> list = u.createOffer(n).stream().filter(i-> u.DeleteExpiredOffers(i) == false).collect(Collectors.toList());
        list.forEach(i->repo.save(i));
            if(list.stream().allMatch(o-> u.LastMinuteCheck(o) == true)){
                u.convertOffersToFlights(list);
                // richiedo il token jwt attraverso una richiesta http e la passo a sendLastMinuteOffer
                // che lo aggiungerà all'header della chiamata che fa per inviare le offerte last-minute
                // String jwt = auth.AuthRequest(route, user, pass);
                // sendLastMinuteOffer(list, route, jwt);

        }  
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
    public List<Flight> getMatchingFlights(List<UserRequest> r){

        List<FlightOffer> offers = u.getMatchingOffers(r, this.repo);
        List<Flight> l = new ArrayList<>();

        for(FlightOffer o : offers){
            l.add(u.convertOffertToFlight(o));
        }
        
        return l;
    }
        
    
    /** 
     * invia le offerte last-minute generate precedentemente ad ACMEsky
     * @param o l'offerta da inviare sulla route specifica
     */
    public void sendLastMinuteOffer(List<FlightOffer> f, String route, String jwt) {

        String url = route;
    
        // // create headers
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", jwt);
        // // set `content-type` header
        headers.setContentType(MediaType.APPLICATION_JSON);
        // // set `accept` header
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        // // build the request
        HttpEntity<List<FlightOffer>> entity = new HttpEntity<>(f, headers);
        // // send POST request
        RestTemplate restTemplate = new RestTemplate();
        
        ResponseEntity<FlightOffer> result = restTemplate.postForEntity(url, entity, FlightOffer.class);    
    }


    /** 
     * cancella le offerte di volo scadute
     */
    public void DeleteExpiredOffersFromDB() {
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


    /** 
     * cancella l'offerta di volo corrispondente all'id fornito come parametro
     * @param id
     */
    public boolean checkUnsoldFlights(long ...id) {
        for(long i : id){
            if(this.repo.findById(i).get().getSoldFlag()==true){
                return false;
            }else{
                u.soldFlights(this.repo, id);
                return true;
            }
        }
        return false;
    }
    

    /** 
     * cancella l'offerta di volo corrispondente all'id fornito come parametro
     * @param id
     */
    public void unsoldFlights(long ... id) {
        u.unsoldFlights(this.repo, id);
    }

    

    
    
}