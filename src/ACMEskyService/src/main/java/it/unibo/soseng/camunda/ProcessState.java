package it.unibo.soseng.camunda;

import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.PostConstruct;
import javax.ejb.ConcurrencyManagement;
import javax.ejb.Lock;
import javax.ejb.LockType;
import javax.ejb.Singleton;
import javax.ws.rs.container.AsyncResponse;

import static javax.ejb.ConcurrencyManagementType.BEAN;

@Singleton 
@ConcurrencyManagement(BEAN)
public class ProcessState {
    private ConcurrentHashMap<String, AsyncResponseDTO> restResponses;
    private ConcurrentHashMap<String, String> processStates;
    
    @PostConstruct
    public void init(){
        restResponses = new ConcurrentHashMap<>();
        processStates = new ConcurrentHashMap<>();
    }

    @Lock(LockType.READ)
    public void setResponse(String username, AsyncResponse response, Object companion){
        restResponses.put("response-" + username, new AsyncResponseDTO(response, companion));
    }

    @Lock(LockType.READ)
    public AsyncResponseDTO getResponse(String username){
        return restResponses.get("response-" + username);
    }

    @Lock(LockType.READ)
    public void setState(String username, String className){
        processStates.put("state-" + username, className);
    }

    @Lock(LockType.READ)
    public String getState(String username){
        return processStates.get("state-" + username);
    }

    public class AsyncResponseDTO {
        private final AsyncResponse response;
        private final Object companion;

        AsyncResponseDTO(AsyncResponse response, Object companion){
            this.response = response;
            this.companion = companion;
        }

        public Object getCompanion() {
            return companion;
        }

        public AsyncResponse getResponse() {
            return response;
        }

    }
}
