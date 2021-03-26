package it.unibo.soseng.model;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="flights")
public class Flight {

    private long id;
    private long departureAirportId;
    private long arrivalAirportId;
    private long airlineId;
    /*
    private LocalDateTime departure_date_time;
    private LocalDateTime arrival_date_time;
    private float price;
    private LocalDateTime expire_date;
    private boolean booked;*/

    @Id
    @Column(name = "id", 
            nullable = false, 
            columnDefinition = "integer")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getDepartureAirportId() {
        return departureAirportId;
    }

    public void setDepartureAirportId(long departureAirportId) {
        this.departureAirportId = departureAirportId;
    }

    public long getArrivalAirportId() {
        return arrivalAirportId;
    }

    public void setArrivalAirportId(long arrivalAirportId) {
        this.arrivalAirportId = arrivalAirportId;
    }
    
    public long getAirlineId() {
        return airlineId;
    }

    public void setAirlineId(long airlineId) {
        this.airlineId = airlineId;
    }

    
}