package it.unibo.soseng.gateway.prontogram.dto;

import java.io.Serializable;

import it.unibo.soseng.model.Flight;

public class Notification implements Serializable {
    private static final long serialVersionUID = 1L;

    private String offerToken;
    private Flight flyOutBound;
    private Flight flyBack;
    private String username;

    public void setOfferToken (String offerToken) {
        this.offerToken = offerToken;
    }

    public String getOfferToken() {
        return this.offerToken;
    }

    public void setFlyOutBound (Flight flyOutBound) {
        this.flyOutBound = flyOutBound;
    }

    public Flight getFlyOutBound() {
        return this.flyOutBound;
    }

    public void setFlyBack (Flight flyBack) {
        this.flyBack = flyBack;
    }

    public Flight getFlyCompany() {
        return this.flyBack;
    }

    public void setUsername (String username) {
        this.username = username;
    }

    public String getUsername () {
        return this.username;
    }
}

