package it.unibo.soseng.gateway.user;

import java.io.File;
import java.util.logging.Logger;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.security.enterprise.SecurityContext;
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
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.OfferNotFoundException;
import it.unibo.soseng.logic.offer.OfferManager;
import it.unibo.soseng.model.GeneratedOffer;

import static it.unibo.soseng.security.Constants.USER;

@Path("offers")
public class OfferController {
    
    private final static Logger LOGGER = Logger.getLogger(OfferController.class.getName());

    @Inject
    private OfferManager offerManager;

    @Inject
    private DatabaseManager databaseManager;

    @Inject
    private SecurityContext securityContext;
    
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
    
    @GET
    @Path("{token}")
    @RolesAllowed({USER})
    @Produces(MediaType.APPLICATION_OCTET_STREAM)
    public Response getTickets(final @PathParam("token") String token) {
        String email = securityContext.getCallerPrincipal().getName();
        try {
            GeneratedOffer offer = databaseManager.getOfferByTokenEmail(token, email);
            if(offer.getBooked()){ 
                File file = new File(offer.getToken() + ".pdf");
                return Response.ok(file, MediaType.APPLICATION_OCTET_STREAM)
                    .header("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"" )
                    .build();
            }
            return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
        } catch (OfferNotFoundException e) {}
        return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
    }

}