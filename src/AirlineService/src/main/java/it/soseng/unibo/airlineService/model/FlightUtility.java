package it.soseng.unibo.airlineService.model;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.Random;
import java.util.stream.Collectors;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.support.ManagedMap;

import it.soseng.unibo.airlineService.DTO.Flight;
import it.soseng.unibo.airlineService.DTO.UserRequest;
import it.soseng.unibo.airlineService.repository.FlightOfferRepository;

/**
 * Questa classe definisce una serie di funzioni utili per la generazione
 * randomica da file json delle offerte di volo e per il riconoscimento di
 * offerte last-minute
 * 
 * @author Andrea Di Ubaldo andrea.diubaldo@studio.unibo.it
 */

public class FlightUtility {

    public FlightUtility() {
    }

    /**
     * restituisce un boolean che sta ad indicare se l'offerta è last-minute, ovvero
     * se la partenza prevista è entro i 10 giorni successivi alla data della
     * ricerca
     * 
     * @param list FlightOffer da valutare
     * @return boolean true che indica che l'offerta è last-minute(false per il
     *         viceversa)
     */
    public boolean LastMinuteCheck(FlightOffer o) {
        LocalDateTime now = LocalDateTime.now();
        long period = ChronoUnit.DAYS.between(now, o.getDepartureTime());
        if (period < (long) 10) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * specifica il file json da cui si possono generare i voli (attraverso l'url)
     * 
     * @return File che contiene un array di possibili offerte di volo
     */
    public File GetFile(String s) {

        String filePath = s;
        File file = new File(filePath);
        return file;
    }

    /**
     * restituisce un oggetto JsonNode che fa parte dell'array di oggetti json,
     * rappresentante una lista di offerte per lo stesso volo (biglietti)
     * 
     * @param file il file json
     * @return JsonNode il risultato della funzione
     * @throws JsonProcessingException
     * @throws IOException
     */
    public JsonNode GetRandomJsonLastminute(File file) throws JsonProcessingException, IOException {

        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(file);
        JsonNode offers = root.get("LAST-MINUTE");
        Random r = new Random();
        int i = r.ints(1, 0, offers.size()).toArray()[0];
        JsonNode n = offers.get(i);
        return n;
    }

    public JsonNode GetJsonOffers(File file) throws JsonProcessingException, IOException {

        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(file);
        JsonNode offers = root.get("OFFERS");
        JsonNode n = offers.get(0);
        return n;
    }

    /**
     * restituisce l'offerta di volo a partire dall'oggetto jsonNode i cui parametri
     * vengono convertiti nei valori che andranno a riempire i campi dell'offerta di
     * volo
     * 
     * @param n oggetto JsonNode
     * @return FlightOffer corrispondente al parametro n
     */
    public List<FlightOffer> createOffer(JsonNode n) {

        ArrayList<FlightOffer> a = new ArrayList<>();
        for (JsonNode i : n) {
            FlightOffer o = new FlightOffer();
            o.setDepartureCode(i.get("departure_airport_id").textValue());
            o.setDepartureTime(i.get("departure_date_time").textValue());
            o.setArrivalCode(i.get("arrival_airport_id").textValue());
            o.setArrivalTime(i.get("arrival_date_time").textValue());
            o.setAirline_id(i.get("airline_name").textValue());
            o.setPrice(i.get("price").asDouble());
            o.setPlace(i.get("place").textValue());
            o.setExpiryDate();
            a.add(o);
        }
        return a;
    }

    /**
     * converte l'offerta di volo passata come parametro in un volo che rappresenta
     * il volo di interesse dell'utente
     * 
     * @param i
     * @return
     */
    public Flight convertOffertToFlight(FlightOffer i) {
        Flight f = new Flight();
        f.setId(i.getId());
        f.setAirline_id(i.getAirline_id());
        f.setArrivalCode(i.getArrivalCode());
        f.setDepartureCode(i.getDepartureCode());
        f.setDepartureTime(i.getDepartureTime());
        f.setArrivalTime(i.getArrivalTime());
        f.setExpDate(i.getExpiryDate());
        f.setPrice(i.getPrice());

        return f;
    }

    public List<Flight> convertOffersToFlights(List<FlightOffer> list) {
        List<Flight> l = new ArrayList<>();
        for (FlightOffer o : list) {
            l.add(convertOffertToFlight(o));
        }
        return l;
    }

    /**
     * recupera le offerte di volo corrispondenti ai voli di interesse degli utenti
     * 
     * @param requests
     * @param repo
     * @return
     */
    public List<FlightOffer> getMatchingOffers(List<UserRequest> requests, FlightOfferRepository repo) {

        ArrayList<FlightOffer> list = new ArrayList<>();
        ArrayList<UserRequest> filteredList = new ArrayList<>();
        for (UserRequest req : requests) {
            if (!filteredList.contains(req)) {
                // ricerca per giorno, range 12 ore prima e dopo l'orario di richiesta
                list.addAll(repo.searchFlightOffers(req.departure, req.arrival).stream()
                        .filter(w -> LastMinuteCheck(w) == false && w.getSoldFlag() != true)
                        .filter(w -> w.getDepartureTime().isAfter(req.getDepartureOffsetDateTime().minusHours(12))
                                && w.getDepartureTime().isBefore(req.getDepartureOffsetDateTime().plusHours(12)))
                        .collect(Collectors.toList()));
            }
        }

        return list;
    }

    /**
     * cancella le offerte di volo scadute
     */
    public boolean DeleteExpiredOffers(FlightOffer o) {
        OffsetDateTime now = OffsetDateTime.now();
        if (o.getExpiryDate().isBefore(now)) {
            return true;
        }
        return false;
    }

    /**
     * cancella l'offerta di volo corrispondente all'id fornito come parametro
     * 
     * @param id
     */
    public void soldFlights(FlightOfferRepository repo, long... id) {
        for (long i : id) {
            if (repo.existsById(i)) {
                repo.findById(i).get().setSoldFlag(true);
            }
        }
    }

    /**
     * cancella l'offerta di volo corrispondente all'id fornito come parametro
     * 
     * @param id
     */
    public void unsoldFlights(FlightOfferRepository repo, long... id) {
        for (long i : id) {
            if (repo.existsById(i)) {
                repo.findById(i).get().setSoldFlag(false);
            }
        }
    }

}