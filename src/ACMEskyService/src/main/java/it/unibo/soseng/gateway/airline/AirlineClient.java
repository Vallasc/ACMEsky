package it.unibo.soseng.gateway.airline;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;

import com.fasterxml.jackson.databind.ObjectMapper;

import it.unibo.soseng.gateway.airline.dto.InterestDTO;
import it.unibo.soseng.logic.AirlineManager;
import it.unibo.soseng.logic.DatabaseManager;
import it.unibo.soseng.model.GeneratedOffer;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

/**
 * Questa classe definisce le richieste che ACMEsky invia alle compagnie aeree
 * per raggiungere i propri obiettivi
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
public class AirlineClient {

    private final static Logger LOGGER = Logger.getLogger(AirlineClient.class.getName());

    final MediaType JSON = MediaType.get("application/json; charset=utf-8");

    @Inject
    DatabaseManager dbManager;

    @Inject
    AirlineManager airManager;

    /**
     * Invia i voli di interesse alla compagnia aerea, raggiungibile tramite
     * l'indirizzo, per recuperare i voli che combaciano con essi
     * 
     * @param listDTO
     * @param wsAddress
     * @return
     * @throws IOException
     * @throws InterruptedException
     * @throws AirlineErrorException
     */
    public String getFlightList(List<InterestDTO> listDTO, String wsAddress)
            throws IOException, InterruptedException, AirlineErrorException {

        String url = new String(wsAddress + "/getFlights");

        ObjectMapper objectMapper = new ObjectMapper();
        OkHttpClient client = new OkHttpClient();

        String requestBody = objectMapper.writeValueAsString(listDTO);
        RequestBody body = RequestBody.Companion.create(requestBody, JSON);
        Request request = new Request.Builder().url(url).addHeader("Content-Type", "application/json").post(body)
                .build();
        String res;
        // IMPORTANTE: Non utilizzare il metodo string() piu di una volta
        try (Response response = client.newCall(request).execute()) {

            if (response.code() != 200)
                throw new AirlineErrorException();
            res = response.body().string();
            LOGGER.info("Airline response: " + res);

        }

        return res;

    }

    /**
     * Recupera i biglietti dei voli richiesti ed effettua la prenotazione degli
     * stessi effettuando una chiamata ad una risorsa degli AirlineService.
     * 
     * @param wsAddress
     * @param username
     * @param outboundFlightCode
     * @param flightBackCode
     * @return
     * @throws IOException
     * @throws BookTicketsExceptionException
     */
    public byte[] getFlightTickets(String wsAddress, String username, String outboundFlightCode, String flightBackCode)
            throws IOException, BookTicketsException {

        String url = new String(wsAddress + "/getTickets?id=" + outboundFlightCode + "&id=" + flightBackCode);

        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder().url(url).addHeader("Content-Type", "application/pdf").build();
        byte[] ticket;
        try (Response response = client.newCall(request).execute()) {
            ticket = response.body().bytes();
            if (response.code() != 200 && response.code() != 201)
                throw new BookTicketsException();
        }
        return ticket;
    }

    /**
     * Cancella la prenotazione dei voli dell'offerta passata come argomento tramite
     * una richiesta HTTP ad una risorsa delle compagnie aeree destinata per questo
     * scopo
     * 
     * @param offer
     * @throws IOException
     */
    public void unbookFlights(GeneratedOffer offer) throws IOException {

        String url = new String(offer.getOutboundFlight().getAirlineId().getWsAddress() + "/notPurchasedOffer?id="
                + offer.getOutboundFlight().getFlightCode() + "&id=" + offer.getFlightBack().getFlightCode());

        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder().url(url).addHeader("Content-Type", "*/*").build();
        try (Response response = client.newCall(request).execute()) {
        }
    }

    public class AirlineErrorException extends Exception {
    }

    public class BookTicketsException extends Exception {
    }
}