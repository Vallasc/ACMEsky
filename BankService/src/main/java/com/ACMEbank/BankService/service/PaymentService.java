package com.ACMEbank.BankService.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.*;

import com.ACMEbank.BankService.dto.PaymentLinkRequestDTO;
import com.ACMEbank.BankService.model.WaitingPayment;
import com.ACMEbank.BankService.repository.WaitingPaymentRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

/**
 * Servizio che gestisce i link di pagamento
 * Giacomo Vallorani 
 * giacomo.vallorani4@studio.unibo.it
 */
@Service
public class PaymentService {

    @Autowired
    private WaitingPaymentRepository waitingPaymentRepository;

    /**
     * Salva il link nel DB
     * @param paymentDTO richiesta link
     * @param userId id utente
     */
    public String savePayment(PaymentLinkRequestDTO paymentDTO, String userId) {
        WaitingPayment payment = WaitingPayment.fromRequestPaymentDTO(paymentDTO);
        payment.setUserId(userId);
        WaitingPayment result = waitingPaymentRepository.saveAndFlush(payment);
        String uniqueToken = UUID.randomUUID().toString().substring(0, 8) + result.getId();
        result.setPaymentToken(uniqueToken);
        waitingPaymentRepository.saveAndFlush(result);
        return uniqueToken;
    }

    /**
     * Aggiorna il pagamento
     * @param payment 
     */
    public void updatePayment(WaitingPayment payment) {
        waitingPaymentRepository.save(payment);
    }

    /**
     * Restituisce tutti i link dell'utente
     * @param userId identificativo utente
     * @return lista dei pagamenti
     */
    public List<WaitingPayment> getAllPayments(String userId) {
        return waitingPaymentRepository.getAllPayments(userId);
    }

    /**
     * Restituisce il link in base al token
     * @param paymentToken token pagamento
     * @return pagamento
     */
    public WaitingPayment getPaymentByToken(String paymentToken) {
        return waitingPaymentRepository.getPaymentByToken(paymentToken);
    }

    /**
     * Invia la richiesta all'url inserito dall'utente in fase di creazione 
     * del pagamento
     * @param url url utente
     * @param paymentToken token del pagamento
     */
    public void sendPaymentNotification(String url, String paymentToken) {
        if(url == null) return;

        RestTemplate restTemplate = new RestTemplate();
        URI uri;
        try {
            uri = new URI(url);
            ResponseEntity<String> result = restTemplate.getForEntity(uri, String.class);
            //Check result.getStatusCodeValue()
            System.out.println("Request "+url+" "+result.getStatusCode());
        } catch (URISyntaxException e) {
            // Bad Url
        }
            
    }
}