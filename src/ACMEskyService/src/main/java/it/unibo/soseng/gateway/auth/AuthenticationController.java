package it.unibo.soseng.gateway.auth;

import static it.unibo.soseng.security.Constants.AUTHORIZATION_HEADER;
import static it.unibo.soseng.security.Constants.BEARER;

import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.security.enterprise.identitystore.CredentialValidationResult;
import javax.security.enterprise.identitystore.IdentityStoreHandler;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.security.enterprise.SecurityContext;
import javax.ws.rs.core.Response.Status;

import javax.security.enterprise.credential.UsernamePasswordCredential;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;

import it.unibo.soseng.gateway.auth.dto.AuthRequestDTO;
import it.unibo.soseng.gateway.auth.dto.AuthResponseDTO;
import it.unibo.soseng.logic.DatabaseManager;
import it.unibo.soseng.logic.DatabaseManager.EntityNotFoundException;
import it.unibo.soseng.model.DomainEntity;
import it.unibo.soseng.security.TokenProvider;

import java.util.logging.Level;
import java.util.logging.Logger;


import static it.unibo.soseng.security.Constants.BANK;
import static it.unibo.soseng.security.Constants.AIRLINE;
import static it.unibo.soseng.security.Constants.USER;
@Path("auth")
@Consumes({ MediaType.APPLICATION_JSON })
@Produces({ MediaType.APPLICATION_JSON })
public class AuthenticationController {

    private static final Logger LOG = Logger.getLogger(AuthenticationController.class.getName());
    @Inject
    private IdentityStoreHandler identityStoreHandler;

    @Inject
    private TokenProvider tokenProvider;

    @Inject
    private SecurityContext securityContext;

    @Inject
    private DatabaseManager databaseManager;

    /**
     * Richiesta di autenticazione
     * @param request oggetto con username e password
     * @return risposta con token jwt
     */
    @POST
    @Path("/")
    @PermitAll
    @Operation(summary = "Autenticazione", 
                description = "Permette di autenticarsi nel sistema, viene restituito un JWT. Risorsa disponibile a tutte le entità del sistema.")
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente",
                content = @Content( array = @ArraySchema(schema = @Schema(implementation = AuthResponseDTO.class))))
    @ApiResponse(responseCode = "400", description = "Parametri della richiesta non corretti")
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    public Response authenticate(final @Valid AuthRequestDTO request) {
        LOG.log(Level.INFO, "Authenticate user {0}", request.getUsername());

        CredentialValidationResult result = identityStoreHandler
                .validate(new UsernamePasswordCredential(request.getUsername(), request.getPassword()));

        if (result.getStatus() == CredentialValidationResult.Status.VALID) {
            try {
                String jwt = tokenProvider.createToken(result.getCallerPrincipal().getName(), result.getCallerGroups());
                AuthResponseDTO res = new AuthResponseDTO();
                res.setToken(jwt);
                return Response.status(Status.OK).header(AUTHORIZATION_HEADER, BEARER + jwt).entity(res).build();
            } catch (Exception e) {
                LOG.log(Level.INFO, "Token error: {0}", e);
                return Response.status(Status.UNAUTHORIZED).build();
            }
        } else {
            LOG.log(Level.WARNING, "Wrong credentials for user {0} or user not found", request.getUsername());
            return Response.status(Status.UNAUTHORIZED).build();
        }
    }

    /**
     * Refresh del JWT
     * @return
     */
    @PUT
    @Path("/refresh")
    @RolesAllowed({BANK, AIRLINE, USER})
    @Operation(summary = "Refresh JWT", 
                description = "Permette di richiedere un nuovo token utilizzando uno ancora non scaduto. Risorsa disponibile a tutte le entità del sistema.")
    @ApiResponse(responseCode = "200", description = "Richiesta elaborata correttamente",
                    content = @Content( array = @ArraySchema(schema = @Schema(implementation = AuthResponseDTO.class))))
    @ApiResponse(responseCode = "401", description = "Entità non autorizzta")
    public Response refresh() {

        String username  = securityContext.getCallerPrincipal().getName();
        LOG.log(Level.INFO, "Refresh user {0}", username);

        DomainEntity entity;
        try {
            entity = databaseManager.getEntity(username);
        } catch (EntityNotFoundException e1) {
            return Response.status(Status.UNAUTHORIZED).build();
        }

        CredentialValidationResult result = identityStoreHandler
                .validate(new UsernamePasswordCredential(entity.getUsername(), entity.getPassword()));

        if (result.getStatus() == CredentialValidationResult.Status.VALID) {
            try {
                String jwt = tokenProvider.createToken(result.getCallerPrincipal().getName(), result.getCallerGroups());
                AuthResponseDTO res = new AuthResponseDTO();
                res.setToken(jwt);
                return Response.status(Status.OK).header(AUTHORIZATION_HEADER, BEARER + jwt).entity(res).build();
            } catch (Exception e) {
                LOG.log(Level.INFO, "Token error: {0}", e);
                return Response.status(Status.UNAUTHORIZED).build();
            }
        } else {
            LOG.log(Level.WARNING, "Wrong credentials for user {0} or user not found", entity.getUsername());
            return Response.status(Status.UNAUTHORIZED).build();
        }
    }
}