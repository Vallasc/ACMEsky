package it.unibo.soseng;

import javax.ws.rs.*;


@Path("user")
public class HelloWorld {

    @GET
    @Path("hello")
    public String helloworld() {
        //RuntimeService runtimeService = ProcessEngines.getDefaultProcessEngine().getRuntimeService();
        //runtimeService.startProcessInstanceByMessage("StartSaveOffer");
        return "Hello World!";
    }
}