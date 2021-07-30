package it.unibo.soseng.gateway.airline;

import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_CONFIRM_BUY_OFFER;

import java.io.IOException;

import java.net.URI;

import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;

import java.util.List;

import javax.inject.Inject;
import javax.websocket.server.PathParam;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;


import com.fasterxml.jackson.databind.ObjectMapper;


import java.util.logging.Logger;

import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.gateway.airline.dto.InterestDTO;
import it.unibo.soseng.logic.airline.AirlineManager;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.model.GeneratedOffer;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;


@javax.ws.rs.Path("airline")
public class AirlineClient {

    @Inject
    ProcessState processState;

    @Inject
    DatabaseManager dbManager;

    @Inject
    AirlineManager airManager;

    @POST // TODO togliere
    @Consumes( MediaType.APPLICATION_JSON ) // TODO togliere
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


    @GET // TODO togliere
    @Path("/getTickets/{username}") // TODO togliere
    public byte[] getFlightTickets(String wsAddress, String username, String outboundFlightCode, String flightBackCode) throws IOException{

        String url = new String(wsAddress + "/getTickets?id="+ outboundFlightCode +"&id=" + flightBackCode);


        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder().url(url)
                            .addHeader("Content-Type", "application/pdf")
                            .build();
        Response response = client.newCall(request).execute();

        byte[] ticket = response.body().bytes();

        processState.setState(PROCESS_CONFIRM_BUY_OFFER, username, "PDF", ticket);


        return ticket;

    }

    @POST // TODO togliere
    @Path("/unbook") // TODO togliere
    public void unbookFlights() throws IOException{

        GeneratedOffer offer = dbManager.retrieveGeneratedOffer();
        airManager.unbookOffer(offer);

        String url = new String(offer.getOutboundFlightId().getAirlineId().getWsAddress() + "/notPurchasedOffer?id="+ 
                                    offer.getOutboundFlightId().getFlightCode() +"&id=" + offer.getFlightBackId().getFlightCode());

        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder().url(url)
                            .addHeader("Content-Type", "*/*")
                            .build();

        client.newCall(request).execute();

        processState.getStateAndRemove(PROCESS_CONFIRM_BUY_OFFER, offer.getUser().getProntogramUsername(), "PDF");

    }

}