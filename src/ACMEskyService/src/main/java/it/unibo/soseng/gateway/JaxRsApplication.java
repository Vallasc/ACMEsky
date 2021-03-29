package it.unibo.soseng.gateway;

import static it.unibo.soseng.security.Constants.BANK;
import static it.unibo.soseng.security.Constants.AIRLINE;
import static it.unibo.soseng.security.Constants.USER;

import javax.annotation.security.DeclareRoles;
import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

@DeclareRoles({BANK, AIRLINE, USER})
@ApplicationPath("/")
public class JaxRsApplication extends Application {
    
}