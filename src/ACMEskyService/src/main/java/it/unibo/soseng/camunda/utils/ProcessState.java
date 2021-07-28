package it.unibo.soseng.camunda.utils;

import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.PostConstruct;
import javax.ejb.ConcurrencyManagement;
import javax.ejb.Lock;
import javax.ejb.LockType;
import javax.ejb.Singleton;

import static javax.ejb.ConcurrencyManagementType.BEAN;

@Singleton 
@ConcurrencyManagement(BEAN)
public class ProcessState {
    private ConcurrentHashMap<String, Object> processStates;
    
    @PostConstruct
    public void init(){
        processStates = new ConcurrentHashMap<>();
    }

    @Lock(LockType.READ)
    public void setState(String process, String username, String key, Object companion){
        processStates.put(process + username + key, companion);
    }

    @Lock(LockType.READ)
    public Object getState(String process, String username, String key){
        return processStates.get(process + username + key);
    }

    @Lock(LockType.READ)
    public Object getStateAndRemove(String process, String username, String key){
        return processStates.remove(process + username + key);
    }
}
