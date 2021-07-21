package it.unibo.soseng.logic.offer;

import java.util.List;
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
import it.unibo.soseng.model.UserInterest;
@Stateless
public class OfferManager {
    private final static Logger LOGGER = Logger.getLogger(OfferManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;

    public GeneratedOffer generateOffer(Flight requestOutBound, Flight requestFlightBack, UserInterest ui) throws PersistenceException, FlightNotExistException {
        GeneratedOffer offerTogenerate = new GeneratedOffer ();

        offerTogenerate.setBooked(false);
        offerTogenerate.setOutboundFlightId(requestOutBound);
        offerTogenerate.setFlightBackId(requestFlightBack);
        offerTogenerate.setExpireDate(requestOutBound.getExpireDate());
        offerTogenerate.setUser(ui.getUser().getEntity());
        double priceOutBound = requestOutBound.getPrice();
        offerTogenerate.setTotalPrice(requestFlightBack.getPrice() + priceOutBound);
        
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

    public class SendTicketException extends Exception {
        private static final long serialVersionUID = 1L;
    }
   
}

