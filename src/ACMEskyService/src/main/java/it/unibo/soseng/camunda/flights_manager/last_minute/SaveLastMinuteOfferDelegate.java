package it.unibo.soseng.camunda.flights_manager.last_minute;

import java.util.logging.Logger;
import static it.unibo.soseng.camunda.utils.ProcessVariables.AIRLINE_FLIGHT_OFFERS;
import static it.unibo.soseng.camunda.utils.ProcessVariables.AIRLINE_NAME;
import java.util.List;
import javax.inject.Inject;
import javax.inject.Named;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import it.unibo.soseng.gateway.airline.dto.AirlineFlightOfferDTO;
import it.unibo.soseng.logic.AirlineManager;

/**
 * JavaDelegate associato al task del diagramma BPMN SaveLastMinuteOffer.bpmn,
 * la cui esecuzione porta al salvataggio dell'offerta last-minute inviata dalla
 * compagnia aerea
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

@Named("saveLastMinuteOfferDelegate")
public class SaveLastMinuteOfferDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(SaveLastMinuteOfferDelegate.class.getName());

    @Inject
    AirlineManager airlineManager;

    /**
     * Il metodo termina la procedura di salvataggio della lista delle offerte
     * last-minute passate da AirlineService avviata dal controller di Airline,
     * impostando le variabili d'ambiente della lista di AirlineFlightOfferDTO e del
     * nome della compagnia aerea
     */
    @Override
    public void execute(DelegateExecution execution) {
        LOGGER.info("Execute RetrieveOffer");
        @SuppressWarnings(value = "unchecked")

        List<AirlineFlightOfferDTO> airlineOffers = (List<AirlineFlightOfferDTO>) execution
                .getVariable(AIRLINE_FLIGHT_OFFERS);
        String AirlineCompanyName = (String) execution.getVariable(AIRLINE_NAME);
        airlineManager.handleConfirmLastMinuteOffer(AirlineCompanyName, airlineOffers);
    }
}