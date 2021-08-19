package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

public class UserOfferDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "Token cannot be null")
    private String offerToken;
 
    public void setOfferToken (String offerToken) {
        this.offerToken = offerToken;
    }

    public String getOfferToken () {
        return this.offerToken;
    }

}
