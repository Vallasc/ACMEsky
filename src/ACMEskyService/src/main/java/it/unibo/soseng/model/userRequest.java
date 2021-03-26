package it.unibo.soseng.model;
import java.io.Serializable;
import java.lang.String;
import javax.persistence.*;
import org.joda.time.DateTime;

@Entity
@Table(name="USER_REQUESTS_TABLE")
public class userRequest implements Serializable {
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
	@Column(name="USER_REQUEST_ID",nullable=false,columnDefinition="integer")
	public long getId() {
		return this.id;
	}
	public void setId(long id) {
		this.id = id;
	}

	@Column(name="USER_ID",nullable=false,columnDefinition="integer")
	public long getUserId() {
		return this.userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}

    @Column(name="OUTBOUND_FLIGHT_INTEREST_ID",nullable=false,columnDefinition="integer")
	public long getOutboundFlightInterestId() {
		return this.outboundFlightInterestId;
	}
	public void setOutboundFlightInterestId(long outboundFlightInterestId) {
		this.outboundFlightInterestId = outboundFlightInterestId;
	}
    
    @Column(name="FLIGHT_BACK_INTEREST_ID",nullable=true,columnDefinition="integer")
	public long getFlightBackInterestId() {
		return this.flightBackInterestId;
	}
	public void setFlightBackInterestId(long flightBackInterestId) {
		this.flightBackInterestId = flightBackInterestId;
	}
    
    @Column(name="EXPIRE_DATE",nullable=true,columnDefinition="DATETIME")
	public DateTime getExpireDate() {
		return this.expireDate;
	}
	public void setgetExpireDate(DateTime expireDate) {
		this.expireDate = expireDate;
	}
}