package com.ACMEbank.BankService.service;

import java.io.IOException;
import java.util.*;

import com.ACMEbank.BankService.dto.AcmeskyAuthRequestDTO;
import com.ACMEbank.BankService.dto.AcmeskyAuthResponseDTO;
import com.ACMEbank.BankService.dto.PaymentLinkRequestDTO;
import com.ACMEbank.BankService.model.WaitingPayment;
import com.ACMEbank.BankService.repository.WaitingPaymentRepository;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

/**
 * Servizio che gestisce i link di pagamento
 * Giacomo Vallorani 
 * giacomo.vallorani4@studio.unibo.it
 */
@Service
public class PaymentService {
    final MediaType JSON = MediaType.get("application/json; charset=utf-8");

    @Autowired
    private WaitingPaymentRepository waitingPaymentRepository;

    @Autowired
    private Environment env;

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
     * @throws IOException
     */
    public void sendPaymentNotification(String url, String paymentToken) throws IOException {
        if(url == null) return;

        String token;
        try {
            token = acmeskyAuth();
        } catch (AuthRequestException | IOException e) {
            System.out.println("Auth error:" + e.toString());
            throw new IOException();
        }
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                                    .url(url)
                                    .addHeader("Content-Type", "application/json")
                                    .addHeader("Authorization", "Bearer " + token)
                                    .build();

        try (Response response = client.newCall(request).execute()) {
            System.out.println("Request " + url + " " + response.code());
        }
    }

    public String acmeskyAuth() throws AuthRequestException, IOException{
        AcmeskyAuthRequestDTO authRequest = new AcmeskyAuthRequestDTO();
        authRequest.username = "bank";
        authRequest.password = "bank";

        String wsAddress = env.getProperty("server.acmesky.hostname");
        String url = wsAddress+"/auth";

        ObjectMapper objectMapper = new ObjectMapper();

        String jsonRequest = objectMapper.writeValueAsString(authRequest);
        RequestBody body = RequestBody.create(jsonRequest, JSON);

        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                                    .url(url)
                                    .addHeader("Content-Type", "application/json")
                                    .post(body)
                                    .build();

        String jsonResponse;
        try (Response response = client.newCall(request).execute()) {
            jsonResponse = response.body().string();
            if(response.code() != 200)
                throw new AuthRequestException();
        }
        AcmeskyAuthResponseDTO response = objectMapper.readValue(jsonResponse, AcmeskyAuthResponseDTO.class);
        return response.token;	
    }

    public class AuthRequestException extends Exception {}
}