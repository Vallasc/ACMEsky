package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

public class UserOfferDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private String token;
 
    public void setToken (String token) {
        this.token = token;
    }

    public String getToken () {
        return this.token;
    }

}
