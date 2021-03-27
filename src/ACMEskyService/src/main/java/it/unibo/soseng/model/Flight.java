package it.unibo.soseng.model;

import java.io.Serializable;
import java.time.ZonedDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="flights")
public class Flight implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private long id;

    @Column(name = "departure_airport_id", nullable = false)
    private long departureAirportId;

    @Column(name = "arrival_airport_id", nullable = false)
    private long arrivalAirportId;

    @Column(name = "airline_id", nullable = false)
    private long airlineId;

    @Column(name = "departure_date_time", nullable = false)
    private ZonedDateTime departureDateTime;
    
    @Column(name = "arrival_date_time",  nullable = false)
    private ZonedDateTime arrivalDateTime;

    @Column(name = "expire_date", nullable = false)
    private ZonedDateTime expireDate;

    @Column(name = "price", nullable = false)
    private float price;

    @Column(name = "booked", nullable = false)
    private boolean booked;


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
    
    public ZonedDateTime getDepartureDateTime() {
        return departureDateTime;
    }

    public void setDepartureDateTime(ZonedDateTime departureDateTime) {
        this.departureDateTime = departureDateTime;
    }
    
    public ZonedDateTime getArrivalDateTime() {
        return arrivalDateTime;
    }

    public void setArrivalDateTime(ZonedDateTime arrivalDateTime) {
        this.arrivalDateTime = arrivalDateTime;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public ZonedDateTime getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(ZonedDateTime expireDate) {
        this.expireDate = expireDate;
    }

    public boolean getBooked() {
        return booked;
    }

    public void setBooked(boolean booked) {
        this.booked = booked;
    }
}