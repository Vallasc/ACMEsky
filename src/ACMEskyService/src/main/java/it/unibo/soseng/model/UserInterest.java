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
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="users_interests")
public class UserInterest implements Serializable {

    private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
	private long id;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "user_id", nullable = false)
    private User user;

	@OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "outbound_flight_interest_id", nullable = false)
	private FlightInterest outboundFlightInterest;

	@OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "flight_back_interest_id", nullable = false)
    private FlightInterest flightBackInterest;

    @Column(name = "price_limit", nullable = false)
    private double priceLimit ;
	
    @Column(name = "expire_date", columnDefinition= "TIMESTAMP WITH TIME ZONE", nullable = false)
	private OffsetDateTime expireDate;
	
	@Column(name = "used", nullable = false)
    private boolean used ;

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public FlightInterest getOutboundFlightInterest() {
		return this.outboundFlightInterest;
	}

	public void setOutboundFlightInterest(FlightInterest outboundFlightInterest) {
		this.outboundFlightInterest = outboundFlightInterest;
	}
    
	public FlightInterest getFlightBackInterest() {
		return this.flightBackInterest;
	}

	public void setFlightBackInterest(FlightInterest flightBackInterest) {
		this.flightBackInterest = flightBackInterest;
	}
    
	public OffsetDateTime getExpireDate() {
		return this.expireDate;
	}
	
	public void setExpireDate(OffsetDateTime expireDate) {
		this.expireDate = expireDate;
	}

	public double getPriceLimit() {
		return this.priceLimit;
	}

	public void setPriceLimit(double priceLimit) {
		this.priceLimit = priceLimit;
	}

	public boolean getUsed() {
		return this.used;
	}

	public void setUsed(boolean used) {
		this.used = used;
	}
}