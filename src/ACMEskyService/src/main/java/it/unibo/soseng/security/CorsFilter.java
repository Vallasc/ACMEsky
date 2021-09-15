package it.unibo.soseng.security;

import java.io.IOException;

import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.container.ContainerResponseContext;
import javax.ws.rs.container.ContainerResponseFilter;
import javax.ws.rs.container.PreMatching;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.Provider;

/**
 * si occupa di aggiungere il filtro per il CORS
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Provider
@PreMatching
public class CorsFilter implements ContainerRequestFilter, ContainerResponseFilter {

    /**
     * 
     */
    @Override
    public void filter(ContainerRequestContext request) throws IOException {
        if (isPreflightRequest(request)) {
            request.abortWith(Response.ok().build());
            return;
        }
    }

    /**
     * A preflight request is an OPTIONS request with an Origin header.
     */
    private static boolean isPreflightRequest(ContainerRequestContext request) {
        return request.getHeaderString("Origin") != null && request.getMethod().equalsIgnoreCase("OPTIONS");
    }

    /**
     * aggiunge gli header richiesti dal CORS nelle risposte alle richieste HTTP dei
     * servizi esterni
     */
    @Override
    public void filter(ContainerRequestContext request, ContainerResponseContext response) throws IOException {

        if (request.getHeaderString("Origin") == null) {
            return;
        }

        if (isPreflightRequest(request)) {
            response.getHeaders().add("Access-Control-Allow-Credentials", "true");
            response.getHeaders().add("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD");
            response.getHeaders().add("Access-Control-Allow-Headers",
                    "X-Requested-With, Authorization, " + "Accept-Version, Content-MD5, CSRF-Token, Content-Type");
        }

        response.getHeaders().add("Access-Control-Allow-Origin", "*");
    }
}