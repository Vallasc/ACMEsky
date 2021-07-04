package it.unibo.soseng.logic.offer;

import java.util.List;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.inject.Inject;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.OfferAlreadyInException;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;
@Stateless
public class OfferManager {
    private final static Logger LOGGER = Logger.getLogger(OfferManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;

    public void generateOffer(Flight request) throws OfferAlreadyInException {
        databaseManager.createOffer(request);
    }

    public Flight matchOffer (FlightInterest request) {
        List<Flight> flights = databaseManager.retrieveFlights();
        Flight toReturn = null;
        for (Flight f : flights) {
            if (!f.getBooked() && this.isMatched(f, request)) {
                toReturn = new Flight ();
                toReturn.setAirline(f.getAirlineId());
                toReturn.setFlightCode(f.getFlightCode());
                toReturn.setDepartureAirport(f.getDepartureAirport());
                toReturn.setArrivalAirport(f.getArrivalAirport());
                // TODO DAVA ERRORE
                //toReturn.setDepartureDateTime(f.getDepartureDateTime());
                //toReturn.setArrivalDateTime(f.getArrivalDateTime());
                //toReturn.setExpireDate(f.getExpireDate());
                toReturn.setPrice(f.getPrice());
                toReturn.setBooked(true);
            }
        }
        return toReturn;
    }

    private boolean isMatched (Flight f, FlightInterest fi) {
            return f.getDepartureAirport() == fi.getDepartureAirport() && f.getArrivalAirport() == fi.getArrivalAirport();
    }
}

