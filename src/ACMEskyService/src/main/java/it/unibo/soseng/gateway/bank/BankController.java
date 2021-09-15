package it.unibo.soseng.gateway.bank;

import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import it.unibo.soseng.logic.BankManager;

import java.util.logging.Logger;

import static it.unibo.soseng.security.Constants.BANK;

/**
 * Questa classe presenta le route a cui i servizi bancari registrati sul DB
 * possono effettuare richieste per raggiugere i loro obiettivi
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Path("banks")
@SecurityRequirement(name = "bearerAuth")
public class BankController {
    private final static Logger LOGGER = Logger.getLogger(BankController.class.getName());

    @Inject
    BankManager bankManager;

    /**
     * Conferma dell'avvenuto pagamento da parte della banca
     * 
     * @param code
     * @return
     */
    @GET
    @RolesAllowed({ BANK })
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/confirmPayment")
    @Operation(summary = "Conferma pagamento", description = "conferma dell'avvenuto pagamento da parte della banca. Risorsa esclusiva della banca.")
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente")
    @ApiResponse(responseCode = "400", description = "Parametri della richiesta non corretti")
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    public Response confirmPayment(@QueryParam("code") String code) {
        LOGGER.info("GET confirmPayment");
        LOGGER.info("code " + code);
        bankManager.paymentSuccess(code);
        return Response.status(Response.Status.OK.getStatusCode()).build();
    }
}