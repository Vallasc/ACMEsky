package it.unibo.soseng.logic.offer;

import java.util.List;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.management.loading.PrivateClassLoader;

import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.OfferAlreadyInException;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.GeneratedOffer;
@Stateless
public class OfferManager {
    private final static Logger LOGGER = Logger.getLogger(OfferManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;

    public GeneratedOffer generateOffer(Flight requestOutBound, Flight requestFlightBack) throws OfferAlreadyInException {
        GeneratedOffer offerTogenerate = new GeneratedOffer ();
        offerTogenerate.setBooked(false);
        offerTogenerate.setOutboundFlightId(requestOutBound);
        offerTogenerate.setTotalPrice(requestOutBound.getPrice());
        double priceOutBound = offerTogenerate.getTotalPrice();
        if (requestFlightBack != null) {
            offerTogenerate.setFlightBackId(requestFlightBack);
            offerTogenerate.setTotalPrice(requestFlightBack.getPrice() + priceOutBound);
        }
        
        databaseManager.createOffer(offerTogenerate);
        return offerTogenerate;
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

