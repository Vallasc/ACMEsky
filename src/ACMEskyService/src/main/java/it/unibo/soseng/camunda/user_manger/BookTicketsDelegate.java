package it.unibo.soseng.camunda.user_manger;

import java.io.IOException;
import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;
import javax.ws.rs.core.Response;

import org.camunda.bpm.engine.delegate.BpmnError;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.logic.airline.AirlineManager;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.offer.OfferManager.SendTicketException;
import it.unibo.soseng.logic.user.UserManager;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.ProcessVariables.USER_OFFER;
import static it.unibo.soseng.camunda.ProcessVariables.PROCESS_BUY_OFFER;
import static it.unibo.soseng.camunda.ProcessVariables.USERNAME;
import static it.unibo.soseng.camunda.ProcessVariables.RESPONSE;


import static it.unibo.soseng.camunda.ErrorsEvents.SEND_TICKET_ERROR;

import it.unibo.soseng.camunda.ProcessState;
import it.unibo.soseng.camunda.SendTicketError;


@Named("bookTicketsDelegate")
public class BookTicketsDelegate implements JavaDelegate{
    private final static Logger LOGGER = Logger.getLogger(BookTicketsDelegate.class.getName());

    @Inject
    DatabaseManager dbManager;

    @Inject
    AirlineManager airManager;

    @Inject
    ProcessState processState;

    @Inject 
    UserManager userManager;

    @Override
    public void execute(DelegateExecution execution){
        LOGGER.info("BookTickets working");
        try{
            GeneratedOffer offer = (GeneratedOffer) execution.getVariable(USER_OFFER);
            airManager.getOfferTicket(offer);
            dbManager.setBookFlights(true, offer.getOutboundFlightId(), offer.getFlightBackId());
        }catch(SendTicketException e){
            LOGGER.severe(e.toString());
            throw new BpmnError(SEND_TICKET_ERROR);
        }catch(IOException e){
            throw new BpmnError(SEND_TICKET_ERROR);
        }
    }
}
