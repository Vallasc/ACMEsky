package it.unibo.soseng.gateway.user;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;

import it.unibo.soseng.gateway.user.dto.AirportDTO;
import it.unibo.soseng.logic.InterestManager;
import it.unibo.soseng.logic.DatabaseManager.AirportNotFoundException;

import static it.unibo.soseng.security.Constants.USER;

/**
 * Questa classe presenta le route di ACMEsky che ACMEskyWeb può chiamare per
 * conto dell'utente, per consentire a quest'ultimo di cercare gli aereoporti
 * per stabilire quelli di partenza e arrivo dei voli dell'offerta a cui è
 * interessato
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

@Path("airports")
public class AirportController {

    private final static Logger LOGGER = Logger.getLogger(AirportController.class.getName());

    @Inject
    private InterestManager interestManager;

    /**
     * Restituisce la lista degli aereoporti filtrati dato il parametro query
     * 
     * @param query filtro
     * @return risposta con codice + lista degli aereoporti
     */
    @GET
    @Path("/")
    @RolesAllowed({ USER })
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(summary = "Lista degli areoporti filtrati", description = "Restituisce la lista degli aereoporti filtrati dato il parametro query. Risorsa esclusiva dell'utente.")
    @ApiResponse(responseCode = "200", description = "Richiesta non corretta", content = @Content(array = @ArraySchema(schema = @Schema(implementation = AirportDTO.class))))
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    public Response getAirports(@QueryParam("query") String query) {
        LOGGER.info("GET airports query");
        if (query != null && query.trim().length() > 0) {
            List<AirportDTO> airports = interestManager.getAirportsFromQuery(query);
            return Response.status(Response.Status.OK.getStatusCode()).entity(airports).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(new ArrayList<>()).build();
    }

    /**
     * Restituisce l'areoporto dato il codice
     * 
     * @param code codice areoporto
     * @return riposta con codice + oggetto areoporto
     */
    @GET
    @Path("/{code}")
    @RolesAllowed({ USER })
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(summary = "Get areoporto", description = "Restituisce l'areoporto dato il codice. Risorsa esclusiva dell'utente.")
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente", content = @Content(schema = @Schema(implementation = AirportDTO.class)))
    @ApiResponse(responseCode = "400", description = "Parametri della richiesta non corretti")
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    @ApiResponse(responseCode = "404", description = "Areoporto non trovato")
    public Response getAirport(@PathParam("code") String code) {
        LOGGER.info("GET airport ");
        try {
            AirportDTO airport = interestManager.getAirport(code);
            return Response.status(Response.Status.OK.getStatusCode()).entity(airport).build();
        } catch (AirportNotFoundException e) {
            return Response.status(Response.Status.NOT_FOUND.getStatusCode()).build();
        }
    }
}