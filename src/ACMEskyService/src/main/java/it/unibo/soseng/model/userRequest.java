package it.unibo.soseng.model;

import java.io.Serializable;
import java.time.ZonedDateTime;

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
@Table(name="users_request")
public class UserRequest implements Serializable {

    private static final long serialVersionUID = 1L;

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private long id;

	@ManyToOne
	@JoinColumn(name = "user_id", nullable = false)
    private User user;

	@OneToOne
    @JoinColumn(name = "outbound_flight_interest_id", nullable = false)
	private FlightInterest outboundFlightInterest;

	@OneToOne
    @JoinColumn(name = "flight_back_interest_id", nullable = true)
    private FlightInterest flightBackInterest;

    @Column(name = "expire_date", nullable = true)
	private ZonedDateTime expireDate;
	

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
    
	public ZonedDateTime getExpireDate() {
		return this.expireDate;
	}
	
	public void setgetExpireDate(ZonedDateTime expireDate) {
		this.expireDate = expireDate;
	}
}