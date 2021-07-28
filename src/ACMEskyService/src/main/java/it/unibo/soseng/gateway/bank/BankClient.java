package it.unibo.soseng.gateway.bank;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;


import com.fasterxml.jackson.databind.ObjectMapper;

import it.unibo.soseng.gateway.bank.dto.AuthRequest;
import it.unibo.soseng.gateway.bank.dto.PaymentLinkRequest;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okhttp3.ResponseBody;

public class BankClient {

    final MediaType JSON = MediaType.get("application/json; charset=utf-8");


    public String auth(String wsAddress, AuthRequest reqDTO) throws IOException, InterruptedException{

        String url = wsAddress+"/auth";

        ObjectMapper objectMapper = new ObjectMapper();

        String requestBody = objectMapper.writeValueAsString(reqDTO);
        RequestBody body = RequestBody.Companion.create(requestBody, JSON);

        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder().url(url)
                            .addHeader("Content-Type", "application/json")
                            .post(body)
                            .build();
        Response response = client.newCall(request).execute();   

        
        return response.body().string();

    }


    public String paymentLink (String wsAddress, String token, PaymentLinkRequest linkReqDTO ) throws IOException, InterruptedException{

        String url = wsAddress+"/payments";

        ObjectMapper m = new ObjectMapper();
        String req = m.writeValueAsString(linkReqDTO);

        RequestBody body = RequestBody.Companion.create(req, JSON);

        OkHttpClient client = new OkHttpClient();
        okhttp3.Request request = new okhttp3.Request.Builder()
                                    .url(url)
                                    .addHeader("Content-Type", "application/pdf")
                                    .addHeader("Authorization: Bearer ", token)
                                    .post(body)
                                    .build();

        Response response = client.newCall(request).execute();
        
        return response.body().string();

        
    }
    
}
