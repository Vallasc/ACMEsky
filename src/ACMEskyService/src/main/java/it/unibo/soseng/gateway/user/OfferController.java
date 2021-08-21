package it.unibo.soseng.gateway.user;

import java.util.logging.Logger;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.container.Suspended;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import it.unibo.soseng.gateway.user.dto.AddressDTO;
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


    @PUT
    @Path("/paymentLink")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    @Produces(MediaType.APPLICATION_JSON)
    public void requestPaymentLink(final @Valid AddressDTO address,
                                    final @Suspended AsyncResponse response) {
        LOGGER.info("PUT paymentLink");
        offerManager.startPaymentRequest(address, response);
    }

    @PUT
    @Path("/reset")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    public void resetProcess(final @Valid UserOfferDTO request, 
                                    final @Suspended AsyncResponse response) {
        LOGGER.info("PUT reset process offer");
        offerManager.resetProcess(request, response);
    }
    
    @GET
    @Path("/{token}")
    @RolesAllowed({USER})
    @Produces(MediaType.APPLICATION_JSON)
    public Response getOffer(final @PathParam("token") String token) {
        LOGGER.info("GET offer");
        return offerManager.requestOffer(token);
    }

    @GET
    @Path("/{token}/ticket")
    @RolesAllowed({USER})
    @Produces(MediaType.APPLICATION_OCTET_STREAM)
    public Response getTickets(final @PathParam("token") String token) {
        return offerManager.requestTicket(token);
    }
}