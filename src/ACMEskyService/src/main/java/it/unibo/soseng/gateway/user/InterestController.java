package it.unibo.soseng.gateway.user;

import java.util.List;
import java.util.logging.Logger;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.container.Suspended;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import it.unibo.soseng.gateway.user.dto.UserInterestDTO;
import it.unibo.soseng.logic.interest.InterestManager;
import it.unibo.soseng.logic.interest.InterestManager.BadRequestException;

import static it.unibo.soseng.security.Constants.USER;

@Path("interests")
public class InterestController {
    
    private final static Logger LOGGER = Logger.getLogger(InterestController.class.getName());

    @Inject 
    private InterestManager interestManager;

    @POST
    @Path("/")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public void saveInterests(final @Valid UserInterestDTO offer, 
                                    final @Context UriInfo uriInfo,
                                    final @Suspended AsyncResponse response) {
        LOGGER.info("POST interests");
        try {
            interestManager.startSaveUserInterests(offer, response, uriInfo);
        } catch (BadRequestException e) {
            response.resume(Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build());
        }
    }

    @GET
    @Path("/")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    @Produces( MediaType.APPLICATION_JSON )
    public Response getInterests() {
        LOGGER.info("GET interests");
        List<UserInterestDTO> interests = interestManager.getUserInterests();
        return Response.status(Response.Status.OK.getStatusCode()).entity(interests).build();
    }

    @GET
    @Path("/{id}")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    @Produces( MediaType.APPLICATION_JSON )
    public Response getInterest(final @PathParam("id") String id) {
        LOGGER.info("GET interest " + id);
        UserInterestDTO interests = interestManager.getUserInterest(id);
        return Response.status(Response.Status.OK.getStatusCode()).entity(interests).build();
    }

    /*@DELETE
    @Path("/{id}")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public Response deleteInterest(final @PathParam("id") String id) {
        LOGGER.info("DELETE interests");
        return Response.status(Response.Status.OK.getStatusCode()).build();
    }*/

}