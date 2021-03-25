package it.unibo.soseng.security;

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

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

public class TokenProvider {

    private static final Logger LOGGER = Logger.getLogger(TokenProvider.class.getName());

    private static final String AUTHORITIES_KEY = "auth";

    private SecretKey secretKey;
    private long tokenValidity;

    @PostConstruct
    public void init() {
        //this.secretKey = Keys.secretKeyFor(SignatureAlgorithm.HS512);
        this.secretKey = Keys.hmacShaKeyFor("chiavesegreta".getBytes(StandardCharsets.UTF_8));
        this.tokenValidity = TimeUnit.MINUTES.toMillis(10); 
    }

    public String createToken(String username, Set<String> authorities) {
        long now = (new Date()).getTime();

        return Jwts.builder()
                .setSubject(username)
                .claim(AUTHORITIES_KEY, authorities.stream().collect(joining(",")))
                .signWith(secretKey)
                .setExpiration(new Date(now + this.tokenValidity))
                .compact();
    }

    public JWTCredential getCredential(String token) {
        Claims claims = Jwts.parserBuilder()
                            .setSigningKey(secretKey)
                            .build()
                            .parseClaimsJws(token)
                            .getBody();

        Set<String> authorities = Arrays.asList(claims.get(AUTHORITIES_KEY).toString().split(","))
                                        .stream()
                                        .collect(Collectors.toSet());

        return new JWTCredential(claims.getSubject(), authorities);
    }

    public boolean validateToken(String authToken) {
        try {
            Jwts.parserBuilder()
                .setSigningKey(secretKey)
                .build()
                .parseClaimsJws(authToken);
            return true;
        } catch (JwtException e) {
            LOGGER.log(Level.INFO, "Invalid JWT signature: {0}", e.getMessage());
            return false;
        }
    }
}