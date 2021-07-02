package it.unibo.soseng.gateway;

import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;

import io.jsonwebtoken.io.IOException;
import it.unibo.soseng.gateway.prontogram.ProntogramClient;
import it.unibo.soseng.gateway.prontogram.dto.Notification;
import it.unibo.soseng.model.Airline;
import it.unibo.soseng.model.Airport;
import it.unibo.soseng.model.DomainEntity;
import it.unibo.soseng.model.Flight;
import javax.ws.rs.core.MediaType;

@Path("prova")
public class prova {
    
    @GET
    @Path("/notifica")
    @PermitAll
    @Produces( MediaType.APPLICATION_JSON )
    public Response getNotify() throws IOException, InterruptedException, java.io.IOException {
        System.out.println("INIZIO CHIAMATA");
        ProntogramClient client = new ProntogramClient ();
        Notification notification = new Notification();
        Flight f = new Flight ();
        Airline a = new Airline ();
        DomainEntity d = new DomainEntity ();
        d.setRole("AIRLINE");
        d.setUsername("Alitalia");
        a.setEntity(d);
        f.setAirline(a);
        f.setArrivalAirport(new Airport ());
        f.setPrice(123);
        notification.setFlyBack(f);
        client.sendNotificationOffer (notification);
        return Response.status(Response.Status.OK.getStatusCode()).build();
       
    }
    
}
