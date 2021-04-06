package it.unibo.soseng.logic.database;

import java.util.Iterator;
import java.util.List;
import java.util.logging.Logger;

import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import it.unibo.soseng.model.Flight;
import it.unibo.soseng.model.FlightInterest;

@Stateless
@TransactionManagement(value = TransactionManagementType.CONTAINER)
public class DatabaseManager {
    
    private final static Logger LOGGER = Logger.getLogger(DatabaseManager.class.getName());

    
    @PersistenceContext(unitName = "primary")
    private EntityManager entityManager;


    public List<FlightInterest> retrieveFlightInterests(){
        @SuppressWarnings("unchecked")
        List<FlightInterest> interests = 
        entityManager.createQuery("SELECT flight FROM flights_interest flight")
                        .getResultList();
        return interests;
    }

    public void insertFlightOffer(List<Flight> list){

        Iterator<Flight> i = list.iterator();

        while(i.hasNext()){
            entityManager.persist(i.next());
        }

    }


}
