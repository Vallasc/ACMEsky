package it.unibo.soseng.camunda.utils;

import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.PostConstruct;
import javax.ejb.Singleton;

@Singleton 
public class ProcessState {
    private ConcurrentHashMap<String, Object> processStates;
    
    @PostConstruct
    public void init(){
        processStates = new ConcurrentHashMap<>();
    }

    public void setState(String process, String username, String key, Object companion){
        processStates.put(process + username + key, companion);
    }

    public Object getState(String process, String username, String key){
        return processStates.get(process + username + key);
    }

    public Object getStateAndRemove(String process, String username, String key) {
        return processStates.remove(process + username + key);
    }
}
