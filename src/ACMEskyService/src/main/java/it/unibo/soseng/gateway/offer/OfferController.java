package it.unibo.soseng.gateway.offer;


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
import it.unibo.soseng.logic.offer.OfferManager;

import static it.unibo.soseng.security.Constants.AIRLINE;

@Path("airline")
public class OfferController {
    private final static Logger LOGGER = Logger.getLogger(OfferController.class.getName());
    
    @Inject
    OfferManager offerManager;

    @Inject
    SecurityContext securityContext;

    @POST
    @Path("/notification/new")
    @RolesAllowed({AIRLINE})
    @Consumes( MediaType.APPLICATION_JSON )
    public Response saveLastMinute(List<AirlineFlightOffer> offers) {
        String name = securityContext.getCallerPrincipal().getName();
        //airlineManager.startSaveLastMinuteProcess(offers, name);
        return Response.status(Response.Status.CREATED.getStatusCode()).build();
    }

}