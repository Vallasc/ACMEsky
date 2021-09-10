package it.unibo.soseng.camunda.user_manager.book_payment;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;
import javax.ws.rs.core.Response;

import org.camunda.bpm.engine.delegate.BpmnError;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.gateway.bank.BankClient.BankAuthRequestException;
import it.unibo.soseng.gateway.bank.BankClient.RequestPaymentLinkException;
import it.unibo.soseng.gateway.bank.dto.PaymentLinkRequestDTO;
import it.unibo.soseng.gateway.user.dto.PaymentLinkResponseDTO;
import it.unibo.soseng.logic.BankManager;
import it.unibo.soseng.logic.DatabaseManager;
import it.unibo.soseng.logic.DatabaseManager.BankNotFoundException;
import it.unibo.soseng.model.Bank;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.utils.ErrorsEvents.RESPONSE_PAYMENT_LINK_ERROR;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PAYMENT_LINK;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_CONFIRM_BUY_OFFER;
import static it.unibo.soseng.camunda.utils.ProcessVariables.RESPONSE;

@Named("askPaymentLinkDelegate")
public class AskPaymentLinkDelegate implements JavaDelegate {

    private final static Logger LOGGER = Logger.getLogger(AskPaymentLinkDelegate.class.getName());
    private final static String BANK = "bank";

    @Inject
    DatabaseManager databaseManager;

    @Inject
    ProcessState processState;

    @Inject
    BankManager bankManager;

    @Override
    public void execute(DelegateExecution execution) {
        LOGGER.info("Execute AskPaymentLinkDelegate");

        GeneratedOffer offer = (GeneratedOffer) execution.getVariable(USER_OFFER);
        PaymentLinkRequestDTO linkRequest = bankManager.makePaymentLinkRequest(offer);

        Bank bank;
        try {
            bank = databaseManager.getBank(BANK);
        } catch (BankNotFoundException e) {
            LOGGER.severe(e.toString());
            Response response = Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
            processState.setState(PROCESS_CONFIRM_BUY_OFFER, offer.getUser().getEmail(), RESPONSE, response);
            throw new BpmnError(RESPONSE_PAYMENT_LINK_ERROR);
        }

        String link;
        try {
            link = bankManager.requestPaymentLink(bank, linkRequest);
        } catch (BankAuthRequestException | RequestPaymentLinkException e) {
            LOGGER.severe(e.toString());
            Response response = Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
            processState.setState(PROCESS_CONFIRM_BUY_OFFER, offer.getUser().getEmail(), RESPONSE, response);
            throw new BpmnError(RESPONSE_PAYMENT_LINK_ERROR);
        }
        execution.setVariable(PAYMENT_LINK, link);
        
        PaymentLinkResponseDTO linkResponse = new PaymentLinkResponseDTO();
        linkResponse.setPaymentLink(link);
        linkResponse.setOfferCode(offer.getToken());
        
        Response response = Response.status(Response.Status.OK.getStatusCode())
                                    .entity(linkResponse)
                                    .build();
        processState.setState(PROCESS_CONFIRM_BUY_OFFER, offer.getUser().getEmail(), RESPONSE, response);
    }
    
}
