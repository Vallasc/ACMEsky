package it.unibo.soseng.model;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "flights")
public class Flight implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private long id;

    @Column(name = "flight_code", nullable = false)
    private String flightCode;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "departure_airport_id", nullable = false)
    private Airport departureAirport;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "arrival_airport_id", nullable = false)
    private Airport arrivalAirport;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "airline_id", nullable = false)
    private Airline airline;

    @Column(name = "departure_date_time", columnDefinition = "TIMESTAMP WITH TIME ZONE", nullable = false)
    private OffsetDateTime departureDateTime;

    @Column(name = "arrival_date_time", columnDefinition = "TIMESTAMP WITH TIME ZONE", nullable = false)
    private OffsetDateTime arrivalDateTime;

    @Column(name = "expire_date", columnDefinition = "TIMESTAMP WITH TIME ZONE", nullable = false)
    private OffsetDateTime expireDate;

    @Column(name = "price", nullable = false)
    private float price;

    @Column(name = "booked", nullable = false)
    private boolean booked;

    @Column(name = "available", nullable = false)
    private boolean available;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFlightCode() {
        return flightCode;
    }

    public void setFlightCode(String flightCode) {
        this.flightCode = flightCode;
    }

    public Airport getDepartureAirport() {
        return departureAirport;
    }

    public void setDepartureAirport(Airport departureAirport) {
        this.departureAirport = departureAirport;
    }

    public Airport getArrivalAirport() {
        return arrivalAirport;
    }

    public void setArrivalAirport(Airport arrivalAirport) {
        this.arrivalAirport = arrivalAirport;
    }

    public Airline getAirlineId() {
        return airline;
    }

    public void setAirline(Airline airline) {
        this.airline = airline;
    }

    public OffsetDateTime getDepartureDateTime() {

        return departureDateTime;
    }

    public void setDepartureDateTime(OffsetDateTime departureTime) {
        this.departureDateTime = departureTime;
    }

    public OffsetDateTime getArrivalDateTime() {
        return arrivalDateTime;
    }

    public void setArrivalDateTime(OffsetDateTime arrivalTime) {
        this.arrivalDateTime = arrivalTime;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public OffsetDateTime getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(OffsetDateTime expireDate) {
        this.expireDate = expireDate;
    }

    public boolean getBooked() {
        return booked;
    }

    public void setBooked(boolean booked) {
        this.booked = booked;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    @Override
    public String toString() {
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
        return this.departureAirport.getCityName() + " (" + this.departureAirport.getAirportCode() + ") - "
                + this.arrivalAirport.getCityName() + " (" + this.arrivalAirport.getAirportCode() + ") "
                + fmt.format(this.departureDateTime);
    }
}
