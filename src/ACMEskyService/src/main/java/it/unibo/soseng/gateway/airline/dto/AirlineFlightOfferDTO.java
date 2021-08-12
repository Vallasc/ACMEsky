package it.unibo.soseng.gateway.airline.dto;

import java.io.Serializable;
import java.time.OffsetDateTime;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class AirlineFlightOfferDTO implements Serializable {
    
    private static final long serialVersionUID = 1L;

    private String flightCode;
    private String departureAirportCode;
    private String arrivalAirportCode;
    private String departureTimestamp;
    private String arrivalTimestamp;
    private String expireTimestamp;
    private float price;
    private String airlineName;

    public String getFlightCode() {
        return flightCode;
    }

    public void setFlightCode(String flightCode) {
        this.flightCode = flightCode;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getExpireTimestamp() {
        return expireTimestamp;
    }

    public void setExpireTimestamp(String expireTimestamp) {
        this.expireTimestamp = expireTimestamp;
    }

    public String getArrivalTimestamp() {
        return arrivalTimestamp;
    }

    public void setArrivalTimestamp(String arrivalTimestamp) {
        this.arrivalTimestamp = arrivalTimestamp;
    }

    public String getDepartureTimestamp() {
        return departureTimestamp;
    }

    public void setDepartureTimestamp(String departureTimestamp) {
        this.departureTimestamp = departureTimestamp;
    }

    public String getArrivalAirportCode() {
        return arrivalAirportCode;
    }

    public void setArrivalAirportCode(String arrivalAirportCode) {
        this.arrivalAirportCode = arrivalAirportCode;
    }

    public String getDepartureAirportCode() {
        return departureAirportCode;
    }

    public void setDepartureAirportCode(String departureAirportCode) {
        this.departureAirportCode = departureAirportCode;
    }

    public String getAirlineName() {
        return this.airlineName;
    }

    public void setAirlinename(String airlineName) {
        this.airlineName = airlineName;
    }

    @JsonIgnore
    public OffsetDateTime getDepartureOffsetDateTime () {
        return OffsetDateTime.parse(this.departureTimestamp); 
    }

    @JsonIgnore
    public OffsetDateTime getArrivalOffsetDateTime () {
        return OffsetDateTime.parse(this.arrivalTimestamp); 
    }

    @JsonIgnore
    public OffsetDateTime getExpiredOffsetDateTime () {
        return OffsetDateTime.parse(this.expireTimestamp); 
    }

}
