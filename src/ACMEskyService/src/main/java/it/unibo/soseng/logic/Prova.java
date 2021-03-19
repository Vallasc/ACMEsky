package it.unibo.soseng.logic;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;
import javax.inject.Singleton;
import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class Prova {
    private int n = 99;

    @PostConstruct
    public void afterCreate() {
        System.out.println("PROVA created");
    }

    public void sendMessage(){
        RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        runtimeService.startProcessInstanceByMessage("StartSaveOffer");
    }

    public int getN() {
        return n;
    }

    public void setN(int n) {
        this.n = n;
    }
}
