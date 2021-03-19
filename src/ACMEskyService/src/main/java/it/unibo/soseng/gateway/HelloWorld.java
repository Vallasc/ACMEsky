package it.unibo.soseng.gateway;

import javax.ws.rs.Path;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;

import javax.ws.rs.GET;
import javax.inject.Inject;

import it.unibo.soseng.logic.Prova;

@Path("user")
public class HelloWorld {

    //@Inject
    //private Prova prova;

    @GET
    @Path("hello")
    public String helloworld() {
        //int n = Rest.getN();
        //prova.setN(69);

        RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        runtimeService.startProcessInstanceByMessage("StartSaveOffer");
        
        return "Hello World!";
    }
}