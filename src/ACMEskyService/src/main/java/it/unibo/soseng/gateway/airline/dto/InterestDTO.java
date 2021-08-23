package it.unibo.soseng.gateway.airline.dto;

import java.io.Serializable;
import java.time.OffsetDateTime;

public class InterestDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    public String departure;
    public String arrival;
    public String departureDate;

    public InterestDTO(String departure, String arrival, String departureDateTime) {
        this.departure = departure;
        this.arrival = arrival;
        this.departureDate = departureDateTime;
    }

}
