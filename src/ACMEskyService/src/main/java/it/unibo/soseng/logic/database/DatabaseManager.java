package it.unibo.soseng.logic.database;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.logging.Logger;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.camunda.bpm.engine.delegate.DelegateExecution;

import it.unibo.soseng.model.FlightInterest;


public class DatabaseManager {
    
    /*private final static Logger LOGGER = Logger.getLogger(DatabaseManager.class.getName());

    

    public static EntityManagerFactory emf = Persistence.createEntityManagerFactory("java:jboss/datasources/postgresacmesky");

    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public List<FlightInterest> retrieveFlightInterests(){

        EntityManager em = getEntityManager();
        List<FlightInterest> interests = 
                                em.createQuery("SELECT flight.departure_airport_id, flight.departure arrival_airport_id,"+
                                                            "flight.departure_date_time, flight.arrival_date_time " +
                                                            "FROM flights_interest flight")
                                            .getResultList();
            return interests;
    }*/
}
