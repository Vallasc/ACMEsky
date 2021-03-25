package it.unibo.soseng.security;

import java.util.Set;

import javax.security.enterprise.credential.Credential;

public class JWTCredential implements Credential {

    private final String principal;
    private final Set<String> authorities;

    public JWTCredential(String principal, Set<String> authorities) {
        this.principal = principal;
        this.authorities = authorities;
    }

    public String getPrincipal() {
        return principal;
    }

    public Set<String> getAuthorities() {
        return authorities;
    }

}