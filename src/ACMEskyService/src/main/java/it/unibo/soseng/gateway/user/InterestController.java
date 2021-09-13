package it.unibo.soseng.gateway.user;

import java.util.List;
import java.util.logging.Logger;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
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

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import it.unibo.soseng.gateway.user.dto.UserInterestDTO;
import it.unibo.soseng.logic.InterestManager;
import it.unibo.soseng.logic.DatabaseManager.InterestNotFoundException;
import it.unibo.soseng.logic.InterestManager.BadRequestException;

import static it.unibo.soseng.security.Constants.USER;

/**
 * Questa classe presenta le route a cui ACMEskyWeb può fare richieste per
 * inviare ad ACMEskyService le offerte di interesse dell'utente
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

@Path("interests")
public class InterestController {

    private final static Logger LOGGER = Logger.getLogger(InterestController.class.getName());

    @Inject
    private InterestManager interestManager;

    /**
     * Salva gli interessi dell'utente
     * 
     * @param offer    rchiesta con interessi di andata e ritorno
     * @param uriInfo  injected by jaxws
     * @param response injected by jaxws
     */
    @POST
    @Path("/")
    @RolesAllowed({ USER })
    @Consumes(MediaType.APPLICATION_JSON)
    @Operation(summary = "Salva interesse", description = "Salva l'interesse per una specifica tratta. Risorsa esclusiva dell'utente.")
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente")
    @ApiResponse(responseCode = "400", description = "Parametri della richiesta non corretti")
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    public void saveInterests(final @Valid UserInterestDTO offer, final @Context UriInfo uriInfo,
            final @Suspended AsyncResponse response) {
        LOGGER.info("POST interests");
        try {
            interestManager.startSaveUserInterests(offer, response, uriInfo);
        } catch (BadRequestException e) {
            response.resume(Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build());
        }
    }

    /**
     * Restituisce la lista degli interessi dell'utente
     * 
     * @return risposta con codice + lista degli interessi
     */
    @GET
    @Path("/")
    @RolesAllowed({ USER })
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(summary = "Get interessi", description = "Restituisce la lista degli interessi dell'utente. Risorsa esclusiva dell'utente.")
    @ApiResponse(responseCode = "200", description = "Richiesta non corretta", content = @Content(array = @ArraySchema(schema = @Schema(implementation = UserInterestDTO.class))))
    @ApiResponse(responseCode = "400", description = "Parametri della richiesta non corretti")
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    public Response getInterests() {
        LOGGER.info("GET interests");
        List<UserInterestDTO> interests = interestManager.getUserInterests();
        return Response.status(Response.Status.OK.getStatusCode()).entity(interests).build();
    }

    /**
     * Restrituisce l'interesse identificatio da id
     * 
     * @param id identificatore interesse
     * @return risposta con codice + interesse
     */
    @GET
    @Path("/{id}")
    @RolesAllowed({ USER })
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(summary = "Get interesse", description = "Restituisce l'interesse specificato dall'id. Risorsa esclusiva dell'utente.")
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente", content = @Content(schema = @Schema(implementation = UserInterestDTO.class)))
    @ApiResponse(responseCode = "400", description = "Parametri della richiesta non corretti")
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    @ApiResponse(responseCode = "404", description = "Interesse non trovato")
    public Response getInterest(final @PathParam("id") String id) {
        LOGGER.info("GET interest " + id);
        try {
            UserInterestDTO interests = interestManager.getUserInterest(id);
            return Response.status(Response.Status.OK.getStatusCode()).entity(interests).build();
        } catch (InterestNotFoundException e) {
            return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
        }
    }

    /**
     * Rimuove l'interesse identificato da is
     * 
     * @param id identificatore interesse
     * @return risposta con status code
     */
    @DELETE
    @Path("/{id}")
    @RolesAllowed({ USER })
    @Consumes(MediaType.APPLICATION_JSON)
    @Operation(summary = "Rimuove interesse", description = "Rimuove l'interesse specificato dall'id. Risorsa esclusiva dell'utente.")
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente")
    @ApiResponse(responseCode = "400", description = "Parametri della richiesta non corretti")
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    @ApiResponse(responseCode = "404", description = "Interesse non trovato")
    public Response deleteInterest(final @PathParam("id") String id) {
        LOGGER.info("DELETE interests");
        try {
            interestManager.deleteUserInterest(id);
            return Response.status(Response.Status.OK.getStatusCode()).build();
        } catch (InterestNotFoundException e) {
            return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
        }
    }

}