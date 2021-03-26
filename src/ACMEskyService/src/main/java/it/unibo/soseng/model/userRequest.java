package it.unibo.soseng.model;
import java.io.Serializable;
import javax.persistence.*;
import org.joda.time.DateTime;

@Entity
@Table(name="users_request")
public class UserRequest implements Serializable {
    /**
     *
     */
    private static final long serialVersionUID = 1L;
    private long id;
    private long userId;
	private long outboundFlightInterestId;
    private long flightBackInterestId;
	private DateTime expireDate;
	
	@Id
	@Column(name="user_request_id",nullable=false,columnDefinition="integer")
	public long getId() {
		return this.id;
	}
	public void setId(long id) {
		this.id = id;
	}

	@Column(name="user_id",nullable=false,columnDefinition="integer")
	public long getUserId() {
		return this.userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}

    @Column(name="outbound_flight_interest_id",nullable=false,columnDefinition="integer")
	public long getOutboundFlightInterestId() {
		return this.outboundFlightInterestId;
	}
	public void setOutboundFlightInterestId(long outboundFlightInterestId) {
		this.outboundFlightInterestId = outboundFlightInterestId;
	}
    
    @Column(name="flight_back_interest_id",nullable=true,columnDefinition="integer")
	public long getFlightBackInterestId() {
		return this.flightBackInterestId;
	}
	public void setFlightBackInterestId(long flightBackInterestId) {
		this.flightBackInterestId = flightBackInterestId;
	}
    
    @Column(name="expire_date",nullable=true,columnDefinition="DATETIME")
	public DateTime getExpireDate() {
		return this.expireDate;
	}
	public void setgetExpireDate(DateTime expireDate) {
		this.expireDate = expireDate;
	}
}