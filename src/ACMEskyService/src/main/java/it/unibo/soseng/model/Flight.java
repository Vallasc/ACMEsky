package it.unibo.soseng.model;

import java.io.Serializable;

import javax.persistence.Entity;

public class Flight implements Serializable {
    
    private static final long serialVersionUID = 1L;

    private String flightId;

    public Flight(){}

    public Flight(String flightId){
        this.flightId = flightId;
    }
    
    public void setFlightId(String flightId) {
        this.flightId = flightId;
    }

    public String getFlightId() {
        return flightId;
    }
}