package it.soseng.unibo.airlineService.model;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Random;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Questa classe definisce una serie di funzioni utili per la generazione randomica da file json
 * delle offerte di volo e per il riconoscimento di offerte last-minute
 * @author Andrea Di Ubaldo
 * andrea.diubaldo@studio.unibo.it
 */

public class FlightUtility {

    public FlightUtility() {
    }

    
    /** 
     * restituisce un boolean che sta ad indicare se l'offerta è last-minute, ovvero se la partenza
     * prevista è entro i 10 giorni successivi alla data della ricerca
     * @param o FlightOffer da valutare
     * @return boolean true che indica che l'offerta è last-minute(false per il viceversa)
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
     * @return File che contiene un array di possibili offerte di volo
     */
    public File GetFile(){
        String filePath = "fileSampleOffers/flights.json";
        File file = new File(filePath);
        return file;
    }

    
    /**
     * restituisce un oggetto JsonNode che fa parte dell'array di oggetti json,
     * rappresentante un offerta di volo 
     * @param file il file json 
     * @return JsonNode il risultato della funzione
     * @throws JsonProcessingException
     * @throws IOException
     */
    public JsonNode GetRandomJsonObject(File file) throws JsonProcessingException, IOException {
            
            
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(file);
        JsonNode offers = root.get("OFFERS");
        Random r = new Random();
        int i = r.ints(1, 0, offers.size()).toArray()[0];
        JsonNode n = offers.get(i);
        return n;
    }

    
    /** 
     * restituisce l'offerta di volo a partire dall'oggetto jsonNode
     * i cui parametri vengono convertiti nei valori che andranno a riempire i campi
     * dell'offerta di volo 
     * 
     * @param n oggetto JsonNode
     * @return FlightOffer corrispondente al parametro n
     */
    public FlightOffer createOffer(JsonNode n){
        FlightOffer o = new FlightOffer();
            o.setDeparture(n.get("departure").textValue());
            o.setDestination(n.get("destination").textValue());
            o.setDepartureTime(n.get("departureTime").textValue());
            o.setDestinationTime(n.get("destinationTime").textValue());
            o.setPrice(n.get("price").asDouble());

            return o;
    }


    


        
}
    








































