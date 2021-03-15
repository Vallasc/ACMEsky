package it.unibo.soseng;

import javax.ws.rs.*;

@Path("user")
public class HelloWorld
{

    @GET
    @Path("helloworld")
    public String helloworld() {
        return "Hello World!";
    }
}