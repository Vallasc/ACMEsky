package it.unibo.soseng.camunda.user_manager.book_payment;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;
import javax.ws.rs.core.Response;

import org.camunda.bpm.engine.delegate.BpmnError;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.gateway.airline.AirlineClient.BookTicketsException;
import it.unibo.soseng.logic.AirlineManager;
import it.unibo.soseng.logic.AirlineManager.SendTicketException;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.utils.ErrorsEvents.SEND_TICKET_ERROR;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_CONFIRM_BUY_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.RESPONSE;

/**
 * JavaDelegate associato al task "Book tickets" del diagramma BPMN
 * confirm_offer.bpmn. Questo task una volta eseguito si occupa di prenotare e
 * ottenere i pdf dei voli dell'offerta che l'utente intende acquistare.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

@Named("bookTicketsDelegate")
public class BookTicketsDelegate implements JavaDelegate {
    private final static Logger LOGGER = Logger.getLogger(BookTicketsDelegate.class.getName());

    @Inject
    private ProcessState processState;

    @Inject
    private AirlineManager airlineManager;

    /**
     * Acquisisce i biglietti in formato pdf dei voli dell'offerta che l'utente
     * vuole acquistare se non ci sono eventuali errori, altrimenti la procedura
     * d'acquisto termina con un errore.
     */
    @Override
    public void execute(DelegateExecution execution) {
        LOGGER.info("Execute BookTickets");
        GeneratedOffer offer = (GeneratedOffer) execution.getVariable(USER_OFFER);
        try {
            byte[] file = airlineManager.bookOfferTicket(offer);
            execution.setVariable(USER_OFFER, offer);
            String path = offer.getToken() + "_tmp1.pdf";
            try (FileOutputStream stream = new FileOutputStream(path)) {
                stream.write(file);
            }
        } catch (BookTicketsException | SendTicketException | IOException e) {
            Response response = Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
            processState.setState(PROCESS_CONFIRM_BUY_OFFER, offer.getUser().getEmail(), RESPONSE, response);
            LOGGER.severe(e.toString());
            throw new BpmnError(SEND_TICKET_ERROR);
        }
    }
}
