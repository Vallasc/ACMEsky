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
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.container.Suspended;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import it.unibo.soseng.camunda.utils.ProcessState;
import it.unibo.soseng.gateway.user.dto.UserOfferDTO;
import it.unibo.soseng.logic.user.UserManager;
import it.unibo.soseng.logic.user.UserManager.BadRequestException;

import static it.unibo.soseng.camunda.utils.ProcessVariables.PROCESS_CONFIRM_BUY_OFFER;
import static it.unibo.soseng.security.Constants.USER;

@Path("offers")
public class OfferController {
    
    private final static Logger LOGGER = Logger.getLogger(OfferController.class.getName());

    @Inject
    private ProcessState processState;

    @Inject
    private UserManager userManager;
    
    @POST
    @Path("/confirmOffer")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public void confirmOfferToken(final @Valid UserOfferDTO request, 
                                    final @Context UriInfo uriInfo,
                                    final @Suspended AsyncResponse response) {
        LOGGER.info("POST userOffer token");
        userManager.startConfirmOffer(request, response, uriInfo);
    }


    @GET
    @Path("/requestPaymentLink")
    @RolesAllowed({USER})
    public void requestPaymentLink(final @Suspended AsyncResponse response) {
        LOGGER.info("GET paymentRequest");
        try {
            userManager.startPaymentRequest(response);
        } catch (BadRequestException e) {
            response.resume(Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build());
        }
    }
    
    @GET
    @Path("/getTickets")
    @RolesAllowed({USER})
    public Response getTickets() {
        /*System.out.println(username);
        byte[] out = (byte[]) processState.getState(PROCESS_BUY_OFFER, username, "PDF");
        System.out.println(out);
        return Response.status(Response.Status.OK.getStatusCode())
                        .header("Content-Type", "application/pdf")
                        .entity(out)
                        .build();*/
        return Response.status(Response.Status.OK.getStatusCode()).build();
    }
}