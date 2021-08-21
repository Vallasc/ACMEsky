package it.soseng.unibo.airlineService.service;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;

import org.hibernate.annotations.common.util.impl.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.server.ResponseStatusException;

import it.soseng.unibo.airlineService.model.FlightUtility;
import it.soseng.unibo.airlineService.model.FlightOffer;
import it.soseng.unibo.airlineService.DTO.Flight;
import it.soseng.unibo.airlineService.DTO.UserRequest;
import it.soseng.unibo.airlineService.auth.Auth;
import it.soseng.unibo.airlineService.repository.FlightOfferRepository;

/**
 * Questa classe definisce le caratteristiche delle offerte di volo
 * 
 * @author Andrea Di Ubaldo andrea.diubaldo@studio.unibo.it
 */
@Service
@Transactional
public class FlightOfferService {

    @Autowired
    private FlightOfferRepository repo;

    private FlightUtility u = new FlightUtility();

    private Auth auth = new Auth();

    private final static Logger LOGGER = Logger.getLogger(FlightOfferService.class.getName());

    /**
     * genera una lista di offerte di volo randomicamente che viene cancellata se
     * scaduta prima di essere salvata sul DB, converte l'offerta in volo e lo manda
     * attraverso sendLastMinuteOffer se l'offerta risulta essere last-minute
     * rispetto alla data in cui l'offerta viene creata
     * 
     * @return FlightOffer che viene salvata nella rispettiva tabella del db
     * @throws JsonProcessingException
     * @throws IOException
     */
    public void handleLastMinuteOffer(String s, String route, String user, String pass)
            throws JsonProcessingException, IOException {
        JsonNode n = u.GetRandomJsonLastminute(u.GetFile(s));
        List<FlightOffer> list = u.createOffer(n).stream().filter(i -> u.DeleteExpiredOffers(i) == false)
                .collect(Collectors.toList());
        list.forEach(i -> repo.save(i));

        // richiedo il token jwt attraverso una richiesta http e la passo a
        // sendLastMinuteOffer che lo aggiungerà all'header della chiamata che fa per
        // inviare le offerte last-minute
        try {
            String jwt = auth.AuthRequest(route, user, pass);
            System.out.println(jwt.toString());
            sendLastMinuteOffer(u.convertOffersToFlights(list), route, jwt);
        } catch (UnknownHostException e) {
            LOGGER.info("error");
        }

    }

    public void createFlightOffers(String s) throws JsonProcessingException, IOException {
        JsonNode[] arr = u.GetJsonOffers(u.GetFile(s));
        for (JsonNode n : arr) {
            List<FlightOffer> list = u.createOffer(n).stream().filter(i -> u.DeleteExpiredOffers(i) == false)
                    .collect(Collectors.toList());
            list.forEach(i -> repo.save(i));
        }
    }

    /**
     * ricerca le offerte di lavoro che hanno una corrispondenza del volo richiesto
     * dall'utente i cui parametri sono specificati dalla userRequest
     * 
     * @param r richiesta dell'utente
     * @return List<FlightOffer> la lista delle offerte di volo escludendo le
     *         offerte last-minute (già inviate ad ACMEsky al momento della loro
     *         generazione) e le offerte già prenotate
     */
    public List<Flight> getMatchingFlights(List<UserRequest> r) {

        List<FlightOffer> offers = u.getMatchingOffers(r, this.repo);
        HashMap<Long, FlightOffer> map = new HashMap<>();

        List<Flight> l = new ArrayList<>();

        for (FlightOffer o : offers) {
            map.putIfAbsent(o.getId(), o);

        }

        for (FlightOffer o : map.values()) {
            l.add(u.convertOffertToFlight(o));
        }

        return l;
    }

    /**
     * invia le offerte last-minute generate precedentemente ad ACMEsky
     * 
     * @param o l'offerta da inviare sulla route specifica
     */
    public void sendLastMinuteOffer(List<Flight> f, String route, String jwt) throws UnknownHostException {

        String url = route + "airlines/last_minute";

        // // create headers
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization ", "Bearer " + jwt);
        // // set `content-type` header
        headers.setContentType(MediaType.APPLICATION_JSON);
        // // set `accept` header
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        // // build the request
        HttpEntity<List<Flight>> entity = new HttpEntity<>(f, headers);
        // // send POST request
        RestTemplate restTemplate = new RestTemplate();

        restTemplate.postForEntity(url, entity, Flight.class);

    }

    public List<FlightOffer> getOffers(long... l) {

        ArrayList<FlightOffer> flights = new ArrayList<>();

        for (long id : l) {
            flights.add(repo.findById(id).get());
        }
        return flights;
    }

    /**
     * cancella l'offerta di volo corrispondente all'id fornito come parametro
     * 
     * @param id
     */
    public boolean checkUnsoldFlights(long... id) {
        for (long i : id) {
            if (this.repo.findById(i).get().getSoldFlag() == true) {
                return false;
            } else {
                u.soldFlights(this.repo, id);
                return true;
            }
        }
        return false;
    }

    /**
     * cancella l'offerta di volo corrispondente all'id fornito come parametro
     * 
     * @param id
     */
    public void unsoldFlights(long... id) {
        u.unsoldFlights(this.repo, id);
    }

}