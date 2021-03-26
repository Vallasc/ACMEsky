package it.unibo.soseng.model;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.persistence.*;

@Entity
@Table(name = "generated_offers")
public class GeneratedOffers implements Serializable {
    /**
    
    */
    private static final long serialVersionUID = 1L;
    private long id;
    private long outboundFlightId;
    private long flightBackId;
    private LocalDateTime expireDate;
    private double totalPrice;
    private boolean booked;

    @Id
    @Column(name = "id", 
            nullable = false,
             columnDefinition = "integer")
    public long getId() {
        return this.id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Column(name = "outbound_flight_id", 
            nullable = false, 
            columnDefinition = "integer")
    public long getOutboundFlightId() {
        return this.outboundFlightId;
    }

    public void setOutboundFlightId(long outboundFlightId) {
        this.outboundFlightId = outboundFlightId;
    }

    @Column(name = "flight_back_id", 
            nullable = true, 
            columnDefinition = "integer")
    public long getFlightBackId() {
        return this.flightBackId;
    }

    public void setFlightBackId(long flightBackId) {
        this.flightBackId = flightBackId;
    }

    @Column(name = "expire_date", 
            nullable = false, 
            columnDefinition = "DATETIME")
    public LocalDateTime getExpireDate() {
        return this.expireDate;
    }

    public void setExpireDate(LocalDateTime expireDate) {
        this.expireDate = expireDate;
    }

    @Column(name = "total_price", 
            nullable = true, 
            columnDefinition = "Decimal(10,2)")
    public double getTotalPrice() {
        return this.totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Column(name = "booked", 
            nullable = true, 
            columnDefinition = "boolean default false")
    public boolean getBooked() {
        return this.booked;
    }

    public void setBooked(boolean booked) {
        this.booked = booked;
    }
}
