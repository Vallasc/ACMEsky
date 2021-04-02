package it.unibo.soseng.model;

import java.io.Serializable;
import java.time.ZonedDateTime;
import java.util.UUID;

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

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="users_interests")
public class UserInterest implements Serializable {

    private static final long serialVersionUID = 1L;

	@Id
    @GeneratedValue(generator = "UUID")
	@GenericGenerator(name = "UUID", strategy = "org.hibernate.id.UUIDGenerator")
    @Column(name = "id", nullable = false)
    private UUID id;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "user_id")
    private User user;

	@OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "outbound_flight_interest_id")
	private FlightInterest outboundFlightInterest;

	@OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "flight_back_interest_id")
    private FlightInterest flightBackInterest;

    @Column(name = "expire_date", nullable = true)
	private ZonedDateTime expireDate;
	

	public UUID getId() {
		return this.id;
	}

	public void setId(UUID id) {
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
    
	public ZonedDateTime getExpireDate() {
		return this.expireDate;
	}
	
	public void setgetExpireDate(ZonedDateTime expireDate) {
		this.expireDate = expireDate;
	}
}