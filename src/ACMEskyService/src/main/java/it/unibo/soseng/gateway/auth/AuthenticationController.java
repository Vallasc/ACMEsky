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

import it.unibo.soseng.gateway.auth.dto.AuthRequest;
import it.unibo.soseng.gateway.auth.dto.AuthResponse;
import it.unibo.soseng.logic.database.DatabaseManager;
import it.unibo.soseng.logic.database.DatabaseManager.EntityNotFoundException;
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

    @POST
    @Path("/")
    @PermitAll
    public Response authenticate(@Valid AuthRequest request) {
        LOG.log(Level.INFO, "Authenticate user {0}", request.getUsername());

        CredentialValidationResult result = identityStoreHandler
                .validate(new UsernamePasswordCredential(request.getUsername(), request.getPassword()));

        if (result.getStatus() == CredentialValidationResult.Status.VALID) {
            try {
                String jwt = tokenProvider.createToken(result.getCallerPrincipal().getName(), result.getCallerGroups());
                AuthResponse res = new AuthResponse();
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

    @PUT
    @Path("/refresh")
    @RolesAllowed({BANK, AIRLINE, USER})
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
                AuthResponse res = new AuthResponse();
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