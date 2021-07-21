package it.unibo.soseng.gateway.user;

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

import it.unibo.soseng.camunda.ProcessState;
import it.unibo.soseng.gateway.user.dto.UserDTO;
import it.unibo.soseng.gateway.user.dto.UserSignUpDTO;
import it.unibo.soseng.logic.airline.AirlineManager;
import it.unibo.soseng.logic.database.DatabaseManager.UserAlreadyInException;
import it.unibo.soseng.logic.database.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.gateway.user.dto.UserInterestDTO;
import it.unibo.soseng.gateway.user.dto.UserOfferDTO;
import it.unibo.soseng.logic.user.UserManager;
import it.unibo.soseng.logic.user.UserManager.BadRequestException;

import static it.unibo.soseng.security.Constants.USER;

import static it.unibo.soseng.camunda.ProcessVariables.PROCESS_BUY_OFFER;

@Path("offers")
public class OfferController {
    
    private final static Logger LOGGER = Logger.getLogger(OfferController.class.getName());

    @Inject
    private ProcessState processState;

    @Inject
    private UserManager userManager;
    
    @GET
    @Path("/getTickets/{username}")
    public Response getTickets(@PathParam("username") String username) {
        System.out.println(username);
        byte[] out = (byte[]) processState.getState(PROCESS_BUY_OFFER, username, "PDF");
        System.out.println(out);
        return Response.status(Response.Status.OK.getStatusCode())
                        .header("Content-Type", "application/pdf")
                        .entity(out)
                        .build();

        
    }

    
    @GET
    @Path("/requestPaymentLink")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public void userOfferToken(final @Suspended AsyncResponse response) {
        LOGGER.info("GET paymentRequest");
        try {
            userManager.startPaymentRequest(response);
        } catch (BadRequestException e) {
            response.resume(Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build());
        }
    }
    
    @POST
    @Path("/confirmOffer")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public void userOfferToken(final @Valid UserOfferDTO request, 
                                    final @Context UriInfo uriInfo,
                                    final @Suspended AsyncResponse response) {
        LOGGER.info("POST userOffer token");
        try {
            userManager.startConfirmUserFlight(request, response, uriInfo);
        } catch (BadRequestException e) {
            response.resume(Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build());
        }
    }
    /*@Inject
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
            return Response.status(Response.Status.FORBIDDEN.getStatusCode()).build();
        } catch (BadRequestException e) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
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
    @Path("/me")
    @RolesAllowed({USER})
    @Produces( MediaType.APPLICATION_JSON )
    public UserResponse getUser(@PathParam("username") String username) {
        //return userManager.getUser(); // TODO TODO TODO
        return new UserResponse();
    }

    @POST
    @Path("/")
    @PermitAll
    @Consumes( MediaType.APPLICATION_JSON )
    public Response createUser(@Valid UserSignUpRequest request, @Context UriInfo uriInfo) {
        LOGGER.info("User sign in");
        try {
            userManager.createUser(request);
        } catch (UserAlreadyInException e) {
            return Response.status(Response.Status.CONFLICT.getStatusCode()).build();
        }
        return Response.status(Response.Status.CREATED.getStatusCode())
                        .header("Location", String.format("%s/%s", uriInfo.getAbsolutePath().toString(), request.getEmail()))
                        .build();
    }*/

    
}