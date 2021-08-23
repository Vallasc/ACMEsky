package it.unibo.soseng.gateway.airline.dto;

import java.io.Serializable;
import java.time.OffsetDateTime;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class AirlineFlightOfferDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;
    private String departureCode;
    private String departureTime;
    private String arrivalTime;
    private String arrivalCode;
    private String expDate;
    private String airlineName;
    private float price;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getExpDate() {
        return expDate;
    }

    public void setExpDate(String expDate) {
        this.expDate = expDate;
    }

    public String getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(String arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public String getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(String departureTime) {
        this.departureTime = departureTime;
    }

    public String getArrivalCode() {
        return arrivalCode;
    }

    public void setArrivalCode(String arrivalCode) {
        this.arrivalCode = arrivalCode;
    }

    public String getDepartureCode() {
        return departureCode;
    }

    public void setDepartureAirportCode(String departureCode) {
        this.departureCode = departureCode;
    }

    public String getAirlineName() {
        return this.airlineName;
    }

    public void setAirlinename(String airline_id) {
        this.airlineName = airline_id;
    }

    @JsonIgnore
    public OffsetDateTime getDepartureOffsetDateTime() {
        return OffsetDateTime.parse(this.departureTime);
    }

    @JsonIgnore
    public OffsetDateTime getArrivalOffsetDateTime() {
        return OffsetDateTime.parse(this.arrivalTime);
    }

    @JsonIgnore
    public OffsetDateTime getExpiredOffsetDateTime() {
        return OffsetDateTime.parse(this.expDate);
    }

}
