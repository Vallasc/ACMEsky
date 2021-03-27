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
@Table(name = "generated_offers")
public class GeneratedOffers implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private long id;

    @Column(name = "outbound_flight_id", nullable = false)
    private long outboundFlightId;

    @Column(name = "flight_back_id", nullable = true)
    private long flightBackId;

    @Column(name = "expire_date", nullable = false)
    private ZonedDateTime expireDate;

    @Column(name = "total_price", nullable = true)
    private double totalPrice;

    @Column(name = "booked", nullable = true)
    private boolean booked;


    public long getId() {
        return this.id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getOutboundFlightId() {
        return this.outboundFlightId;
    }

    public void setOutboundFlightId(long outboundFlightId) {
        this.outboundFlightId = outboundFlightId;
    }

    public long getFlightBackId() {
        return this.flightBackId;
    }

    public void setFlightBackId(long flightBackId) {
        this.flightBackId = flightBackId;
    }

    public ZonedDateTime getExpireDate() {
        return this.expireDate;
    }

    public void setExpireDate(ZonedDateTime expireDate) {
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
}
