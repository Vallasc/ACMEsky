package it.unibo.soseng.logic.offer;

import static it.unibo.soseng.camunda.utils.ProcessVariables.RENT_BACK;
import static it.unibo.soseng.camunda.utils.ProcessVariables.RENT_OUTBOUND;

import java.io.IOException;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.PersistenceException;

import org.camunda.bpm.engine.delegate.DelegateExecution;

import it.unibo.soseng.gateway.distance.DistanceClient;
import it.unibo.soseng.gateway.distance.DistanceClient.GeoserverErrorException;
import it.unibo.soseng.gateway.distance.dto.DistanceDTO;
import it.unibo.soseng.gateway.rent.RentClient;
import it.unibo.soseng.gateway.user.dto.AddressDTO;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.FlightNotExistException;
import it.unibo.soseng.logic.database.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.model.Airport;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.model.User;
import it.unibo.soseng.model.UserInterest;
import it.unibo.soseng.ws.generated.BookRent;
import it.unibo.soseng.ws.generated.BookRentResponse;
import it.unibo.soseng.ws.generated.Rent;
import it.unibo.soseng.ws.generated.RentService1;
import it.unibo.soseng.ws.generated.RentService2;
@Stateless
public class OfferManager {
    private final static Logger LOGGER = Logger.getLogger(OfferManager.class.getName());

    @Inject
    private DatabaseManager databaseManager;

    @Inject
    private DistanceClient distanceClient;

    @Inject
    private RentClient rentClient;

    public GeneratedOffer generateOffer(Flight outBound, Flight flightBack, String username) throws PersistenceException, FlightNotExistException, UserNotFoundException {    
        this.setFlightUnavailable(outBound);
        this.setFlightUnavailable(flightBack);

        GeneratedOffer generatedOffer = new GeneratedOffer ();
        generatedOffer.setBooked(false);
        generatedOffer.setAvailable(true);
        generatedOffer.setOutboundFlightId(outBound);
        generatedOffer.setFlightBackId(flightBack);
        generatedOffer.setExpireDate(OffsetDateTime.now().plusHours(24));
        generatedOffer.setTotalPrice(flightBack.getPrice() + outBound.getPrice());
        User user = databaseManager.getUser(username);
        generatedOffer.setUser(user);

        databaseManager.createOffer(generatedOffer);
        String uniqueToken = UUID.randomUUID().toString().substring(0, 4) + String.valueOf(generatedOffer.getId());
        generatedOffer.setToken(uniqueToken);
        databaseManager.updateOffer(generatedOffer);
        return generatedOffer;
    }

    public List<Flight> checkFlightsRequirements(UserInterest ui){
        List<Flight> matchedFlights = new ArrayList<Flight> ();
        List<Flight> flights = databaseManager.retrieveFlights();

        for(Flight flight1 : flights){
            if(this.isMatched(flight1, ui.getOutboundFlightInterest())){
                for(Flight flight2 : flights){
                    if(flight1 != flight2 && this.isMatched(flight2, ui.getFlightBackInterest()) &&
                    flight1.getPrice() + flight2.getPrice() <= ui.getPriceLimit()){
                        matchedFlights.add(flight1);
                        matchedFlights.add(flight2);
                        return matchedFlights;
                    }
                }
            }
        }

        return matchedFlights;
    }

    private boolean isMatched (Flight f, FlightInterest fi) {
        OffsetDateTime flightDate = f.getDepartureDateTime();
        OffsetDateTime interestDateStart = fi.getDepartureDateTime();
        OffsetDateTime interestDateEnd = interestDateStart.plusDays(1);

        return f.getDepartureAirport() == fi.getDepartureAirport() && 
                f.getArrivalAirport() == fi.getArrivalAirport() &&
                interestDateStart.compareTo(flightDate) <=0 && 
                interestDateEnd.compareTo(flightDate) >=0;
    }

    public void setFlightUnavailable(Flight f){
        f.setAvailable(false);
        databaseManager.updateFlight(f);
    }

    public void removeExpiredOffers() {
        /*OffsetDateTime now = OffsetDateTime.now();
        List<GeneratedOffer> expFlights = databaseManager.getAvailableFlights().stream().dropWhile(f -> f.getExpireDate().isBefore(now)).collect(Collectors.toList());
        for (ListIterator<Flight> iter = expFlights.listIterator(); iter.hasNext(); ) {
            Flight f = iter.next();
            f.setAvailable(false);
            databaseManager.updateFlight(f);
        }*/
    } 

    public class SendTicketException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    public void setUsedUserInterest(UserInterest userInterest){
        userInterest.setUsed(true);
        userInterest.getOutboundFlightInterest().setUsed(true);
        userInterest.getFlightBackInterest().setUsed(true);
        databaseManager.updateUserInterest(userInterest);
    }

    /**
     * Ritona la distanza tra l'aereoporto dell'offerta e línidirizzo inserito
     * @throws DistanceServiceException
     */
    public float getDistance(AddressDTO userAddress, GeneratedOffer offer) throws DistanceServiceException {
        Float latitude = offer.getOutboundFlightId().getDepartureAirport().getLatitude();
        Float longitude = offer.getOutboundFlightId().getDepartureAirport().getLongitude();
        String fullAddress = userAddress.getAddress() + ", " + userAddress.getPostCode() + " " + userAddress.getCityName() + ", " + userAddress.getCountry();
        try {
            DistanceDTO distance = distanceClient.requestDistance(fullAddress , latitude.toString() + ',' + longitude.toString());
            if(!distance.getStatus().equals("OK"))
                throw new DistanceServiceException();
            return distance.getValue();
        } catch (IOException | GeoserverErrorException e) {
            LOGGER.severe(e.toString());
            throw new DistanceServiceException();
        }
    }

    public void bookAllRent(String email, AddressDTO address, GeneratedOffer offer, DelegateExecution execution) throws UserNotFoundException {
        User user = databaseManager.getUser(email);
        String userAddress = address.getAddress() + ", " + address.getPostCode() + " " + address.getCityName() + ", " + address.getCountry();
        Airport airport = offer.getOutboundFlightId().getDepartureAirport();
        String airportAddress = String.valueOf(airport.getLatitude()) +','+ String.valueOf(airport.getLongitude());
        try {
            BookRentResponse reponse = this.bookRent(RentService1.class, user, userAddress, airportAddress);
            execution.setVariable(RENT_OUTBOUND, reponse);
        } catch (RentServiceException e) {
            LOGGER.info(e.toString());
        }
        try {
            BookRentResponse reponse = this.bookRent(RentService2.class, user, airportAddress, userAddress);
            execution.setVariable(RENT_BACK, reponse);
        } catch (RentServiceException e) {
            LOGGER.info(e.toString());
        }
    }

    public BookRentResponse bookRent(Class service, User user, String addressFrom, String addressTo) throws RentServiceException {
        RentService1 rentService1 = new RentService1();
        RentService2 rentService2 = new RentService2();
        Rent ws;
        if( service.getName() == "RentService1" )
            ws = rentService1.getRentServicePort();
        else
            ws = rentService2.getRentServicePort();

        BookRent bookRent = new BookRent();
        bookRent.setClientName(user.getName()); 
        bookRent.setClientSurname(user.getSurname());
        bookRent.setFromAddress(addressFrom);
        bookRent.setToAddress(addressTo);

        return rentClient.rentRequest(ws, bookRent);
    }

    public class DistanceServiceException extends Exception {}

    public class RentServiceException extends Exception {}
   
}

