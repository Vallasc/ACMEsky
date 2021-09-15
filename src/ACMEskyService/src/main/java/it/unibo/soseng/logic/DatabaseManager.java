package it.unibo.soseng.logic;

import java.util.List;

import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
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
import it.unibo.soseng.model.RentService;
import it.unibo.soseng.model.User;
import it.unibo.soseng.model.UserInterest;

/**
 * Logica che utilizza le classi del model e del gateway per interagire con il
 * Database
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Stateless
@TransactionManagement(value = TransactionManagementType.CONTAINER)
public class DatabaseManager {

    // private final static Logger LOGGER =
    // Logger.getLogger(DatabaseManager.class.getName());

    @PersistenceContext(unitName = "primary")
    private EntityManager entityManager;

    /**
     * Entity
     * 
     * prende l'entità del dominio corrispondente a quell'username
     * 
     * @param username
     * @return
     * @throws EntityNotFoundException
     */
    public DomainEntity getEntity(String username) throws EntityNotFoundException {
        try {
            DomainEntity result = (DomainEntity) entityManager
                    .createQuery("SELECT e FROM DomainEntity e WHERE e.username = :username")
                    .setParameter("username", username).getSingleResult();
            return result;
        } catch (NoResultException e) {
            throw new EntityNotFoundException();
        }
    }

    /**
     * Bank
     * 
     * recupera la banca con il nome passato per parametro
     * 
     * @param name
     * @return
     * @throws BankNotFoundException
     */
    // Bank
    public Bank getBank(String name) throws BankNotFoundException {
        try {
            Bank result = (Bank) entityManager
                    .createQuery("SELECT b FROM Bank b, DomainEntity e WHERE e.username = :name AND b.entity = e.id")
                    .setParameter("name", name).getSingleResult();
            return result;
        } catch (NoResultException e) {
            throw new BankNotFoundException();
        }
    }

    /**
     * RentService
     * 
     * Recupera tutti i RentService registrati sul Database
     * 
     * @return
     */
    public List<RentService> getAllRentServices() {

        @SuppressWarnings("unchecked")
        List<RentService> result = (List<RentService>) entityManager.createQuery("SELECT r FROM RentService r")
                .getResultList();
        return result;
    }

    /**
     * User
     * 
     * recupera l'utente con l'email passata come parametro
     * 
     * @param email
     * @return
     * @throws UserNotFoundException
     */

    public User getUser(String email) throws UserNotFoundException {
        try {
            User result = (User) entityManager
                    .createQuery(
                            "SELECT u FROM User u, DomainEntity e WHERE e.username = :username AND u.entity = e.id")
                    .setParameter("username", email).getSingleResult();
            return result;
        } catch (NoResultException e) {
            throw new UserNotFoundException();
        }
    }

    /**
     * registra l'utente sul Database
     * 
     * @param user
     * @throws UserAlreadyInException
     */
    @Transactional // TODO vedere transactional per gli altri metodi
    public void createUser(User user) throws UserAlreadyInException {
        try {
            this.entityManager.persist(user);
        } catch (PersistenceException e) {
            // LOGGER.severe(e.toString());
            throw new UserAlreadyInException();
        }
    }

    /**
     * aggiorna le informazioni dell'utente registrato sul DB
     * 
     * @param user
     */
    @Transactional
    public void updateUser(User user) {
        this.entityManager.merge(user);
    }

    /**
     * rimuove l'utente dal Database
     * 
     * @param user
     * @throws PersistenceException
     */
    @Transactional
    public void removeUser(User user) throws PersistenceException {
        this.entityManager.remove(user);
    }

    /**
     * Airline
     * 
     * recupera la lista dei voli di interesse
     * 
     * @return
     */
    public List<FlightInterest> retrieveFlightInterests() {
        @SuppressWarnings("unchecked")
        List<FlightInterest> interests = entityManager
                .createQuery("SELECT f FROM FlightInterest f WHERE f.used = FALSE").getResultList();
        return interests;
    }

    /**
     * recupera i voli che non sono già stati acquistati e che sono prenotabili al
     * momento
     * 
     * @return
     */
    public List<Flight> retrieveFlights() {
        @SuppressWarnings("unchecked")
        List<Flight> flights = entityManager
                .createQuery("SELECT f FROM Flight f WHERE f.available = true AND f.booked = false").getResultList();
        return flights;
    }

    /**
     * recupera la lista di AirlineService registrata sul DB
     * 
     * @return
     */
    public List<Airline> getAirlinesList() {

        @SuppressWarnings("unchecked")
        List<Airline> airlines = entityManager.createQuery("SELECT airline FROM Airline airline ").getResultList();
        return airlines;

    }

    /**
     * recupera l'oggetto Airline corrispondente all'identificativo fornito come
     * parametro
     * 
     * @param airlineId
     * @return
     * @throws AirlineNotFoundException
     */
    public Airline getAirline(String airlineId) throws AirlineNotFoundException {
        @SuppressWarnings("unchecked")
        List<Airline> result = (List<Airline>) entityManager
                .createQuery(
                        "SELECT a FROM Airline a, DomainEntity e WHERE e.username = :airlineId AND a.entity = e.id")
                .setParameter("airlineId", airlineId).getResultList();
        if (result.size() == 1) {
            return result.get(0);
        }
        throw new AirlineNotFoundException();
    }

    /**
     * recupera la lista delle offerte di interesse degli utenti
     * 
     * @return
     */
    public List<UserInterest> retrieveUserInterests() {
        @SuppressWarnings("unchecked")
        List<UserInterest> interests = entityManager.createQuery("SELECT ui FROM UserInterest ui WHERE ui.used = FALSE")
                .getResultList();
        return interests;
    }

    /**
     * prende l'oggetto Airport con il codice passato come parametro
     * 
     * @param code
     * @return
     * @throws AirportNotFoundException
     */
    public Airport getAirport(String code) throws AirportNotFoundException {
        try {
            Airport result = (Airport) entityManager.createQuery("SELECT a FROM Airport a WHERE a.code = :code")
                    .setParameter("code", code).getSingleResult();
            return result;
        } catch (NoResultException e) {
            throw new AirportNotFoundException();
        }
    }

    /**
     * recupera una lista di aereoporti sulla base dei suggerimenti degli utenti
     * 
     */
    public List<Airport> getAirportsFromQuery(String query) {
        @SuppressWarnings("unchecked")
        List<Airport> result = (List<Airport>) entityManager
                .createQuery("SELECT a FROM Airport a WHERE " + "LOWER( a.code ) LIKE LOWER( :query ) OR "
                        + "LOWER( a.name ) LIKE LOWER( :query ) OR " + "LOWER( a.cityName ) LIKE LOWER( :query ) "
                        + "ORDER BY LENGTH(a.cityName) ASC, LENGTH(a.name) ASC, LENGTH(a.code) ASC ")
                .setParameter("query", "%" + query + "%").setMaxResults(4).getResultList();
        return result;
    }

    /**
     * Interest
     * 
     * salva in DB l'offerta di volo di interesse dell'utente
     * 
     * @param interest
     */
    public void saveUserInterest(UserInterest interest) {
        this.entityManager.persist(interest);
    }

    /**
     * aggiorna l'offerta di volo di interesse dell'utente
     * 
     * @param userInterest
     */
    public void updateUserInterest(UserInterest userInterest) {
        this.entityManager.merge(userInterest);
    }

    /**
     * recupera la lista delle offerte di volo di interesse dell'utente il cui
     * username viene passato come parametro
     * 
     * @param username
     * @return
     */
    public List<UserInterest> getUserInterests(String username) {
        @SuppressWarnings("unchecked")
        List<UserInterest> result = (List<UserInterest>) entityManager
                .createQuery("SELECT ui FROM UserInterest ui, User u, DomainEntity d "
                        + "WHERE d.username = :username AND u.entity = d.id AND ui.user = u.id AND ui.used = FALSE "
                        + "ORDER BY ui.id DESC")
                .setParameter("username", username).getResultList();
        return result;
    }

    /**
     * recupera l'offerta di volo di interesse dell'utente il cui username viene
     * passato come parametro, con l'identificativo specificato dal parametro
     * interestId
     * 
     * @param username
     * @param interestId
     * @return
     * @throws InterestNotFoundException
     */
    public UserInterest getUserInterest(String username, String interestId) throws InterestNotFoundException {
        try {
            UserInterest result = (UserInterest) entityManager
                    .createQuery("SELECT ui FROM UserInterest ui, User u, DomainEntity d "
                            + "WHERE d.username = :username AND u.entity = d.id AND "
                            + "ui.user = u.id AND ui.id = :interestId")
                    .setParameter("username", username).setParameter("interestId", Long.parseLong(interestId))
                    .getSingleResult();
            return result;
        } catch (NoResultException e) {
            throw new InterestNotFoundException();
        }
    }

    /**
     * flights
     * 
     * registra la lista di voli ricevuti dalle compagnie aeree in DB
     * 
     * @param list
     */
    public void insertFlights(List<Flight> list) {
        for (Flight flight : list) {
            entityManager.persist(flight);
        }
    }

    /**
     * aggiorna il volo fornito come parametro
     * 
     * @param flight
     */

    public void updateFlight(Flight flight) {
        this.entityManager.merge(flight);
    }

    /**
     * recupera la lista di voli disponibili all'acquisto e non prenotati al momento
     * dell'invocazione
     * 
     * @return
     */
    public List<Flight> getAvailableFlights() {
        @SuppressWarnings("unchecked")
        List<Flight> expFlights = (List<Flight>) entityManager
                .createQuery("SELECT f FROM Flight f WHERE f.booked = FALSE AND f.available = TRUE").getResultList();
        return expFlights;
    }

    /**
     * imposta lo stato di prenotabilità dei voli di andata e ritorno di un'offerta
     * al valore b
     * 
     * @param b
     * @param outboundFlight
     * @param flightBack
     */
    public void setBookFlights(boolean b, Flight outboundFlight, Flight flightBack) {

        outboundFlight.setBooked(b);
        flightBack.setBooked(b);
        updateFlight(outboundFlight);
        updateFlight(flightBack);
    }

    /**
     * Offer
     * 
     * registra in DB l'offerta di volo generata da ACMEsky
     * 
     * @param offer
     * @throws PersistenceException
     */
    public void createOffer(GeneratedOffer offer) throws PersistenceException {
        this.entityManager.persist(offer);
    }

    /**
     * aggiorna l'offerta generata da ACMEsky fornita come parametro
     * 
     * @param offer
     * @throws PersistenceException
     */
    public void updateOffer(GeneratedOffer offer) throws PersistenceException {
        this.entityManager.merge(offer);
    }

    /**
     * recupera l'offerta di volo con il token e l'username passati come parametri
     * della funzione
     * 
     * @param token
     * @param email
     * @return
     * @throws OfferNotFoundException
     */
    public GeneratedOffer getOfferByTokenEmail(String token, String email) throws OfferNotFoundException {
        try {
            GeneratedOffer result = (GeneratedOffer) entityManager
                    .createQuery("SELECT go FROM User u, DomainEntity e, GeneratedOffer go "
                            + "WHERE e.username = :username AND u.entity = e.id "
                            + "AND go.token = :token AND go.user = u.id")
                    .setParameter("token", token).setParameter("username", email).getSingleResult();
            return result;
        } catch (NoResultException e) {
            throw new OfferNotFoundException();
        }
    }

    /**
     * recupera la lista di offerte di volo con lo stesso email passato come
     * parametro
     * 
     * @param email
     * @return
     */
    public List<GeneratedOffer> getOffersByEmail(String email) {
        @SuppressWarnings("unchecked")
        List<GeneratedOffer> offers = (List<GeneratedOffer>) entityManager
                .createQuery("SELECT go FROM User u, DomainEntity e, GeneratedOffer go "
                        + "WHERE e.username = :username AND u.entity = e.id " + "AND go.user = u.id ")
                .setParameter("username", email).getResultList();
        return offers;
    }

    /**
     * recupera l'offerta di volo con il token passato come parametro
     * 
     * @param token
     * @return
     * @throws OfferNotFoundException
     */
    public GeneratedOffer getOfferByToken(String token) throws OfferNotFoundException {
        try {
            GeneratedOffer result = (GeneratedOffer) entityManager
                    .createQuery("SELECT go FROM GeneratedOffer go " + "WHERE go.token = :token ")
                    .setParameter("token", token).getSingleResult();
            return result;
        } catch (NoResultException e) {
            throw new OfferNotFoundException();
        }
    }

    /**
     * recupera la lista di offerte di volo disponibili all'acquisto e non prenotate
     * al momento dell'invocazione della funzione
     * 
     * @return
     */
    public List<GeneratedOffer> getAvailableOffers() {
        @SuppressWarnings("unchecked")
        List<GeneratedOffer> offers = (List<GeneratedOffer>) entityManager
                .createQuery("SELECT o FROM GeneratedOffer o WHERE o.booked = FALSE AND o.available = TRUE")
                .getResultList();
        return offers;
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

    public class InterestNotFoundException extends Exception {
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
