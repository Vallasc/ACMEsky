package it.unibo.soseng.gateway.bank;

import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import it.unibo.soseng.logic.bank.BankManager;

import java.util.logging.Logger;

import static it.unibo.soseng.security.Constants.BANK;

@Path("banks")
@RolesAllowed({BANK})
@Produces( MediaType.APPLICATION_JSON )
public class BankController {
    private final static Logger LOGGER = Logger.getLogger(BankController.class.getName());

    @Inject
    BankManager bankManager;

    @GET
    @PermitAll
    @Path("/confirmPayment")
    public Response confirmPayment(@QueryParam("code") String code) {
        LOGGER.info("GET confirmPayment");
        LOGGER.info("code "+code);
        bankManager.paymentSuccess(code);
        return Response.status(Response.Status.OK.getStatusCode()).build();
    }
}