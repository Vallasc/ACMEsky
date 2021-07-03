package it.unibo.soseng.gateway.airline;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;


import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.logging.Logger;

import it.unibo.soseng.gateway.airline.dto.InterestDTO;
import it.unibo.soseng.logic.airline.AirlineManager;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.model.FlightInterest;


@Path("airline")
public class AirlineAPI {

    @Inject
    private DatabaseManager dbManager;

    @Inject
    private AirlineManager airlineManager;

    @POST
    @Consumes( MediaType.APPLICATION_JSON )
    public String getFlightList(List<InterestDTO> listDTO, String wsAddress)  throws IOException, InterruptedException{

        ObjectMapper objectMapper = new ObjectMapper();

        String requestBody = objectMapper
                .writeValueAsString(listDTO);

        // create a client
        HttpClient httpClient = HttpClient.newBuilder()
            .version(HttpClient.Version.HTTP_1_1)
            .build();

        // create a request
        HttpRequest request = HttpRequest.newBuilder(
            URI.create(wsAddress+"/getFlights"))
            .header("Content-Type", "application/json")
            .POST(HttpRequest.BodyPublishers.ofString(requestBody))
            .build();
        
        
        HttpResponse<String> response = httpClient.send(request, BodyHandlers.ofString());
        final Logger LOGGER = Logger.getLogger("getFlightList"); 
        LOGGER.info(response.body());
        
        return response.body();

    }


    

}