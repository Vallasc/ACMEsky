package it.unibo.soseng.gateway.prontogram;

import javax.ws.rs.Path;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.io.IOException;
import java.net.URI;
import java.net.http.HttpRequest;
import it.unibo.soseng.gateway.prontogram.dto.Notification;

@Path("airline")
public class ProntogramClient {

    public void sendNotificationOffer(Notification notification) throws IOException, InterruptedException, java.io.IOException{

        ObjectMapper objectMapper = new ObjectMapper();
        
        String requestBody = objectMapper
                //.writerWithDefaultPrettyPrinter()
                .writeValueAsString(notification);
        
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("localhost:8000/api/notification/new"))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                .build();

        //HttpResponse<String> response = HttpClient.newHttpClient().send(request, BodyHandlers.ofString());

        //return objectMapper.createArrayNode().add(response.body());
    }

}