package it.unibo.soseng.logic.offer;

import java.nio.charset.Charset;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.Random;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.management.loading.PrivateClassLoader;
import javax.persistence.PersistenceException;

import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.FlightNotExistException;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.GeneratedOffer;
@Stateless
public class OfferManager {
    private final static Logger LOGGER = Logger.getLogger(OfferManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;

    public GeneratedOffer generateOffer(Flight requestOutBound, Flight requestFlightBack) throws PersistenceException, FlightNotExistException {
        GeneratedOffer offerTogenerate = new GeneratedOffer ();
        
        offerTogenerate.setBooked(false);
        offerTogenerate.setOutboundFlightId(requestOutBound);
        offerTogenerate.setFlightBackId(requestFlightBack);
        offerTogenerate.setExpireDate(OffsetDateTime.now().plusHours(24));
        double priceOutBound = requestOutBound.getPrice();
        offerTogenerate.setTotalPrice(requestFlightBack.getPrice() + priceOutBound);
        offerTogenerate.setToken(getRandomString(10));
        databaseManager.createOffer(offerTogenerate);
        return offerTogenerate;
    }

    public Flight matchOffer (FlightInterest request) throws FlightNotExistException{
        List<Flight> flights = databaseManager.retrieveFlights();
        for (Flight f : flights) {

            if (!f.getBooked() && this.isMatched(f, request)) {
                // toReturn = new Flight ();
                // toReturn.setAirline(f.getAirlineId());
                // toReturn.setFlightCode(f.getFlightCode());
                // toReturn.setDepartureAirport(f.getDepartureAirport());
                // toReturn.setArrivalAirport(f.getArrivalAirport());
                // // TODO DAVA ERRORE
                // toReturn.setDepartureDateTime(f.getDepartureDateTime().toString());
                // toReturn.setArrivalDateTime(f.getArrivalDateTime().toString());
                // toReturn.setExpireDate(f.getExpireDate().toString());
                // toReturn.setPrice(f.getPrice());
                // toReturn.setBooked(true);
                return f;
            }
        }
        return null;
    }

    public void setFlightAvailability(Flight f){
        f.setAvailable(false);
        databaseManager.updateFlight(f);
    }

    private boolean isMatched (Flight f, FlightInterest fi) {
            return f.getDepartureAirport() == fi.getDepartureAirport() && f.getArrivalAirport() == fi.getArrivalAirport();
    }

    static String getRandomString(int i) 
    { 
        // bind the length 
        byte[] bytearray;
        bytearray = new byte[256];         
        String mystring;
        StringBuffer thebuffer;
        String theAlphaNumericS;

        new Random().nextBytes(bytearray); 

        mystring 
            = new String(bytearray, Charset.forName("UTF-8")); 
            
        thebuffer = new StringBuffer();
        
        //remove all spacial char 
        theAlphaNumericS 
            = mystring 
                .replaceAll("[^A-Z0-9]", ""); 

        //random selection
        for (int m = 0; m < theAlphaNumericS.length(); m++) { 

            if (Character.isLetter(theAlphaNumericS.charAt(m)) 
                    && (i > 0) 
                || Character.isDigit(theAlphaNumericS.charAt(m)) 
                    && (i > 0)) { 

                thebuffer.append(theAlphaNumericS.charAt(m)); 
                i--; 
            } 
        } 

        // the resulting string 
        return thebuffer.toString(); 
    } 
}

