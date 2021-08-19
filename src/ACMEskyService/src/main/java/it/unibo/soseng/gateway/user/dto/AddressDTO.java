package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

public class AddressDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String offerToken;
    private String postCode;
    private String address;
    private String cityName;
    private String country;

    public String getPostCode() {
        return postCode;
    }

    public String getOfferToken() {
        return offerToken;
    }

    public void setOfferToken(String offerToken) {
        this.offerToken = offerToken;
    }

    public String getCountry() {
        return country;
    }

    public String getCityName() {
        return cityName;
    }

    public String getAddress() {
        return address;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }
}
