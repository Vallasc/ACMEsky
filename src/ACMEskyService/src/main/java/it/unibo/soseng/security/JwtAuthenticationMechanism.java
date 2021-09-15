package it.unibo.soseng.security;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.security.enterprise.AuthenticationStatus;
import javax.security.enterprise.authentication.mechanism.http.HttpAuthenticationMechanism;

import static it.unibo.soseng.security.Constants.AUTHORIZATION_HEADER;
import static it.unibo.soseng.security.Constants.BEARER;
import io.jsonwebtoken.ExpiredJwtException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.security.enterprise.authentication.mechanism.http.HttpMessageContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * gestisce l'autenticazione degli utenti e dei servizi esterni mediante il
 * token jwt
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@RequestScoped
public class JwtAuthenticationMechanism implements HttpAuthenticationMechanism {

    private static final Logger LOGGER = Logger.getLogger(JwtAuthenticationMechanism.class.getName());

    @Inject
    private TokenProvider tokenProvider;

    /**
     * si occupa di validare le richieste in base al token contenuto nel campo
     * Authorization dell'header
     */
    @Override
    public AuthenticationStatus validateRequest(HttpServletRequest request, HttpServletResponse response,
            HttpMessageContext context) {

        LOGGER.log(Level.INFO, "validateRequest: {0}", request.getRequestURI());

        String token = extractToken(context);

        if (token != null) {
            return validateToken(token, context);
        } else if (context.isProtected()) {
            return context.responseUnauthorized();
        }
        return context.doNothing();
    }

    /**
     * To validate the JWT token e.g Signature check, JWT claims check(expiration)
     * etc
     *
     * @param token   The JWT access tokens
     * @param context
     * @return the AuthenticationStatus to notify the container
     */
    private AuthenticationStatus validateToken(String token, HttpMessageContext context) {
        LOGGER.log(Level.INFO, "token: {0}", token);
        try {
            if (tokenProvider.validateToken(token)) {
                JwtCredential credential = tokenProvider.getCredential(token);
                LOGGER.log(Level.INFO, "Username: {0} - ROLE: {1}",
                        new String[] { credential.getPrincipal(), (String) credential.getAuthorities().toArray()[0] });
                return context.notifyContainerAboutLogin(credential.getPrincipal(), credential.getAuthorities());
            }
            // if token invalid, response with unauthorized status
            return context.responseUnauthorized();
        } catch (ExpiredJwtException eje) {
            LOGGER.log(Level.INFO, "Security exception for user {0} - {1}",
                    new String[] { eje.getClaims().getSubject(), eje.getMessage() });
            return context.responseUnauthorized();
        }
    }

    /**
     * To extract the JWT from Authorization HTTP header
     *
     * @param context
     * @return The JWT access tokens
     */
    private String extractToken(HttpMessageContext context) {
        String authorizationHeader = context.getRequest().getHeader(AUTHORIZATION_HEADER);
        if (authorizationHeader != null && authorizationHeader.startsWith(BEARER)) {
            String token = authorizationHeader.substring(BEARER.length(), authorizationHeader.length());
            return token;
        }
        return null;
    }

}