package it.unibo.soseng.logic.database;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.enterprise.context.RequestScoped;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.User;

@RequestScoped
@TransactionManagement(value = TransactionManagementType.CONTAINER)
public class DatabaseManager {
    
    private final static Logger LOGGER = Logger.getLogger(DatabaseManager.class.getName());

    
    @PersistenceContext(unitName = "primary")
    private EntityManager entityManager;


    public List<FlightInterest> retrieveFlightInterests(){
        @SuppressWarnings("unchecked")
        List<FlightInterest> interests = 
        entityManager.createQuery("SELECT flight.departure_airport_id, flight.departure arrival_airport_id,"+
                                                            "flight.departure_date_time, flight.arrival_date_time " +
                                                            "FROM flights_interest flight")
                                            .getResultList();
        return interests;
    }


    public User getUser(String username) throws UserNotFoundException{
        @SuppressWarnings("unchecked")
        List<User> result = (List<User>) entityManager.createQuery(
                            "SELECT u FROM User u, DomainEntity e WHERE e.username = :username AND u.entity = e.id")
                            .setParameter("username", username)
                            .setMaxResults(10)
                            .getResultList();
        if( result.size() == 1 ){
            return result.get(0);
        }
        throw new UserNotFoundException();
    }

    public void createUser(User user){
        //find
        this.entityManager.persist(user);
    }

    public class UserNotFoundException extends Exception{
        private static final long serialVersionUID = 1L;
    }
}
