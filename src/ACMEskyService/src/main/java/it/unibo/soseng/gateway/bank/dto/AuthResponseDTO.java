package it.unibo.soseng.gateway.bank.dto;

import java.io.Serializable;

public class AuthResponseDTO implements Serializable {
    
    private String jwtToken;

    public String getJwtToken() {
        return jwtToken;
    }

    public void setJwtToken(String jwtToken) {
        this.jwtToken = jwtToken;
    }

}
