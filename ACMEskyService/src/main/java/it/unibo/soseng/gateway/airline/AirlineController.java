package it.unibo.soseng.gateway.airline;

import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;

import java.util.List;
import java.util.logging.Logger;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.security.enterprise.SecurityContext;

import it.unibo.soseng.gateway.airline.dto.AirlineFlightOffer;
import it.unibo.soseng.logic.airline.AirlineManager;
import static it.unibo.soseng.security.Constants.AIRLINE;

@Path("airlines")
public class AirlineController {
    private final static Logger LOGGER = Logger.getLogger(AirlineController.class.getName());
    
    @Inject
    AirlineManager airlineManager;

    @Inject
    SecurityContext securityContext;

    @POST
    @Path("/last_minute")
    @RolesAllowed({AIRLINE})
    @Consumes( MediaType.APPLICATION_JSON )
    public Response saveLastMinute(List<AirlineFlightOffer> offers) {
        String name = securityContext.getCallerPrincipal().getName();
        airlineManager.startSaveLastMinuteProcess(offers, name);
        return Response.status(Response.Status.CREATED.getStatusCode()).build();
    }

}