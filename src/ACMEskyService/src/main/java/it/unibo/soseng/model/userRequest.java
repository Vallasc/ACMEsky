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
@Table(name="users_request")
public class UserRequest implements Serializable {

    private static final long serialVersionUID = 1L;

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private long id;

	@Column(name = "user_id", nullable = false)
    private long userId;

    @Column(name = "outbound_flight_interest_id", nullable = false)
	private long outboundFlightInterestId;

    @Column(name = "flight_back_interest_id", nullable = true)
    private long flightBackInterestId;

    @Column(name = "expire_date", nullable = true)
	private ZonedDateTime expireDate;
	

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getUserId() {
		return this.userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getOutboundFlightInterestId() {
		return this.outboundFlightInterestId;
	}

	public void setOutboundFlightInterestId(long outboundFlightInterestId) {
		this.outboundFlightInterestId = outboundFlightInterestId;
	}
    
	public long getFlightBackInterestId() {
		return this.flightBackInterestId;
	}

	public void setFlightBackInterestId(long flightBackInterestId) {
		this.flightBackInterestId = flightBackInterestId;
	}
    
	public ZonedDateTime getExpireDate() {
		return this.expireDate;
	}
	
	public void setgetExpireDate(ZonedDateTime expireDate) {
		this.expireDate = expireDate;
	}
}