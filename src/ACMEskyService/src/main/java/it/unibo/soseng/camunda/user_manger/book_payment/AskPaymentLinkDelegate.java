package it.unibo.soseng.camunda.user_manger.book_payment;

import java.util.logging.Logger;

import javax.inject.Inject;
import javax.inject.Named;

import org.camunda.bpm.engine.delegate.BpmnError;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import it.unibo.soseng.gateway.bank.dto.AuthRequest;
import it.unibo.soseng.gateway.bank.dto.AuthResponse;
import it.unibo.soseng.gateway.bank.dto.PaymentLink;
import it.unibo.soseng.gateway.bank.dto.PaymentLinkRequest;
import it.unibo.soseng.logic.bank.BankManager;
import it.unibo.soseng.logic.bank.BankManager.ErrorReceivedPayLinkException;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.model.Bank;
import it.unibo.soseng.model.GeneratedOffer;
import it.unibo.soseng.utils.*;

import static it.unibo.soseng.camunda.utils.ErrorsEvents.RESPONSE_PAYMENT_LINK_ERROR;
import static it.unibo.soseng.camunda.utils.ProcessVariables.PAYMENT_LINK;
import static it.unibo.soseng.camunda.utils.ProcessVariables.USER_OFFER;


@Named("askPaymentLinkDelegate")
public class AskPaymentLinkDelegate implements JavaDelegate {

    @Inject
    DatabaseManager dbManager;

    @Inject
    BankManager bankManager;

    private final static Logger LOGGER = Logger.getLogger(AskPaymentLinkDelegate.class.getName());


    @Override
    public void execute(DelegateExecution execution) throws Exception {
        LOGGER.info("askPaymentLinkDelegate is working");
        Bank b = dbManager.getBank();
        AuthResponse resToken = bankManager.getToken(b.getWsAddress(), new AuthRequest(Env.ACME_USER, Env.ACME_PASS));
        GeneratedOffer offer = (GeneratedOffer) execution.getVariable(USER_OFFER);
        try{
            String url = "/user"+offer.getUser().getId()+"/"+offer.getId()+"/notificationPayment";
            PaymentLinkRequest req = new PaymentLinkRequest(offer.getTotalPrice(), "request payment for offer: "+offer.getId(), url);
            PaymentLink link = bankManager.getPaymentLink(b.getWsAddress(), resToken.getToken(), req);
            execution.setVariable(PAYMENT_LINK, link.getPath());
        }catch(ErrorReceivedPayLinkException e){
            throw new BpmnError(RESPONSE_PAYMENT_LINK_ERROR);

        }
        
    }
    
}
