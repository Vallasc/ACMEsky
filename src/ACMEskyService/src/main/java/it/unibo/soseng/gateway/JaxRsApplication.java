package it.unibo.soseng.gateway;

import static it.unibo.soseng.security.Constants.BANK;
import static it.unibo.soseng.security.Constants.AIRLINE;
import static it.unibo.soseng.security.Constants.USER;

import javax.annotation.security.DeclareRoles;
import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import io.swagger.v3.oas.annotations.servers.Server;
import io.swagger.v3.oas.annotations.enums.*;

@OpenAPIDefinition(
        info = @Info(
                title = "ACMEsky service",
                version = "1.0",
                description = "ACMEskyService è il servizio principale di ACMEsky che si relaziona con gli altri "+
                "(ACMEskyWeb, AirlineServices, RentServices, Prontogram, BankService,...) al fine di consentire agli "+
                "utenti di prenotare ed acquistare le offerte di voli che desiderano. "+
                "Prima di fare richieste alle risorse che richiedono l'autenticazione i servizi devono autenticarsi effettuando "+
                "una richiesta POST ad '/auth' con username e password. Il token JWT ricevuto deve essere accompagnare ogni "+
                "che viene fatta al servizio. A seconda del servizio i path a cui potrà accedere saranno differenti."
        ),
        servers = { @Server(url = "http://acmesky.duckdns.org:8080")}
)
@SecurityScheme(
    name = "bearerAuth",
    type = SecuritySchemeType.HTTP,
    bearerFormat = "JWT",
    scheme = "bearer"
)
@DeclareRoles({BANK, AIRLINE, USER})
@ApplicationPath("/")
public class JaxRsApplication extends Application {
}