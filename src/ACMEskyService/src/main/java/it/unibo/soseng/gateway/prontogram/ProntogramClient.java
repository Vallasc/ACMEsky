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


public class ProntogramClient {
    private final static Logger LOGGER = Logger.getLogger(ProntogramClient.class.getName()); 
    public static final MediaType JSON = MediaType.get("application/json; charset=utf-8");

    private final String BASE_URL = System.getenv("PRONTOGRAM_PATH");
    private OkHttpClient client = new OkHttpClient();

    public void sendNotificationOffer(NotificationDTO notification) throws IOException, ProntogramServiceErrorException  {
        
        String url = HttpUrl.parse(BASE_URL + "/api/notification")
                            .newBuilder()
                            .build()
                            .toString();

        ObjectMapper objectMapper = new ObjectMapper(); 
        String json = objectMapper.writeValueAsString(notification);
        RequestBody body = RequestBody.create(json, JSON);
        Request request = new Request.Builder()
                                .url(url)
                                .post(body)
                                .build();

        try (Response response = client.newCall(request).execute()) {
            //LOGGER.severe(response.body().string());
            if(response.code() != 200)
                throw new ProntogramServiceErrorException();
        }
    }

    public class ProntogramServiceErrorException extends Exception {}
}