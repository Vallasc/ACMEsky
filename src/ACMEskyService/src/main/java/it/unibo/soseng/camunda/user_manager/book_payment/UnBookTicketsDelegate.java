package it.unibo.soseng.camunda.user_manager.book_payment;

import java.io.IOException;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.AirlineManager;
import it.unibo.soseng.logic.DatabaseManager;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER;

/**
 * JavaDelegate associato al task "Unbook tickets" del diagramma BPMN
 * confirm_offer.bpmn, la cui esecuzione cancella la prenotazione dell'offerta
 * di volo e dei relativi voli
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Named("unbookTicketsDelegate")
public class UnBookTicketsDelegate implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger(UnBookTicketsDelegate.class.getName());

    @Inject
    AirlineManager airlineManager;

    @Inject
    DatabaseManager dbManager;

    /**
     * Informa la compagnia aerea che vende quell'offerta di volo della
     * cancellazione della prenotazione e cambia lo stato di disponibilità
     * dell'offerta stessa e dei voli che la compongono. I voli tornano ad essere
     * disponibili per creare offerte.
     */
    @Override
    public void execute(DelegateExecution execution) throws IOException {
        LOGGER.info("UnbookTickets working");
        GeneratedOffer offer = (GeneratedOffer) execution.getVariable(USER_OFFER);
        airlineManager.unbookOffer(offer);

    }
}
