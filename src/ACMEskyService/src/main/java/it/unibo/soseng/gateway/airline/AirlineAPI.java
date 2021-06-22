package it.unibo.soseng.gateway.airline;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandler;
import java.net.http.HttpResponse.BodyHandlers;
import java.net.http.HttpResponse.BodySubscribers;
import java.util.List;
import java.util.logging.Logger;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;

import it.unibo.soseng.gateway.airline.dto.InterestDTO;
import it.unibo.soseng.model.Flight;

public class AirlineAPI {

    
    public ArrayNode getFlightList(List<InterestDTO> list) throws IOException, InterruptedException{

        ObjectMapper objectMapper = new ObjectMapper();
        
        String requestBody = objectMapper
                .writerWithDefaultPrettyPrinter()
                .writeValueAsString(list);
        
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("http://192.168.1.5:8082/searchFlights"))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                .build();

        HttpResponse<String> response = HttpClient.newHttpClient().send(request, BodyHandlers.ofString());

        return objectMapper.createArrayNode().add(response.body());
    }
}