package it.unibo.soseng;

import javax.ws.rs.*;

@Path("tutorial")
public class HelloWorld
{

    @GET
    @Path("helloworld")
    public String helloworld() {
        return "Hello World!";
    }
}