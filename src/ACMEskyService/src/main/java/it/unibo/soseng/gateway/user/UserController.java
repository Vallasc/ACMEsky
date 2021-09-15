package it.unibo.soseng.gateway.user;

import java.util.logging.Logger;

import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.persistence.PersistenceException;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;

import io.swagger.v3.oas.annotations.responses.ApiResponse;
import it.unibo.soseng.gateway.user.dto.UserDTO;
import it.unibo.soseng.gateway.user.dto.UserSignUpDTO;
import it.unibo.soseng.gateway.user.dto.UserUpdateDTO;
import it.unibo.soseng.logic.UserManager;
import it.unibo.soseng.logic.DatabaseManager.UserAlreadyInException;
import it.unibo.soseng.logic.DatabaseManager.UserNotFoundException;
import it.unibo.soseng.logic.UserManager.InvalidCredentialsException;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

import static it.unibo.soseng.security.Constants.USER;

/**
 * Controller che gestisce le richieste per la gestione degli utenti
 */
@Path("users")
public class UserController {
    
    private final static Logger LOGGER = Logger.getLogger(UserController.class.getName());

    @Inject
    private UserManager userManager;

    /**
     * GET User
     * @return UserDTO
     */
    @GET
    @Path("/me")
    @RolesAllowed({USER})
    @Produces( MediaType.APPLICATION_JSON )
    @Operation(summary = "Richiesta utente", 
                description = "Restituisce l'utente identificato con il token jwt.  Risorsa esclusiva dell'utente.",
                security = @SecurityRequirement(name = "bearerAuth"))
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente",
                content = @Content( schema = @Schema(implementation = UserDTO.class)))
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    public Response getUser() {
        try {
            UserDTO response = userManager.getUser();
            return Response.status(Response.Status.OK.getStatusCode()).entity(response).build();
        } catch (UserNotFoundException e) {
            return Response.status(Response.Status.UNAUTHORIZED.getStatusCode()).build();
        }
    }

    /**
     * Registra l'utente nel sistema
     * @param request richiesta di registrazione
     * @param uriInfo injected by javax
     * @return risposta con status code
     */
    @POST
    @Path("/")
    @PermitAll
    @Consumes( MediaType.APPLICATION_JSON )
    @Operation(summary = "Creazione utente", 
                description = "Registra un utente nel sistema. Risorsa esclusiva dell'utente.")
    @ApiResponse(responseCode = "201", description = "Risorsa creata correttamente")
    @ApiResponse(responseCode = "400", description = "Parametri della richiesta non corretti")
    @ApiResponse(responseCode = "409", description = "Utente non esistente")
    @ApiResponse(responseCode = "500", description = "Errore interno")
    public Response createUser(final @Valid UserSignUpDTO request, 
                                final @Context UriInfo uriInfo) {
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

    /**
     * Aggiorna gli attributi dell'utente
     * @param request richiesta contenente l'oggetto UserDTO
     * @return risposta con l'entità agiornata
     */
    @PUT
    @Path("/me")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    @Produces( MediaType.APPLICATION_JSON )
    @Operation(summary = "Aggiornamento utente", 
        description = "Aggiorna gli attributi dell'utente identificato con il token jwt. Risorsa esclusiva dell'utente.",
        security = @SecurityRequirement(name = "bearerAuth"))
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente",
                content = @Content( schema = @Schema(implementation = UserDTO.class)))
    @ApiResponse(responseCode = "400", description = "Parametri della richiesta non corretti")
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    public Response updateUser(final @Valid UserUpdateDTO request) {
        try {
            UserDTO response = userManager.updateUser(request);
            return Response.status(Response.Status.OK.getStatusCode()).entity(response).build();
        } catch (InvalidCredentialsException | UserNotFoundException e) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
    }

    /**
     * Elimina l'utente
     * @return risposta con status code
     */
    @DELETE
    @Path("/me")
    @RolesAllowed({USER})
    @Consumes( MediaType.APPLICATION_JSON )
    @Operation(summary = "Eliminazione utente", 
                description = "Elimina l'utente identificato con il token jwt. Risorsa esclusiva dell'utente.",
                security = @SecurityRequirement(name = "bearerAuth"))
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente")
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    public Response deleteUser() {
        try {
            userManager.deleteUser();
            return Response.status(Response.Status.OK.getStatusCode()).build();
        } catch (PersistenceException | InvalidCredentialsException | UserNotFoundException e) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
    }

}