package it.unibo.soseng.gateway.auth;

import static it.unibo.soseng.security.Constants.AUTHORIZATION_HEADER;
import static it.unibo.soseng.security.Constants.BEARER;

import javax.inject.Inject;
import javax.security.enterprise.identitystore.CredentialValidationResult;
import javax.security.enterprise.identitystore.IdentityStoreHandler;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.security.enterprise.credential.UsernamePasswordCredential;

import it.unibo.soseng.gateway.auth.dto.AuthRequest;
import it.unibo.soseng.security.TokenProvider;

import java.util.logging.Level;
import java.util.logging.Logger;

@Path("auth")
@Consumes({ MediaType.APPLICATION_JSON })
@Produces({ MediaType.APPLICATION_JSON })
public class AuthenticationController {

private static final Logger LOG = Logger.getLogger(AuthenticationController.class.getName());
    @Inject
    private IdentityStoreHandler identityStoreHandler;

    @Inject
    private TokenProvider tokenProvider;

    @POST
    public Response authenticate(@Valid AuthRequest request) {
      LOG.log(Level.INFO, "Authenticate user {0}", request.getUsername());

      CredentialValidationResult result = identityStoreHandler.validate(new UsernamePasswordCredential(request.getUsername(), request.getPassword()));
  
      if (result.getStatus() == CredentialValidationResult.Status.VALID) {
        try{
          String jwt = tokenProvider.createToken(result.getCallerPrincipal().getName(), result.getCallerGroups());

          return Response.status(Status.OK)
              .header(AUTHORIZATION_HEADER, BEARER + jwt)
              .build();
        } catch (Exception e) {
          LOG.log(Level.INFO, "Token error: {0}", e);
          return Response.status(Status.UNAUTHORIZED).build();
        }
      } else {
        LOG.log(Level.WARNING, "Wrong credentials for user {0} or user not found", request.getUsername());
        return Response.status(Status.UNAUTHORIZED).build();
      }
    }

}