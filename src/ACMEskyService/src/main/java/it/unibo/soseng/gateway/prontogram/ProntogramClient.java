package it.unibo.soseng.gateway.prontogram;

import javax.ws.rs.Path;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;

import it.unibo.soseng.gateway.prontogram.dto.NotificationDTO;
import okhttp3.OkHttpClient;


public class ProntogramClient {
    final String BASE_URL = System.getenv("PRONTOGRAM_PATH");

    OkHttpClient client = new OkHttpClient();

    // TODO CATTURARARE LE ECCEZIONI e usare okhttp
    public void sendNotificationOffer(NotificationDTO notification) throws IOException {

        String url = BASE_URL + "/api/notification/new";
        /*ObjectMapper objectMapper = new ObjectMapper();
        
        String requestBody = objectMapper
                .writeValueAsString(notification);
        
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("http://192.168.1.77:8000/api/notification/new"))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                .build();

        HttpResponse<String> response = HttpClient.newHttpClient().send(request, BodyHandlers.ofString());*/

        //return objectMapper.createArrayNode().add(response.body());
    }

}