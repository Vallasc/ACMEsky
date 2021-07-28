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
import okhttp3.RequestBody;
import okhttp3.Response;
import okhttp3.ResponseBody;

public class BankClient {


    public String auth(String wsAddress, AuthRequest reqDTO) throws IOException, InterruptedException{

        String url = wsAddress+"/auth";

        ObjectMapper objectMapper = new ObjectMapper();

        String requestBody = objectMapper
                .writeValueAsString(reqDTO);

        HttpClient httpClient = HttpClient.newBuilder()
            .version(HttpClient.Version.HTTP_1_1)
            .build();   

        HttpRequest request = HttpRequest.newBuilder(
                                    URI.create(url))
                                    .header("Content-Type", "application/json")
                                    .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                                    .build();

        HttpResponse<String> response = httpClient.send(request, BodyHandlers.ofString());
        
        return response.body();

    }


    public ResponseBody paymentLink (String wsAddress, String token, PaymentLinkRequest linkReqDTO ) throws IOException, InterruptedException{

        String url = wsAddress+"/payments";

        ObjectMapper m = new ObjectMapper();
        String req = m.writeValueAsString(linkReqDTO);

        MediaType JSON = MediaType.parse("application/json; charset=utf-8");
        RequestBody body = RequestBody.create(JSON, req);

        OkHttpClient client = new OkHttpClient();
        okhttp3.Request request = new okhttp3.Request.Builder()
                                    .url(url)
                                    .addHeader("Content-Type", "application/pdf")
                                    .addHeader("Authorization: Bearer ", token)
                                    .post(body)
                                    .build();
        Response response = client.newCall(request).execute();
        
        return response.body();

        
    }
    
}
