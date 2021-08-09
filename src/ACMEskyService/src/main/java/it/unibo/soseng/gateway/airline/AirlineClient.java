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


import com.fasterxml.jackson.databind.ObjectMapper;


import java.util.logging.Logger;

import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.gateway.airline.dto.InterestDTO;
import it.unibo.soseng.logic.airline.AirlineManager;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.model.GeneratedOffer;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;


@javax.ws.rs.Path("airline")
public class AirlineClient {
    final MediaType JSON = MediaType.get("application/json; charset=utf-8");


    @Inject
    ProcessState processState;

    @Inject
    DatabaseManager dbManager;

    @Inject
    AirlineManager airManager;

    @POST // TODO togliere
    public String getFlightList(List<InterestDTO> listDTO, String wsAddress)  throws IOException, InterruptedException{

        String url = new String(wsAddress + "/getFlights");

        ObjectMapper objectMapper = new ObjectMapper();

        String requestBody = objectMapper.writeValueAsString(listDTO);
        RequestBody body = RequestBody.Companion.create(requestBody, JSON);

        OkHttpClient client = new OkHttpClient();


        Request request = new Request.Builder().url(url)
                            .addHeader("Content-Type", "application/json")
                            .build();
        Response response = client.newCall(request).execute();
        
        
        final Logger LOGGER = Logger.getLogger("getFlightList"); 
        LOGGER.info(response.body().string());
        
        return response.body().string();

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
    public void unbookFlights(GeneratedOffer offer) throws IOException{

        String url = new String( offer.getOutboundFlightId().getAirlineId().getWsAddress() + "/notPurchasedOffer?id="+ 
                                    offer.getOutboundFlightId().getFlightCode() +"&id=" + offer.getFlightBackId().getFlightCode());

        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder().url(url)
                            .addHeader("Content-Type", "*/*")
                            .build();

        client.newCall(request).execute();

        processState.getStateAndRemove(PROCESS_CONFIRM_BUY_OFFER, offer.getUser().getProntogramUsername(), "PDF");

    }

}