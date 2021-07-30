package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

public class UserOfferDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "Token cannot be null")
    private String token;
 
    public void setToken (String token) {
        this.token = token;
    }

    public String getToken () {
        return this.token;
    }

}
