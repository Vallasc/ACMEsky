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

@Service
public class PaymentService {

    @Autowired
    private WaitingPaymentRepository waitingPaymentRepository;


    public String savePayment(PaymentLinkRequestDTO paymentDTO, String userId) {
        WaitingPayment payment = WaitingPayment.fromRequestPaymentDTO(paymentDTO);
        payment.setUserId(userId);
        WaitingPayment result = waitingPaymentRepository.saveAndFlush(payment);
        String uniqueToken = UUID.randomUUID().toString().substring(0, 8) + result.getId();
        result.setPaymentToken(uniqueToken);
        waitingPaymentRepository.saveAndFlush(result);
        return uniqueToken;
    }

    public void updatePayment(WaitingPayment payment) {
        waitingPaymentRepository.save(payment);
    }

    public List<WaitingPayment> getAllPayments(String userId) {
        return waitingPaymentRepository.getAllPayments(userId);
    }

    public WaitingPayment getPaymentByToken(String paymentToken) {
        return waitingPaymentRepository.getPaymentByToken(paymentToken);
    }

    /**
     * Create put request
     * 
     * @param url
     * @param paymentToken
     */
    public void sendPaymentNotification(String url, String paymentToken) {
        if(url == null) return;

        RestTemplate restTemplate = new RestTemplate();
        URI uri;
        try {
            uri = new URI(url);
            ResponseEntity<String> result = restTemplate.getForEntity(uri, String.class);
            //Check result.getStatusCodeValue()
            //System.out.println("Request "+url+" "+result.getStatusCode());
        } catch (URISyntaxException e) {
            // Bad Url
        }
            
    }
}