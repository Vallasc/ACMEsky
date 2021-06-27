package it.unibo.soseng.gateway.user;

import java.util.logging.Logger;

import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.persistence.PersistenceException;
import javax.security.enterprise.SecurityContext;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import it.unibo.soseng.gateway.user.dto.InterestsRequest;
import it.unibo.soseng.gateway.user.dto.UserDeleteRequest;
import it.unibo.soseng.gateway.user.dto.UserResponse;
import it.unibo.soseng.gateway.user.dto.UserSignUpRequest;
import it.unibo.soseng.gateway.user.dto.UserUpdateRequest;
import it.unibo.soseng.logic.airline.AirlineManager;
import it.unibo.soseng.logic.airline.AirlineManager.BadRequestException;
import it.unibo.soseng.logic.airline.AirlineManager.UserNotAllowedException;
import it.unibo.soseng.logic.database.DatabaseManager.UserAlreadyInException;
import it.unibo.soseng.logic.database.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.logic.user.UserManager;
import it.unibo.soseng.logic.user.UserManager.InvalidCredentialsException;

import static it.unibo.soseng.security.Constants.USER;

@Path("users")
public class UserController {
    
    private final static Logger LOGGER = Logger.getLogger(UserController.class.getName());

    @Inject
    private UserManager userManager;

    @Inject
    private AirlineManager airlineManager;

    @GET
    @Path("/me")
    @RolesAllowed({USER})
    @Produces( MediaType.APPLICATION_JSON )
    public Response getUser() {
        try {
            UserResponse response = userManager.getUser();
            return Response.status(Response.Status.OK.getStatusCode()).entity(response).build();
        } catch (UserNotFoundException e) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
    }

    @POST
    @Path("/")
    @PermitAll
    @Consumes( MediaType.APPLICATION_JSON )
    public Response createUser(@Valid UserSignUpRequest request, @Context UriInfo uriInfo) {
        LOGGER.info("User sign up");
        try {
            userManager.createUser(request);
        } catch (UserAlreadyInException e) {
            return Response.status(Response.Status.CONFLICT.getStatusCode()).build();
        } catch (Exception e) {
            LOGGER.severe(e.toString());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
        }
        return Response.status(Response.Status.CREATED.getStatusCode())
                        .header("Location", String.format("%s/%s", uriInfo.getAbsolutePath().toString(), request.getEmail()))
                        .build();
    }

    @PUT
    @Path("/me")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    @Produces( MediaType.APPLICATION_JSON )
    public Response updateUser(@Valid UserUpdateRequest request) {
        try {
            UserResponse response = userManager.updateUser(request);
            return Response.status(Response.Status.OK.getStatusCode()).entity(response).build();
        } catch (InvalidCredentialsException | UserNotFoundException e) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
    }

    @DELETE
    @Path("/me")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public Response deleteUser(@Valid UserDeleteRequest request) {
        try {
            userManager.deleteUser(request);
            return Response.status(Response.Status.OK.getStatusCode()).build();
        } catch (PersistenceException | InvalidCredentialsException | UserNotFoundException e) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
    }

    @POST
    @Path("/me/interests")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public Response saveInterests(@Valid InterestsRequest offer, 
                                    @Context UriInfo uriInfo, 
                                    @PathParam("username") String username) {
        LOGGER.info("POST interests");
        try {
            airlineManager.startSaveUserInterests(offer, username);
        } catch (UserNotAllowedException e) {
            return Response.status(Response.Status.FORBIDDEN.getStatusCode()).build();
        } catch (BadRequestException e) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        return Response.status(Response.Status.CREATED.getStatusCode())
                        .header("Location", String.format("%s/%s", uriInfo.getAbsolutePath().toString(), "######ID"))
                        .build();
    }

    @GET
    @Path("/me/interests")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public Response getInterests() { //TODO modificare
        LOGGER.info("GET interests");
        return Response.status(Response.Status.CREATED.getStatusCode()).build();
    }

    @GET
    @Path("/me/interests/{id}")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public Response getInterest(@PathParam("id") String id) { //TODO modificare
        LOGGER.info("GET interests");
        return Response.status(Response.Status.CREATED.getStatusCode()).build();
    }

}