package it.unibo.soseng.gateway.airline;

import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;

import java.util.logging.Logger;

import javax.inject.Inject;

import it.unibo.soseng.gateway.airline.dao.OfferRequest;
import it.unibo.soseng.logic.airline.AirlineManager;

@Path("airline")
public class AirlineController {
    private final static Logger LOGGER = Logger.getLogger("AirlineWS");

    @Inject
    AirlineManager airlineManager;

    @POST
    @Path("/offers")
    @Consumes( MediaType.APPLICATION_JSON )
    public Response saveOffer(OfferRequest offer, @Context UriInfo uriInfo) {
        LOGGER.info("POST offers");
        airlineManager.saveAirlineOffer(offer.toFlight());
        return Response.status(Response.Status.CREATED.getStatusCode())
                        .header("Location", String.format("%s/%s", uriInfo.getAbsolutePath().toString(), offer.getFlightId()))
                        .build();
    }
}