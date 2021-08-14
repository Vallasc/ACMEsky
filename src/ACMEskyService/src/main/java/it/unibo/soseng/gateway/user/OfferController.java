package it.unibo.soseng.gateway.user;

import java.util.logging.Logger;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.container.Suspended;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import it.unibo.soseng.gateway.user.dto.UserOfferDTO;
import it.unibo.soseng.logic.offer.OfferManager;

import static it.unibo.soseng.security.Constants.USER;

@Path("offers")
public class OfferController {
    
    private final static Logger LOGGER = Logger.getLogger(OfferController.class.getName());

    @Inject
    private OfferManager offerManager;
    
    @PUT
    @Path("/confirm")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public void confirmOfferToken(final @Valid UserOfferDTO request, 
                                    final @Context UriInfo uriInfo,
                                    final @Suspended AsyncResponse response) {
        LOGGER.info("PUT confirm offer");
        offerManager.startConfirmOffer(request, response, uriInfo);
    }


    @GET
    @Path("/paymentLink")
    @RolesAllowed({USER})
    @Produces(MediaType.APPLICATION_JSON)
    public void requestPaymentLink(final @Suspended AsyncResponse response) {
        LOGGER.info("GET paymentLink");
        offerManager.startPaymentRequest(response);
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