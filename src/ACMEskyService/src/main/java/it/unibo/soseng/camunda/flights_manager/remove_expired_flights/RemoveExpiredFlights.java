package it.unibo.soseng.camunda.flights_manager.remove_expired_flights;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.AirlineManager;

/**
 * JavaDelegate associato al task del diagramma BPMN
 * remove_expired_flights.bpmn, la cui esecuzione porta alla rimozione delle
 * offerte scadute, ovvero al cambiamento dello stato di disponibilità
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

@Named("removeExpiredFlightsDelegate")
public class RemoveExpiredFlights implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(RemoveExpiredFlights.class.getName());

    @Inject
    AirlineManager airlineManager;

    /**
     * Modifica lo stato di tutti i voli scaduti fino ad ora modificandone lo stato
     * da disponibile a non disponibile
     */
    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("RemoveFlights is working");
        airlineManager.removeExpiredFlights();
    }

}
