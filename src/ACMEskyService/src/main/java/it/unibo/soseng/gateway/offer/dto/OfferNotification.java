package it.unibo.soseng.gateway.offer.dto;

import java.io.Serializable;

public class OfferNotification implements Serializable {
    private static final long serialVersionUID = 1L;

    private String flyToken;
    private String flyCompany;
    private String userId;
    private int flyNumber;

    public void setFlyToken (String flyToken) {
        this.flyToken = flyToken;
    }

    public String getFlyToken () {
        return this.flyToken;
    }

    public void setFlyCompany (String flyCompany) {
        this.flyCompany = flyCompany;
    }

    public String getFlyCompany() {
        return this.flyCompany;
    }

    public void setUserId (String userId) {
        this.userId = userId;
    }

    public String getUserId () {
        return this.userId;
    }

    public void setFlyNumber (int flyNumber) {
        this.flyNumber = flyNumber;
    }

    public int getFlyNumber () {
        return this.flyNumber;
    }
}

