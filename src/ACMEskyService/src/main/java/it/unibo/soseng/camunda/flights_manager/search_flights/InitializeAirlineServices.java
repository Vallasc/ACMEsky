package it.unibo.soseng.camunda.flights_manager.search_flights;

import static it.unibo.soseng.camunda.utils.ProcessVariables.AIRLINE_SERVICES;
import static it.unibo.soseng.camunda.utils.ProcessVariables.AIRLINE_SERVICES_INDEX;

import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.DatabaseManager;
import it.unibo.soseng.model.Airline;

/**
 * JavaDelegate associato al task "Initialize Airline Services" del diagramma
 * BPMN search_flights.bpmn che si occupa di recupera la lista delle compagnie
 * di volo registrate su questo servizio per effettuare, in seguito, la ricerca
 * dei voli richiesti
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

@Named("initializeAirlineServiceDelegate")
public class InitializeAirlineServices implements JavaDelegate {

    @Inject
    private DatabaseManager dbManager;

    private final static Logger LOGGER = Logger.getLogger(InitializeAirlineServices.class.getName());

    /**
     * Il metodo si occupa di recuperare la lista delle compagnie aeree da
     * interrogare e la assegna all'opportuna variabile di Camunda insieme a quella
     * dell'indice inizializzata a 0 per poter consultare dalla prima
     * AirlineServices in poi
     */
    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("Execute retrieveFlightsOfInterestDelegate");
        List<Airline> airlines = dbManager.getAirlinesList();
        execution.setVariable(AIRLINE_SERVICES_INDEX, 0);
        execution.setVariable(AIRLINE_SERVICES, airlines);
    }

}
