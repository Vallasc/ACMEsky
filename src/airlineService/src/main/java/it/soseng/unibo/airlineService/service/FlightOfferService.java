package it.soseng.unibo.airlineService.service;

import java.io.IOException;

import java.util.List;
import java.util.stream.Collectors;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;

import org.springframework.beans.factory.annotation.Autowired;
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
public class FlightOfferService implements FlightOfferServiceInterface {

    @Autowired
    private FlightOfferRepository repo;

    private FlightUtility u = new FlightUtility();

    private final RestTemplate restTemplate = new RestTemplate();

    
    /** 
     * genera un offerta di volo randomicamente e manda l'offerta attraverso
     * sendLastMinuteOffer se risulta essere un'offerta last-minute
     * rispetto alla data in cui l'offerta viene creata
     * @return FlightOffer che viene salvata nella rispettiva tabella del db
     * @throws JsonProcessingException
     * @throws IOException
     */
    public FlightOffer createFlightOffer(String s) throws JsonProcessingException, IOException {
        JsonNode n = u.GetRandomJsonObject(u.GetFile(s));
        FlightOffer o = u.createOffer(n);
        if(u.LastMinuteCheck(o)){
            sendLastMinuteOffer(o);
        }else{}

        return repo.save(o);

        
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
     * già inviate ad ACMEsky al momento della loro generazione e le offerte già prenotate
     */
    @Override
    public List<FlightOffer> searchFlightOffers(UserRequest r){

        return repo.searchFlightOffers(r.departureCity, r.destinationCity, r.departureDate, r.destinationDate)
                    .stream()
                    .filter(w -> u.LastMinuteCheck(w) == false && w.getBookableFlagValue() == true)
                    .collect(Collectors.toList());
                    
    }


    
    /** 
     * invia le offerte last-minute generate precedentemente ad ACMEsky
     * @param o l'offerta da inviare sulla route specifica
     */
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

	
    /** 
     * recupera lo stato di un'offerta di volo (stato di prenotabilità)
     * @param id corrispondente all'offerta di cui si vuole conoscere lo stato
     * @return boolean lo stato dell'offerta
     */
    public boolean getOfferState(long id) {
        return repo.findById(id).get().getBookableFlagValue(); 
	}

    
    /** 
     * prenota l'offerta corrispondente all'id passato come parametro se prenotabile
     * @param id corrispondente all'offerta in questione
     * @return boolean esito della prenotazione
     */
    public boolean bookOffer(long id) {
		FlightOffer o = repo.findById(id).get();
        if(o.getBookableFlagValue()){
            o.setBookableFlagFalse();
            return true;
        }else{
            return false;
        }
	}

    
}
