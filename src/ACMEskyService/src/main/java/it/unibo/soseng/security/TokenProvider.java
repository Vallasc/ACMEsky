package it.unibo.soseng.security;

import static it.unibo.soseng.security.Constants.JWT_KEY;
import java.util.Arrays;
import java.util.Date;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import static java.util.stream.Collectors.joining;

import java.nio.charset.StandardCharsets;

import javax.annotation.PostConstruct;
import javax.crypto.SecretKey;
import javax.ejb.Stateless;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import it.unibo.soseng.utils.Env;

/**
 * fornisce i token ai servizi che si sono autenticati correttamente
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Stateless
public class TokenProvider {

    private static final Logger LOGGER = Logger.getLogger(TokenProvider.class.getName());

    private static final String AUTHORITIES_KEY = "auth";

    private SecretKey secretKey;
    private long tokenValidity;

    /**
     * impostazione della chiave per criptare le info contenute nel token e la sua
     * validità in termini di tempo
     */
    @PostConstruct
    public void init() {
        // this.secretKey = Keys.secretKeyFor(SignatureAlgorithm.HS512);
        this.secretKey = Keys.hmacShaKeyFor(JWT_KEY.getBytes(StandardCharsets.UTF_8));
        this.tokenValidity = TimeUnit.HOURS.toMillis(Env.TOKEN_VALIDITY);
    }

    /**
     * genera il token jwt
     */
    public String createToken(String username, Set<String> authorities) {
        long now = (new Date()).getTime();

        return Jwts.builder().setSubject(username).claim(AUTHORITIES_KEY, authorities.stream().collect(joining(",")))
                .signWith(secretKey).setExpiration(new Date(now + this.tokenValidity)).compact();
    }

    /**
     * decodifica il token per prendere le credenziali del servizio ivi contenute
     * 
     * @param token
     * @return
     */
    public JwtCredential getCredential(String token) {
        Claims claims = Jwts.parserBuilder().setSigningKey(secretKey).build().parseClaimsJws(token).getBody();

        Set<String> authorities = Arrays.asList(claims.get(AUTHORITIES_KEY).toString().split(",")).stream()
                .collect(Collectors.toSet());

        return new JwtCredential(claims.getSubject(), authorities);
    }

    /**
     * stabilisce se il token è valido o no
     */
    public boolean validateToken(String authToken) {
        try {
            Jwts.parserBuilder().setSigningKey(secretKey).build().parseClaimsJws(authToken);
            return true;
        } catch (JwtException e) {
            LOGGER.log(Level.INFO, "Invalid JWT signature: {0}", e.getMessage());
            return false;
        }
    }
}