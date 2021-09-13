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

/**
 * Descrive le richieste che ACMEsky effettua verso il servizio di
 * geolocalizzazione per conoscere le distanze tra gli indirizzi degli utenti e
 * quelli degli aereoporti.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Stateless
public class DistanceClient {
    private final static Logger LOGGER = Logger.getLogger(DistanceClient.class.getName());

    final String BASE_URL = System.getenv("GEOSERVICE_PATH");

    OkHttpClient client = new OkHttpClient();

    /**
     * consente di richiedere la distanza tra due indirizzi
     * 
     * @param from
     * @param to
     * @return
     * @throws IOException
     * @throws GeoserverErrorException
     */
    public DistanceDTO requestDistance(String from, String to) throws IOException, GeoserverErrorException {

        String url = HttpUrl.parse(BASE_URL + "/distance").newBuilder().addQueryParameter("from", from)
                .addQueryParameter("to", to).build().toString();

        Request request = new Request.Builder().url(url).build();

        Call call = client.newCall(request);

        ObjectMapper objectMapper = new ObjectMapper();

        String jsonResponse;
        try (Response response = client.newCall(request).execute()) {
            jsonResponse = response.body().string();
            if (response.code() != 200)
                throw new GeoserverErrorException();
        }
        return objectMapper.readValue(jsonResponse, DistanceDTO.class);
    }

    public class GeoserverErrorException extends Exception {
    }
}
