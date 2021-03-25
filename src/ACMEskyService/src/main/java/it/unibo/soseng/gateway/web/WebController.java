package it.unibo.soseng.gateway.web;

import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import it.unibo.soseng.gateway.web.dao.InterestsRequest;

@Path("web")
public class WebController {
    private final static Logger LOGGER = Logger.getLogger("AppWS");

    @POST
    @Path("/interests")
    @Consumes( MediaType.APPLICATION_JSON )
    public Response saveInterests(InterestsRequest offer, @Context UriInfo uriInfo) {
        LOGGER.info("POST interests");
        return Response.status(Response.Status.CREATED.getStatusCode())
                        .header("Location", String.format("%s/%s", uriInfo.getAbsolutePath().toString(), "######ID"))
                        .build();
    }

}