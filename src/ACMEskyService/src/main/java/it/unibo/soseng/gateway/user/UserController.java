package it.unibo.soseng.gateway.user;

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

import it.unibo.soseng.gateway.user.dto.InterestsRequest;
import it.unibo.soseng.gateway.user.dto.UserResponse;
import it.unibo.soseng.gateway.user.dto.UserSignInRequest;
import it.unibo.soseng.logic.airline.AirlineManager;
import it.unibo.soseng.logic.airline.AirlineManager.UserNotAllowedException;
import it.unibo.soseng.logic.database.DatabaseManager.UserAlreadyInException;
import it.unibo.soseng.logic.database.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.logic.user.UserManager;
import it.unibo.soseng.model.User;

import static it.unibo.soseng.security.Constants.USER;

@Path("users")
public class UserController {
    
    private final static Logger LOGGER = Logger.getLogger(UserController.class.getName());

    @Inject
    private UserManager userManager;

    @Inject
    private AirlineManager airlineManager;

    @POST
    @Path("/{username}/interests")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public Response saveInterests(@Valid InterestsRequest offer, 
                                    @Context UriInfo uriInfo, 
                                    @PathParam("username") String username) {
        LOGGER.info("POST interests");
        try {
            airlineManager.startSaveUserInterests(offer, username);
        } catch (UserNotAllowedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return Response.status(Response.Status.CREATED.getStatusCode())
                        .header("Location", String.format("%s/%s", uriInfo.getAbsolutePath().toString(), "######ID"))
                        .build();
    }

    @GET
    @Path("/{username}/interests")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public Response getInterests(@PathParam("username") String username) {
        LOGGER.info("GET interests");
        return Response.status(Response.Status.CREATED.getStatusCode()).build();
    }

    @GET
    @Path("/{username}/interests/{id}")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public Response getInterest(@PathParam("username") String username) {
        LOGGER.info("GET interests");
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
    public Response createUser(@Valid UserSignInRequest request, @Context UriInfo uriInfo) {
        LOGGER.info("User sign in");
        try {
            userManager.createUser(request);
        } catch (UserAlreadyInException e) {
            return Response.status(Response.Status.CONFLICT.getStatusCode()).build();
        }
        return Response.status(Response.Status.CREATED.getStatusCode())
                        .header("Location", String.format("%s/%s", uriInfo.getAbsolutePath().toString(), request.getEmail()))
                        .build();
    }
}