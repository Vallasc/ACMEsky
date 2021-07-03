package it.unibo.soseng.gateway.user;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import it.unibo.soseng.gateway.user.dto.AirportDTO;
import it.unibo.soseng.logic.database.DatabaseManager.AirportNotFoundException;
import it.unibo.soseng.logic.interest.InterestManager;

import static it.unibo.soseng.security.Constants.USER;

@Path("airports")
public class AirportController {
    
    private final static Logger LOGGER = Logger.getLogger(AirportController.class.getName());

    @Inject 
    private InterestManager interestManager;


    @GET
    @Path("/")
    @RolesAllowed({USER})
    @Produces( MediaType.APPLICATION_JSON )
    public Response getAirports(@QueryParam("query") String query) {
        LOGGER.info("GET airports query");
        if(query != null && query.trim().length() > 0){
            List<AirportDTO> airports = interestManager.getAirportsFromQuery(query);
            return Response.status(Response.Status.OK.getStatusCode()).entity(airports).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(new ArrayList<>()).build();
    }

    @GET
    @Path("/{code}")
    @RolesAllowed({USER})
    @Produces( MediaType.APPLICATION_JSON )
    public Response getAirport(@PathParam("code") String code) {
        LOGGER.info("GET airport ");
        try {
            AirportDTO airport = interestManager.getAirport(code);
            return Response.status(Response.Status.OK.getStatusCode()).entity(airport).build();
        } catch (AirportNotFoundException e) {
            return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
        }
    }
}