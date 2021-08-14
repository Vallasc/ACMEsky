package it.unibo.soseng.model;

import java.io.Serializable;
import java.time.OffsetDateTime;

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
@Table(name = "generated_offers")
public class GeneratedOffer implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private long id;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "outbound_flight_id", nullable = false)
    private Flight outboundFlight;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "flight_back_id", nullable = false)
    private Flight flightBack;

    @Column(name = "expire_date", columnDefinition= "TIMESTAMP WITH TIME ZONE", nullable = false)
    private OffsetDateTime expireDate;

    @Column(name = "total_price", nullable = true)
    private double totalPrice;

    @Column(name = "booked", nullable = true)
    private boolean booked;

    @Column(name = "available", nullable = true)
    private boolean available;

    @Column(name = "token", nullable = true)
    private String token;

    @ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "user_id", nullable = false)
    private User user;

    public User getUser() {
        return this.user;
    }

    public void setUser(User user) {
        this.user = user;
    }


    public long getId() {
        return this.id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Flight getOutboundFlight() {
        return this.outboundFlight;
    }

    public void setOutboundFlight(Flight outboundFlight) {
        this.outboundFlight = outboundFlight;
    }

    public Flight getFlightBack() {
        return this.flightBack;
    }

    public void setFlightBack(Flight flightBack) {
        this.flightBack = flightBack;
    }

    public OffsetDateTime getExpireDate() {
        return this.expireDate;
    }

    public void setExpireDate(OffsetDateTime expireDate) {
        this.expireDate = expireDate;
    }

    public double getTotalPrice() {
        return this.totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public boolean getBooked() {
        return this.booked;
    }

    public void setBooked(boolean booked) {
        this.booked = booked;
    }

    public boolean getAvailable() {
        return this.available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public String getToken() {
        return this.token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
