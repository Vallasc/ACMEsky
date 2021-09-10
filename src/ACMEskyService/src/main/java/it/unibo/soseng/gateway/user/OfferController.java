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

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import it.unibo.soseng.gateway.user.dto.AddressDTO;
import it.unibo.soseng.gateway.user.dto.OfferDTO;
import it.unibo.soseng.gateway.user.dto.UserOfferDTO;
import it.unibo.soseng.logic.OfferManager;

import static it.unibo.soseng.security.Constants.USER;

/**
 * Controller che gestrisce le richieste riguardanti le offerte
 * degli utenti
 */
@Path("offers")
public class OfferController {
    
    private final static Logger LOGGER = Logger.getLogger(OfferController.class.getName());

    @Inject
    private OfferManager offerManager;
    
    /**
     * Conferma l'offerta con il codice
     * @param request oggetto con codice offerta
     * @param uriInfo injected by jaxws
     * @param response risposta con status code
     */
    @PUT
    @Path("/confirm")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    @Produces( MediaType.APPLICATION_JSON )
    @Operation(summary = "Conferma l'offerta", 
                description = "Conferma l'offerta dato il codice.  Risorsa esclusiva dell'utente.")
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente")
    @ApiResponse(responseCode = "400", description = "Parametri della richiesta non corretti")
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    @ApiResponse(responseCode = "404", description = "Offerta non trovata")
    public void confirmOfferToken(final @Valid UserOfferDTO request, 
                                    final @Context UriInfo uriInfo,
                                    final @Suspended AsyncResponse response) {
        LOGGER.info("PUT confirm offer");
        offerManager.startConfirmOffer(request, response, uriInfo);
    }


    /**
     * Richiesta link di pagamento
     * @param address indirizzo di domicilio dell'utente
     * @param response risposta con status code
     */
    @PUT
    @Path("/paymentLink")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    @Produces( MediaType.APPLICATION_JSON )
    @Operation(summary = "Rchiesta link di pagamento", 
                description = "Richiesta link di pagamento dato il codice offerta. Risorsa esclusiva dell'utente.")
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente")
    @ApiResponse(responseCode = "400", description = "Parametri della richiesta non corretti")
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    @ApiResponse(responseCode = "404", description = "Offerta non trovata")
    public void requestPaymentLink(final @Valid AddressDTO address,
                                    final @Suspended AsyncResponse response) {
        LOGGER.info("PUT paymentLink");
        offerManager.startPaymentRequest(address, response);
    }

    /**
     * Reset del processo di acquisto
     * @param request codice offerta
     * @param response risposta con status code
     */
    @PUT
    @Path("/reset")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    @Operation(summary = "Reset del processo di acquisto", 
                description = "Reset del processo di acquisto dell'offerta. Risorsa esclusiva dell'utente.")
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente")
    @ApiResponse(responseCode = "400", description = "Parametri della richiesta non corretti")
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    @ApiResponse(responseCode = "404", description = "Offerta non trovata")
    public void resetProcess(final @Valid UserOfferDTO request, 
                                    final @Suspended AsyncResponse response) {
        LOGGER.info("PUT reset process offer");
        offerManager.resetProcess(request, response);
    }
    
    /**
     * Restituisce tutte le offerte generate per l'utente
     * @return lista di offerte
     */
    @GET
    @Path("/")
    @RolesAllowed({USER})
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(summary = "Get offers", 
                description = "Restituisce le offerte dell'utente. Risorsa esclusiva dell'utente.")
    @ApiResponse(responseCode = "200", description = "Richiesta non corretta",
                content = @Content( array = @ArraySchema(schema = @Schema(implementation = OfferDTO.class))))
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    public Response getOffers() {
        LOGGER.info("GET offers");
        return offerManager.requestOffers();
    }

    /**
     * Restituisce l'offerta dato il codice
     * @param token codice offerta
     * @return offerta se disponibile 404
     */
    @GET
    @Path("/{token}")
    @RolesAllowed({USER})
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(summary = "Get offer", 
                description = "Restituisce l'offerta dato il codice. Risorsa esclusiva dell'utente.")
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente",
                content = @Content( schema = @Schema(implementation = OfferDTO.class)))
    @ApiResponse(responseCode = "400", description = "Parametri della richiesta non corretti")
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    @ApiResponse(responseCode = "404", description = "Offerta non trovata")
    public Response getOffer(final @PathParam("token") String token) {
        LOGGER.info("GET offer");
        return offerManager.requestOffer(token);
    }

    /**
     * Restituisce il ticket dell'offerta dato il codice
     * @param token codice offerta
     * @return pdf se disponibile
     */
    @GET
    @Path("/{token}/ticket")
    @RolesAllowed({USER})
    @Produces(MediaType.APPLICATION_OCTET_STREAM)
    @Operation(summary = "Get offer ticket", 
                description = "Restituisce il ticket dell'offerta dato il codice. Risorsa esclusiva dell'utente.")
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente")
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    @ApiResponse(responseCode = "404", description = "Offerta non trovata")
    public Response getTickets(final @PathParam("token") String token) {
        return offerManager.requestTicket(token);
    }
}