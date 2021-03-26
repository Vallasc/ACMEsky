package it.unibo.soseng.model;
import java.io.Serializable;
import javax.persistence.*;
import org.joda.time.DateTime;

@Entity
@Table(name="flights_interest")
public class FlightInterest implements Serializable {
       /**

     */
    private static final long serialVersionUID = 1L;
    private long id;
    private long userId;
	private long departureAirportId ;
    private long arrivalAirportId;
    private DateTime departureDateTime;
    private DateTime arrivalDateTime;

	@Id
	@Column(name="flight_interest_id",nullable=false,columnDefinition="integer")
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

	@Column(name="departure_airport_id ",nullable=false,columnDefinition="integer")
	public long getDepartureAirportId() {
		return this.departureAirportId;
	}
	public void setDepartureAirportId(long departureAirportId) {
		this.departureAirportId = departureAirportId;
	}

    @Column(name="arrival_airport_id",nullable=false,columnDefinition="integer")
	public long getArrivalAirportId() {
		return this.arrivalAirportId;
	}
	public void setArrivalAirportId(long arrivalAirportId) {
		this.arrivalAirportId = arrivalAirportId;
	}
    
    @Column(name="departure_date_time",nullable=true,columnDefinition="DATETIME")
	public DateTime getDepartureDateTime() {
		return this.departureDateTime;
	}
	public void setDepartureDateTime(DateTime departureDateTime) {
		this.departureDateTime = departureDateTime;
	}
    
    @Column(name="arrival_date_time",nullable=true,columnDefinition="DATETIME")
	public DateTime getArrivalDateTime() {
		return this.arrivalDateTime;
	}
	public void setArrivalDateTime(DateTime arrivalDateTime) {
		this.arrivalDateTime = arrivalDateTime;
	}
}