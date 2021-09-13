package it.unibo.soseng.gateway.prontogram;

import java.io.IOException;
import java.util.logging.Logger;

import com.fasterxml.jackson.databind.ObjectMapper;

import it.unibo.soseng.gateway.prontogram.dto.NotificationDTO;
import okhttp3.HttpUrl;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

/**
 * Questa classe elenca le richieste che il servizio effettua verso il servizio
 * di Prontogram che comunica direttamente con l'utente.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

public class ProntogramClient {
    private final static Logger LOGGER = Logger.getLogger(ProntogramClient.class.getName());
    public static final MediaType JSON = MediaType.get("application/json; charset=utf-8");

    private final String BASE_URL = System.getenv("PRONTOGRAM_PATH");
    private OkHttpClient client = new OkHttpClient();

    /**
     * consente di inviare notifiche a Prontogram che a sua volta le invierà
     * all'utente che aveva richiesto una data offerta di volo
     * 
     * @param notification
     * @throws IOException
     * @throws ProntogramServiceErrorException
     */
    public void sendNotificationOffer(NotificationDTO notification)
            throws IOException, ProntogramServiceErrorException {

        String url = HttpUrl.parse(BASE_URL + "/api/notification").newBuilder().build().toString();

        ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writeValueAsString(notification);
        RequestBody body = RequestBody.create(json, JSON);
        Request request = new Request.Builder().url(url).post(body).build();

        try (Response response = client.newCall(request).execute()) {
            // LOGGER.severe(response.body().string());
            if (response.code() != 200)
                throw new ProntogramServiceErrorException();
        }
    }

    public class ProntogramServiceErrorException extends Exception {
    }
}