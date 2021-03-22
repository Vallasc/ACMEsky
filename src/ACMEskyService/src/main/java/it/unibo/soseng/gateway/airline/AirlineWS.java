package it.unibo.soseng.gateway.airline;

import javax.ws.rs.Path;

//import org.camunda.bpm.engine.ProcessEngines;
//import org.camunda.bpm.engine.RuntimeService;

import javax.ws.rs.GET;

import java.util.logging.Logger;

import javax.inject.Inject;

import it.unibo.soseng.logic.Prova;

@Path("airline")
public class AirlineWS {
    private final static Logger LOGGER = Logger.getLogger("REST API");

    @Inject
    private Prova prova;

    @GET
    @Path("hello")
    public String helloworld() {
        prova.setN(69);

        //RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        //runtimeService.startProcessInstanceByMessage("StartSaveOffer");
        
        return "Hello World!"+prova.getN();
    }
}