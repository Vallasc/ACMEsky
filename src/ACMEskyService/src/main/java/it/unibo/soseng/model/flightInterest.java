package it.unibo.soseng.model;

import java.time.ZonedDateTime;
import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="flights_interest")
public class FlightInterest implements Serializable {

    private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
    private long id;

	@Column(name = "user_id", nullable = false)
    private long userId;

	@Column(name = "departure_airport_id", nullable = false)
	private long departureAirportId ;

	@Column(name = "arrival_airport_id", nullable = false)
    private long arrivalAirportId;

	@Column(name = "departure_date_time", nullable = false)
    private ZonedDateTime departureDateTime;

	@Column(name = "arrival_date_time", nullable = false)
    private ZonedDateTime arrivalDateTime;


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

	public long getDepartureAirportId() {
		return this.departureAirportId;
	}

	public void setDepartureAirportId(long departureAirportId) {
		this.departureAirportId = departureAirportId;
	}

	public long getArrivalAirportId() {
		return this.arrivalAirportId;
	}

	public void setArrivalAirportId(long arrivalAirportId) {
		this.arrivalAirportId = arrivalAirportId;
	}
    
	public ZonedDateTime getDepartureDateTime() {
		return this.departureDateTime;
	}

	public void setDepartureDateTime(ZonedDateTime departureDateTime) {
		this.departureDateTime = departureDateTime;
	}
    
	public ZonedDateTime getArrivalDateTime() {
		return this.arrivalDateTime;
	}

	public void setArrivalDateTime(ZonedDateTime arrivalDateTime) {
		this.arrivalDateTime = arrivalDateTime;
	}
}