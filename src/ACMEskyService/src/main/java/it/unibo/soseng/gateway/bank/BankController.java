package it.unibo.soseng.gateway.bank;

import javax.ws.rs.Path;

//import org.camunda.bpm.engine.ProcessEngines;
//import org.camunda.bpm.engine.RuntimeService;

import javax.ws.rs.GET;

import java.util.logging.Logger;


@Path("bank")
public class BankController {
    private final static Logger LOGGER = Logger.getLogger("REST API");

    @GET
    @Path("hello")
    public String helloworld() {
        return "Hello World!";
    }
}