package it.soseng.unibo.airlineService.service;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Logger;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.soseng.unibo.airlineService.model.FlightUtility;
import it.soseng.unibo.airlineService.model.FlightOffer;
import it.soseng.unibo.airlineService.DTO.Flight;
import it.soseng.unibo.airlineService.DTO.UserRequest;
import it.soseng.unibo.airlineService.auth.Auth;
import it.soseng.unibo.airlineService.repository.FlightOfferRepository;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

/**
 * Questa classe offre le funzionalità che vengono invocate quando i servizi
 * esterni fanno richiesta alle route del controller.
 * 
 * @author Andrea Di Ubaldo andrea.diubaldo@studio.unibo.it
 */
@Service
@Transactional
public class FlightOfferService {

    /**
     * repository delle offerte di volo
     */
    @Autowired
    private FlightOfferRepository repo;

    private FlightUtility u = new FlightUtility();

    private Auth auth = new Auth();

    final MediaType JSON = MediaType.get("application/json; charset=utf-8");

    private final static Logger LOGGER = Logger.getLogger(FlightOfferService.class.getName());

    /**
     * genera una lista di offerte di volo last-minute randomicamente, le salva in
     * Db e richiede un token valido ad ACMEsky per inviargli i voli generati non
     * scaduti
     * 
     * @return FlightOffer che viene salvata nella rispettiva tabella del db
     * @throws JsonProcessingException
     * @throws IOException
     */
    public void handleLastMinuteOffer(String s, String route, String user, String pass)
            throws JsonProcessingException, IOException {
        List<JsonNode> n = u.GetRandomJsonLastminute(u.GetFile(s));
        ArrayList<FlightOffer> l = new ArrayList<>();
        for (JsonNode i : n) {
            FlightOffer of = u.createOffer(i);
            l.add(of);
            repo.save(of);
        }

        try {
            String jwt = auth.AuthRequest(route, user, pass);
            l.removeIf(o -> u.DeleteExpiredOffers(o));
            ArrayList<Flight> flights = new ArrayList<>();
            for (FlightOffer o : l) {

                flights.add(u.convertOfferToFlight(o));
            }

            if (!flights.isEmpty()) {
                sendLastMinuteOffer(flights, route, jwt);

            }
        } catch (UnknownHostException e) {
            LOGGER.info("error");
        }

    }

    /**
     * genera tutte le offerte di volo non last-minute presenti nell'array OFFERS
     * 
     * @param s
     * @throws JsonProcessingException
     * @throws IOException
     */
    public void createFlightOffers(String s) throws JsonProcessingException, IOException {
        List<JsonNode> l = u.GetJsonOffers(u.GetFile(s));

        for (JsonNode n : l) {
            FlightOffer of = u.createOffer(n);
            if (!u.DeleteExpiredOffers(of)) {

                repo.save(of);
            }
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
            l.add(u.convertOfferToFlight(o));
        }

        return l;
    }

    /**
     * invia le offerte last-minute generate precedentemente ad ACMEsky
     * 
     * @param o l'offerta da inviare sulla route specifica
     * @throws IOException
     */
    public void sendLastMinuteOffer(List<Flight> f, String route, String jwt) throws IOException {

        String url = route + "airlines/last_minute";

        ObjectMapper objectMapper = new ObjectMapper();
        OkHttpClient client = new OkHttpClient();

        String requestBody = objectMapper.writeValueAsString(f);

        RequestBody body = RequestBody.create(requestBody, JSON);
        Request request = new Request.Builder().url(url).addHeader("Content-Type", "application/json")
                .addHeader("Authorization", "Bearer " + jwt).post(body).build();
        try (Response response = client.newCall(request).execute()) {
            if (response.code() != 200) {
                response.code();
            }
        }
    }

    public List<FlightOffer> getOffers(long... l) {

        ArrayList<FlightOffer> flights = new ArrayList<>();

        for (long id : l) {
            flights.add(repo.findById(id).get());
        }
        return flights;
    }

}