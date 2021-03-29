package it.unibo.soseng;

import javax.ws.rs.*;

import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.RuntimeService;

import it.unibo.soseng.rest.Rest;

@Path("user")
public class HelloWorld {

    @GET
    @Path("hello")
    public String helloworld() {
        RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        runtimeService.startProcessInstanceByMessage("StartSaveOffer");
        //int n = Rest.getN();
        return "Hello World!";
    }
}