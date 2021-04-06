package it.unibo.soseng.gateway.airline.dto;

import java.io.Serializable;
import java.time.ZonedDateTime;

public class InterestDTO implements Serializable{

    private static final long serialVersionUID = 1L;
    
    private String Departure;
    private String Arrival;
    private ZonedDateTime depDateTime;
    private ZonedDateTime arrDateTime;


    public String getDeparture() {
        return Departure;
    }

    public void setDeparture(String departure) {
        Departure = departure;
    }

    public String getArrival() {
        return Arrival;
    }

    public void setArrival(String arrival) {
        Arrival = arrival;
    }

    public ZonedDateTime getDepDateTime() {
        return depDateTime;
    }

    public void setDepDateTime(ZonedDateTime depDateTime) {
        this.depDateTime = depDateTime;
    }

    public ZonedDateTime getArrDateTime() {
        return arrDateTime;
    }
    
    public void setArrDateTime(ZonedDateTime arrDateTime) {
        this.arrDateTime = arrDateTime;
    }
    
}
