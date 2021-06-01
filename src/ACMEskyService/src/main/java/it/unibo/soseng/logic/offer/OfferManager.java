package it.unibo.soseng.logic.offer;

import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.inject.Inject;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.OfferAlreadyInException;
import it.unibo.soseng.model.Flight;

@Stateless
public class OfferManager {
    private final static Logger LOGGER = Logger.getLogger(OfferManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;

    public void generateOffer(Flight request) throws OfferAlreadyInException {
        Flight flight = new Flight();
        flight.setFlightCode(request.getFlightCode());
        flight.setDepartureAirport(request.getDepartureAirport());
        flight.setArrivalAirport(request.getArrivalAirport());
        flight.setAirline(request.getAirlineId());
        flight.setDepartureDateTime(request.getDepartureDateTime());
        flight.setArrivalDateTime(request.getArrivalDateTime());
        flight.setExpireDate(request.getExpireDate());
        flight.setPrice(request.getPrice());
        flight.setBooked(true);
        databaseManager.createOffer(flight);
    }
}
