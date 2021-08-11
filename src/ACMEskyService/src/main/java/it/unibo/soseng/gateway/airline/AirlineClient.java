package it.unibo.soseng.gateway.airline;

import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_CONFIRM_BUY_OFFER;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;

import com.fasterxml.jackson.databind.ObjectMapper;

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

public class AirlineClient {

    private final static Logger LOGGER = Logger.getLogger(AirlineClient.class.getName()); 

    final MediaType JSON = MediaType.get("application/json; charset=utf-8");

    @Inject
    ProcessState processState;

    @Inject
    DatabaseManager dbManager;

    @Inject
    AirlineManager airManager;

    public String getFlightList(List<InterestDTO> listDTO, String wsAddress)  throws IOException, InterruptedException, AirlineErrorException{

        String url = new String(wsAddress + "/getFlights");

        ObjectMapper objectMapper = new ObjectMapper();
        OkHttpClient client = new OkHttpClient();

        String requestBody = objectMapper.writeValueAsString(listDTO);
        RequestBody body = RequestBody.Companion.create(requestBody, JSON);
        Request request = new Request.Builder().url(url)
                            .addHeader("Content-Type", "application/json")
                            .post(body)
                            .build();        
        String res;
        // IMPORTANTE: Non utilizzare il metodo string() piu di una volta
        try (Response response = client.newCall(request).execute()) {
            if(response.code() != 200)
                throw new AirlineErrorException();
            res = response.body().string();
        }
        LOGGER.info("Airline response: "+res);
        return res;

    }


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

    public class AirlineErrorException extends Exception {}

}