package it.unibo.soseng.gateway.web;

import java.util.logging.Logger;

import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import it.unibo.soseng.gateway.web.dto.InterestsRequest;
import it.unibo.soseng.gateway.web.dto.UserResponse;
import it.unibo.soseng.gateway.web.dto.UserSignInRequest;
import it.unibo.soseng.logic.user.UserManager;
import it.unibo.soseng.model.User;

import static it.unibo.soseng.security.Constants.USER;

@Path("users")
public class WebController {
    
    private final static Logger LOGGER = Logger.getLogger(WebController.class.getName());

    @Inject
    private UserManager userManager;

    @POST
    @Path("/{username}/interests")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public Response saveInterests(@Valid InterestsRequest offer, 
                                    @Context UriInfo uriInfo, 
                                    @PathParam("username") String username) {
        LOGGER.info("POST interests");
        return Response.status(Response.Status.CREATED.getStatusCode())
                        .header("Location", String.format("%s/%s", uriInfo.getAbsolutePath().toString(), "######ID"))
                        .build();
    }

    @GET
    @Path("/{username}/interests")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public Response getInterests(@PathParam("username") String username) {
        LOGGER.info("POST interests");
        return Response.status(Response.Status.CREATED.getStatusCode()).build();
    }

    @GET
    @Path("/{username}")
    @RolesAllowed({USER})
    @Produces( MediaType.APPLICATION_JSON )
    public UserResponse getUser(@PathParam("username") String username) {
        return userManager.getUser(username);
    }

    @POST
    @Path("/")
    @PermitAll
    @Consumes( MediaType.APPLICATION_JSON )
    public Response createUser(@Valid UserSignInRequest request) {
        LOGGER.info("User sign in");
        userManager.createUser(request);
        return Response.status(Response.Status.CREATED.getStatusCode()).build();
    }
}