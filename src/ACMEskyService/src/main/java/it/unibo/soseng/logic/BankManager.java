package it.unibo.soseng.logic;

import java.io.IOException;
import java.util.logging.Logger;

import javax.inject.Inject;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;

import it.unibo.soseng.gateway.bank.BankClient;
import it.unibo.soseng.gateway.bank.BankClient.BankAuthRequestException;
import it.unibo.soseng.gateway.bank.BankClient.RequestPaymentLinkException;
import it.unibo.soseng.gateway.bank.dto.AuthRequestDTO;
import it.unibo.soseng.gateway.bank.dto.PaymentLinkDTO;
import it.unibo.soseng.gateway.bank.dto.PaymentLinkRequestDTO;
import it.unibo.soseng.logic.DatabaseManager.OfferNotFoundException;
import it.unibo.soseng.model.Airport;
import it.unibo.soseng.model.Bank;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.camunda.utils.Events.PAYMENT_SUCCESSFUL;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_CONFIRM_BUY_OFFER;


public class BankManager {
    private final static Logger LOGGER = Logger.getLogger(BankManager.class.getName());
    private final String ACMESKY_PATH = System.getenv("ACMESKY_PATH");

    @Inject
    private BankClient bankClient;

    @Inject
    private DatabaseManager databaseManager;

    public PaymentLinkRequestDTO makePaymentLinkRequest(GeneratedOffer offer){
        PaymentLinkRequestDTO linkRequest = new PaymentLinkRequestDTO();
        linkRequest.setAmount(offer.getTotalPrice());

        Airport departureAirport = offer.getOutboundFlight().getDepartureAirport();
        Airport arrivalAirport = offer.getOutboundFlight().getArrivalAirport();
        
        String description = "Codice offerta " + offer.getToken() + "<br>" +
                        "Tratta " + departureAirport.getCityName() + "(" + departureAirport.getAirportCode() + ") - " +
                        arrivalAirport.getCityName() + "(" + arrivalAirport.getAirportCode() + ")<br>" +
                        offer.getOutboundFlight().getDepartureDateTime().toString() + " - " +
                        offer.getFlightBack().getDepartureDateTime().toString();
        linkRequest.setDescription(description);
        String link = ACMESKY_PATH + "/banks/confirmPayment?code=" + offer.getToken();
        linkRequest.setNotificationUrl(link);
        return linkRequest;
    }

    public String requestPaymentLink(Bank bank, PaymentLinkRequestDTO request) 
                                                throws BankAuthRequestException, RequestPaymentLinkException {
        AuthRequestDTO authRequest = new AuthRequestDTO();
        authRequest.setUserId(bank.getLoginUsername());
        authRequest.setPassword(bank.getLoginPassword());
        String token;
        try {
            token = bankClient.auth(bank.getWsAddress(), authRequest);
        } catch (IOException | InterruptedException e) {
            LOGGER.severe(e.toString());
            throw bankClient.new BankAuthRequestException();
        }

        PaymentLinkDTO res;
        try {
            res = bankClient.requestPaymentLink(bank.getWsAddress(), token, request);
        } catch (IOException | InterruptedException e) {
            LOGGER.severe(e.toString());
            throw bankClient.new RequestPaymentLinkException();
        }
        return res.getPath();
    }

    public void paymentSuccess(String offerCode) {
        try{
            GeneratedOffer offer = databaseManager.getOfferByToken(offerCode);
            String email = offer.getUser().getEmail();
            final RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
             //runtimeService.getVariable(USER_OFFER) TODO controllare offerCode sia uguale all'offerta nel processo
             runtimeService.correlateMessage(PAYMENT_SUCCESSFUL, 
                                            PROCESS_CONFIRM_BUY_OFFER + email + offer.getToken());
        } catch (OfferNotFoundException e){
            LOGGER.severe(e.toString());
        }
    }

    public class ErrorReceivedPayLinkException extends Exception {
        private static final long serialVersionUID = 1L;
    }
}
