package it.soseng.unibo.airlineService.auth;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.Collections;
import java.util.logging.Logger;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import it.soseng.unibo.airlineService.DTO.AuthRequest;
import it.soseng.unibo.airlineService.DTO.UserRequest;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class Auth {

    private final static Logger LOGGER = Logger.getLogger(Auth.class.getName());

    final MediaType JSON = MediaType.get("application/json; charset=utf-8");

    public String AuthRequest(String ACMEskyRoute, String username, String password) throws IOException {

        String url = ACMEskyRoute + "auth";

        ObjectMapper objectMapper = new ObjectMapper();
        OkHttpClient client = new OkHttpClient();

        AuthRequest req = new AuthRequest();
        req.setUsername(username);
        req.setPassword(password);

        String requestBody = objectMapper.writeValueAsString(req);

        RequestBody body = RequestBody.create(requestBody, JSON);
        Request request = new Request.Builder().url(url).addHeader("Content-Type", "application/json").post(body)
                .build();
        try (Response response = client.newCall(request).execute()) {
            if (response.code() != 200) {
                LOGGER.severe(String.valueOf(response.code()));
            } else {
                JsonNode token = objectMapper.readTree(response.body().string());
                return token.get("token").textValue();
            }
            return null;
        }

    }
}
