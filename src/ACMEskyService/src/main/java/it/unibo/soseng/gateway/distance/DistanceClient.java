package it.unibo.soseng.gateway.distance;

import java.io.IOException;
import java.util.logging.Logger;

import javax.ejb.Stateless;

import com.fasterxml.jackson.databind.ObjectMapper;
import it.unibo.soseng.gateway.distance.dto.DistanceDTO;
import okhttp3.Call;
import okhttp3.HttpUrl;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.ResponseBody;

@Stateless
public class DistanceClient {
    private final static Logger LOGGER = Logger.getLogger(DistanceClient.class.getName());

    final String BASE_URL = System.getenv("GEOSERVICE_PATH");

    OkHttpClient client = new OkHttpClient();

    public DistanceDTO requestDistance(String from, String to) throws IOException, GeoserverErrorException {

        String url = HttpUrl.parse(BASE_URL + "/distance")
                            .newBuilder()
                            .addQueryParameter("from", from)
                            .addQueryParameter("to", to)
                            .build()
                            .toString();

        Request request = new Request.Builder()
                                    .url(url)
                                    .build();

        Call call = client.newCall(request);
        
        Response response = call.execute();
        ObjectMapper objectMapper = new ObjectMapper(); 
        if(response.code() == 200) {
            try (ResponseBody body = response.body()) {
                return objectMapper.readValue(body.string(), DistanceDTO.class);
            }
        }
        throw new GeoserverErrorException();
    }

    public class GeoserverErrorException extends Exception {}
}
