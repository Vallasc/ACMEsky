package it.unibo.soseng.logic.database;

import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.enterprise.context.RequestScoped;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.transaction.Transactional;

import it.unibo.soseng.model.Airport;
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
    *  USER
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

    @Transactional
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
    *  AIRLINE
    */
    public List<FlightInterest> retrieveFlightInterests(){
        @SuppressWarnings("unchecked")
        List<FlightInterest> interests =
        entityManager.createQuery("SELECT f FROM FlightInterest f")
                        .getResultList();
        return interests;
    }

    public void insertFlightOffer(List<Flight> list){

        Iterator<Flight> i = list.iterator();

        while(i.hasNext()){
            entityManager.persist(i.next());
        }

    }

    public List<Flight> retrieveFlights(){
        @SuppressWarnings("unchecked")
        List<Flight> flights =
        entityManager.createQuery("SELECT f FROM Flight f")
                        .getResultList();
        return flights;
    }

    
    
    // public List<FlightInterest> retrieveFlightInterests() {
    //     @SuppressWarnings("unchecked")
    //     List<FlightInterest> interests = entityManager
    //             .createQuery("SELECT flight.departure_airport_id, flight.departure arrival_airport_id,"
    //                     + "flight.departure_date_time, flight.arrival_date_time " + "FROM flights_interest flight")
    //             .getResultList();
    //     return interests;
    // }

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
                .createQuery("SELECT interest FROM UserInterest interest")
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


    public void createOffer (GeneratedOffer offer) throws OfferAlreadyInException { 
        try {
            this.entityManager.persist(offer);
        } catch (PersistenceException e) {
            throw new OfferAlreadyInException();
        }
    }
    
    public Airport getAirport(String code) throws AirportNotFoundException {
        @SuppressWarnings("unchecked")
        List<Airport> result = (List<Airport>) entityManager
                .createQuery("SELECT a FROM Airport a WHERE a.code = :code")
                .setParameter("code", code).getResultList();
        if (result.size() == 1) {
            return result.get(0);
        }
        throw new AirportNotFoundException();
    }

    

    public void saveUserInterest(UserInterest interest) {
        this.entityManager.persist(interest);
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

    public class OfferAlreadyInException extends Exception {
        private static final long serialVersionUID = 1L;
    }

}
