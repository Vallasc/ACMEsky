package it.unibo.soseng.gateway.bank;

import java.io.IOException;
import java.util.logging.Logger;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import it.unibo.soseng.gateway.bank.dto.AuthRequestDTO;
import it.unibo.soseng.gateway.bank.dto.AuthResponseDTO;
import it.unibo.soseng.gateway.bank.dto.PaymentLinkDTO;
import it.unibo.soseng.gateway.bank.dto.PaymentLinkRequestDTO;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

/**
 * Questa classe definisce le richieste che ACMEsky invia ai BankService per
 * raggiungere i propri obiettivi
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
public class BankClient {
    private final static Logger LOGGER = Logger.getLogger(BankClient.class.getName());

    final MediaType JSON = MediaType.get("application/json; charset=utf-8");

    /**
     * consente di effettuare richieste di autenticazione alla banca
     * 
     * @param wsAddress
     * @param authRequest
     * @return
     * @throws IOException
     * @throws InterruptedException
     * @throws BankAuthRequestException
     * @throws JsonProcessingException
     * @throws JsonMappingException
     */
    public String auth(String wsAddress, AuthRequestDTO authRequest) throws IOException, InterruptedException,
            BankAuthRequestException, JsonProcessingException, JsonMappingException {
        String url = wsAddress + "/auth";

        ObjectMapper objectMapper = new ObjectMapper();

        String jsonRequest = objectMapper.writeValueAsString(authRequest);
        RequestBody body = RequestBody.create(jsonRequest, JSON);

        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder().url(url).addHeader("Content-Type", "application/json").post(body)
                .build();

        String jsonResponse;
        try (Response response = client.newCall(request).execute()) {
            jsonResponse = response.body().string();
            if (response.code() != 200)
                throw new BankAuthRequestException();
        }
        AuthResponseDTO response = objectMapper.readValue(jsonResponse, AuthResponseDTO.class);
        return response.getJwtToken();
    }

    /**
     * consente di richiedere il link di pagamento con opportuno oggetto DTO
     * descritto in precedenza
     * 
     * @param wsAddress
     * @param token
     * @param linkRequest
     * @return
     * @throws IOException
     * @throws InterruptedException
     * @throws RequestPaymentLinkException
     * @throws JsonProcessingException
     * @throws JsonMappingException
     */
    public PaymentLinkDTO requestPaymentLink(String wsAddress, String token, PaymentLinkRequestDTO linkRequest)
            throws IOException, InterruptedException, RequestPaymentLinkException, JsonProcessingException,
            JsonMappingException {
        String url = wsAddress + "/payments";

        ObjectMapper objectMapper = new ObjectMapper();
        String jsonRequest = objectMapper.writeValueAsString(linkRequest);
        RequestBody body = RequestBody.create(jsonRequest, JSON);

        OkHttpClient client = new OkHttpClient();
        okhttp3.Request request = new okhttp3.Request.Builder().url(url).addHeader("Content-Type", "application/json")
                .addHeader("Authorization", "Bearer " + token).post(body).build();

        String jsonResponse;
        try (Response response = client.newCall(request).execute()) {
            jsonResponse = response.body().string();
            if (response.code() != 200 && response.code() != 201)
                throw new RequestPaymentLinkException();
        }
        PaymentLinkDTO response = objectMapper.readValue(jsonResponse, PaymentLinkDTO.class);
        return response;
    }

    public class BankAuthRequestException extends Exception {
    }

    public class RequestPaymentLinkException extends Exception {
    }
}
