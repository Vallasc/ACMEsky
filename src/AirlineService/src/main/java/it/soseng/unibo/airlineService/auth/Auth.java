package it.soseng.unibo.airlineService.auth;

import java.util.Collections;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import it.soseng.unibo.airlineService.DTO.AuthRequest;
import it.soseng.unibo.airlineService.DTO.UserRequest;

public class Auth {

    public String AuthRequest( String ACMEskyRoute, String username, String password) throws JsonProcessingException{
        String url = ACMEskyRoute + "/auth";
    
        // // create headers
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        AuthRequest req = new AuthRequest();
        req.setUser(username);
        req.setPass(password);
        ObjectMapper mapper = new ObjectMapper();

        String jsonCredentials = mapper.writeValueAsString(req);
        // // build the request
        HttpEntity<String> entity = new HttpEntity<String>(jsonCredentials, headers);
        // // send POST request
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> jwt = restTemplate.postForEntity(url, entity, String.class);
        return jwt.toString();   
    }
}
