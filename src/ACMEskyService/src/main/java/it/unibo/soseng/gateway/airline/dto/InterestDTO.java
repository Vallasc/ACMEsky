package it.unibo.soseng.gateway.airline.dto;

import java.io.Serializable;
import java.time.OffsetDateTime;
import java.time.OffsetDateTime;

public class InterestDTO implements Serializable{

    private static final long serialVersionUID = 1L;
    
    private String Departure;
    private String Arrival;
    private OffsetDateTime depDateTime;
    private OffsetDateTime arrDateTime;


    public InterestDTO(String departure, String arrival, OffsetDateTime departureDateTime,
            OffsetDateTime arrivalDateTime) {
        this.Departure=departure;
        this.Arrival=arrival;
        this.depDateTime=departureDateTime;
        this.arrDateTime=arrivalDateTime;
    }

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

    public OffsetDateTime getDepDateTime() {
        return depDateTime;
    }

    public void setDepDateTime(OffsetDateTime depDateTime) {
        this.depDateTime = depDateTime;
    }

    public OffsetDateTime getArrDateTime() {
        return arrDateTime;
    }
    
    public void setArrDateTime(OffsetDateTime arrDateTime) {
        this.arrDateTime = arrDateTime;
    }
    
}
