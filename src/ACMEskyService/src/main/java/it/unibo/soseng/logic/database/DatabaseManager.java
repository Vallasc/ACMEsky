package it.unibo.soseng.logic.database;

import java.util.List;
import java.util.logging.Logger;

import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.transaction.Transactional;

import it.unibo.soseng.model.Airline;
import it.unibo.soseng.model.Airport;
import it.unibo.soseng.model.Bank;
import it.unibo.soseng.model.DomainEntity;
import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.model.User;
import it.unibo.soseng.model.UserInterest;

@Stateless
@TransactionManagement(value = TransactionManagementType.CONTAINER)
public class DatabaseManager {

    private final static Logger LOGGER = Logger.getLogger(DatabaseManager.class.getName());

    @PersistenceContext(unitName = "primary")
    private EntityManager entityManager;


    /*
    *  User
    */
    public User getUser(String email) throws UserNotFoundException {
        @SuppressWarnings("unchecked")
        List<User> result = (List<User>) entityManager
                .createQuery("SELECT u FROM User u, DomainEntity e WHERE e.username = :username AND u.entity = e.id")
                .setParameter("username", email).getResultList();
        if (result.size() == 1) {
            return result.get(0);
        }
        throw new UserNotFoundException();
    }

    public GeneratedOffer getOfferByToken(String token, String email) throws OfferNotFoundException {
        GeneratedOffer result = (GeneratedOffer) entityManager
                .createQuery("SELECT go FROM User u, DomainEntity e, GeneratedOffer go "+ 
                "WHERE e.username = :username AND u.entity = e.id "+
                "AND go.token = :token AND go.user = u.id")
                .setParameter("token", token).setParameter("username", email).getSingleResult();
        if (result == null) {
            throw new OfferNotFoundException();
        }
        return result;
    }

    @Transactional // TODO vedere transactional per gli altri metodi
    public void createUser(User user) throws UserAlreadyInException {
        try {
            this.entityManager.persist(user);
        } catch (PersistenceException e) {
            //LOGGER.severe(e.toString());
            throw new UserAlreadyInException();
        }
    }

    @Transactional
    public void updateUser(User user) {
        this.entityManager.merge(user);
    }

    @Transactional
    public void removeUser(User user) throws PersistenceException {
        this.entityManager.remove(user);
    }


    /*
    *  Airline
    */
    public List<FlightInterest> retrieveFlightInterests(){
        @SuppressWarnings("unchecked")
        List<FlightInterest> interests =
        entityManager.createQuery("SELECT f FROM FlightInterest f WHERE f.used = false")
                        .getResultList();
        return interests;
    }

    // public GeneratedOffer retrieveGeneratedOffer(){
    //     @SuppressWarnings("unchecked")
    //     List<GeneratedOffer> offers =
    //     entityManager.createQuery("SELECT o FROM GeneratedOffer o")
    //                     .getResultList();
    //     return offers.get(0);
    // }

    public void insertFlightOffer(List<Flight> list){
        for(Flight f: list){
            entityManager.persist(f);
        }
    }

    public List<Flight> retrieveFlights(){
        @SuppressWarnings("unchecked")
        List<Flight> flights =
        entityManager.createQuery("SELECT f FROM Flight f WHERE f.available = true AND f.booked = false")
                        .getResultList();
        return flights;
    }

    public List<Airline> getAirlinesList(){

        @SuppressWarnings("unchecked")
        List<Airline> airlines = entityManager
                    .createQuery("SELECT airline FROM Airline airline ")
                    .getResultList();
            return airlines;

    }
    
    public Airline getAirline(String airlineId) throws AirlineNotFoundException {
        @SuppressWarnings("unchecked")
        List<Airline> result = (List<Airline>) entityManager
                .createQuery("SELECT a FROM Airline a, DomainEntity e WHERE e.username = :airlineId AND a.entity = e.id")
                .setParameter("airlineId", airlineId).getResultList();
        if (result.size() == 1) {
            return result.get(0);
        }
        throw new AirlineNotFoundException();
    }

    // public List<Flight> availableFlights(Long id) {
    //     @SuppressWarnings("unchecked")
    //     List<Flight> availableFlight = entityManager
    //             .createQuery(
    //             "SELECT f FROM Flight f, FlightInterest fi, UserInterest ui WHERE ui.id = "+id+ 
    //             "AND ui.outbound_flight_interest_id = fi.id" + 
    //             "AND fi.departure_airport_id = f.departure_airport_id"+ 
    //             "AND fi.arrival_airport_id = f.arrival_airport_id"+
    //             "AND fi.departure_date_time = f.departure_date_time")
    //             .getResultList();
    //     return availableFlight;
    // }

    public List<UserInterest> retrieveUserInterests() {
        @SuppressWarnings("unchecked")
        List<UserInterest> interests = entityManager
                .createQuery("SELECT ui FROM UserInterest ui WHERE ui.used = FALSE")
                .getResultList();
        return interests;
    }

    public DomainEntity getEntity(String username) throws EntityNotFoundException {
        @SuppressWarnings("unchecked")
        List<DomainEntity> result = (List<DomainEntity>) entityManager
                .createQuery("SELECT e FROM DomainEntity e WHERE e.username = :username")
                .setParameter("username", username).getResultList();
        if (result.size() == 1) {
            return result.get(0);
        }
        throw new EntityNotFoundException();
    }


    public void createOffer (GeneratedOffer offer) throws PersistenceException { 
        this.entityManager.persist(offer);
    }

    public void updateOffer (GeneratedOffer offer) throws PersistenceException { 
        this.entityManager.merge(offer);
    }

    public List<Flight> getAvailableFlights() {
        @SuppressWarnings("unchecked")
        List<Flight> expFlights = (List<Flight>) entityManager
                .createQuery("SELECT f FROM Flight f WHERE f.booked = FALSE AND f.available = TRUE")
                .getResultList();
        return expFlights;
    }

    // Airport
    
    public Airport getAirport(String code) throws AirportNotFoundException {
        @SuppressWarnings("unchecked") 
        List<Airport> result = (List<Airport>) entityManager
                .createQuery("SELECT a FROM Airport a WHERE a.code = :code")
                .setParameter("code", code).getResultList();
        if (result.size() > 0) {
            return result.get(0);
        }
        throw new AirportNotFoundException();
    }
    
    public List<Airport> getAirportsFromQuery(String query) {
        @SuppressWarnings("unchecked")
        List<Airport> result = (List<Airport>) entityManager
                .createQuery("SELECT a FROM Airport a WHERE "+
                                "LOWER( a.code ) LIKE LOWER( :query ) OR " +
                                "LOWER( a.name ) LIKE LOWER( :query ) OR " +
                                "LOWER( a.cityName ) LIKE LOWER( :query ) " +
                                "ORDER BY LENGTH(a.cityName) ASC, LENGTH(a.name) ASC, LENGTH(a.code) ASC ")
                .setParameter("query", "%" + query + "%")
                .setMaxResults(4)
                .getResultList();
        return result;
    }


    /*
     * Interest
     */
    public void saveUserInterest(UserInterest interest) {
        this.entityManager.persist(interest);
    }

    public void updateUserInterest(UserInterest userInterest){
        this.entityManager.merge(userInterest);
    }

    public List<UserInterest> getUserInterests(String username) {
        @SuppressWarnings("unchecked")
        List<UserInterest> result = (List<UserInterest>) entityManager
            .createQuery("SELECT ui FROM UserInterest ui, User u, DomainEntity d " +
                            "WHERE d.username = :username AND u.entity = d.id AND ui.user = u.id AND ui.used = FALSE " +
                            "ORDER BY ui.id DESC")
            .setParameter("username", username).getResultList();
        return result;
    }

    public UserInterest getUserInterest(String username, String interestId) {
        @SuppressWarnings("unchecked")
        List<UserInterest> result = (List<UserInterest>) entityManager
            .createQuery("SELECT ui FROM UserInterest ui, User u, DomainEntity d " +
                            "WHERE d.username = :username AND u.entity = d.id AND " + 
                            "ui.user = u.id AND ui.id = :interestId")
            .setParameter("username", username)
            .setParameter("interestId", Long.parseLong(interestId)).getResultList();
            if (result.get(0) != null)
                return result.get(0);
            return null;
    }

    public void updateFlight(Flight f){
        this.entityManager.merge(f);
    }

    public void setBookFlights(boolean b, Flight requestOutbound, Flight requestFlightBack ) {

        requestOutbound.setBooked(b);
        requestFlightBack.setBooked(b);
        this.entityManager.merge(requestOutbound);
        this.entityManager.merge(requestFlightBack);
	}


    public Bank getBank() throws BankNotFoundException{
        @SuppressWarnings("unchecked") 
        List<Bank> result = (List<Bank>) entityManager
                .createQuery("SELECT b FROM Bank b")
                .getResultList();
        if (result.size() > 0) {
            return result.get(0);
        }
        throw new BankNotFoundException();
    }



    public class EntityNotFoundException extends Exception {
        private static final long serialVersionUID = 1L;
    }
    public class UserNotFoundException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    public class UserAlreadyInException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    public class AirportNotFoundException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    public class AirlineNotFoundException extends Exception {
        private static final long serialVersionUID = 1L;
    }

    public class FlightNotExistException extends Exception {
        private static final long serialVersionUID = 1L;
    }
    public class OfferNotFoundException extends Exception {
        private static final long serialVersionUID = 1L;
    }
    public class BankNotFoundException extends Exception {
        private static final long serialVersionUID = 1L;
    }

	
}
