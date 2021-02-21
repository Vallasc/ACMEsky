package it.soseng.unibo.airlineService.model;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Random;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;


public class FlightUtility {

    public FlightUtility() {
    }

    public boolean LastMinuteCheck(FlightOffer o) {
        LocalDateTime now = LocalDateTime.now();
        long period = ChronoUnit.DAYS.between(now, o.getDepartureTime());
        if (period < (long) 10) {

            return true;
        } else {
            return false;
        }
    }

    public File GetFile(){
        String filePath = "src/main/java/it/soseng/unibo/airlineService/fileSampleOffers/flights.json";
        File file = new File(filePath);
        return file;
    }

    public JsonNode GetRandomJsonObject(File file) throws JsonProcessingException, IOException {
            
            
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(file);
        JsonNode offers = root.get("OFFERS");
        Random r = new Random();
        int i = r.ints(1, 0, offers.size()).toArray()[0];
        JsonNode n = offers.get(i);
        return n;
    }

    public FlightOffer createOffer(JsonNode n){
        FlightOffer o = new FlightOffer();
            o.setDeparture(n.get("departure").textValue());
            o.setDestination(n.get("destination").textValue());
            o.setDepartureTime(n.get("departureTime").textValue());
            o.setDestinationTime(n.get("destinationTime").textValue());
            o.setPrice(n.get("price").textValue());

            return o;
    }


        // public String RandomLine() throws FileNotFoundException {

        //     String result = new String();
        //     String file = "d:/flights.txt";
        //     Random r = new Random();
        //     int i = r.nextInt(2);
        //     i++;
        //     Scanner scanner = new Scanner(new File(file));
        //     int cicle = 0;
        //     while (cicle != i) {
        //         cicle++;
        //         String l = scanner.nextLine();
        //         result = l;
        //     }
        //     scanner.close();
        //     return result;
        // }

        // public String[] FlightParts(String line) {
        //     StringTokenizer st = new StringTokenizer(line);
        //     String[] arr = new String[7];
        //     int i = 0;

        //     while (st.hasMoreTokens()){
        //         String s = st.nextToken().toString(); 
        //         arr[i] = s;
        //         i++;
        //     }
            
        //     return arr;
        // }

        // public FlightOffer createOffer(String[] flightParts) throws ParseException, FileNotFoundException {
        //     DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        //     String dateDepartureString = flightParts[1] + " " + flightParts[2];
        //     String dateDestinationString = flightParts[3]  + " " + flightParts[4];
		// 	LocalDateTime dateDeparture = LocalDateTime.parse(dateDepartureString, formatter);
        //     LocalDateTime dateDestination= LocalDateTime.parse(dateDestinationString, formatter);  
        //     return new FlightOffer(flightParts[0], dateDeparture, dateDestination,  flightParts[5], flightParts[6]);        
        // }
    
        // public String[] flightCities(){
        //     Random r = new Random();
        //     int[] i = new int[2];
        //     do {
        //         i = r.ints(2, 0, cities.size()).toArray();
        //     }
        //         while (i[0] == i[1]);
        //     String cities[] = new String [2];
        //     cities[0] = this.cities.get(i[0]);
        //     cities[1] = this.cities.get(i[1]);
        //     return cities;
        // }
    


        
}
    








































