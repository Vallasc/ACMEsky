package it.unibo.soseng.gateway.web;

import java.util.logging.Logger;

import javax.ws.rs.POST;
import javax.ws.rs.Path;

@Path("bank")
public class AppWS {
    private final static Logger LOGGER = Logger.getLogger("REST API");

    @POST
    @Path("hello")
    public String helloworld() {

        //RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        //runtimeService.startProcessInstanceByMessage("StartSaveOffer");
        
        return "Hello World!";
    }
}