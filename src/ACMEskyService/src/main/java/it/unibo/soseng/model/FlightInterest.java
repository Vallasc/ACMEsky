package it.unibo.soseng.model;

import java.time.OffsetDateTime;
import java.time.ZonedDateTime;
import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="flights_interest")
public class FlightInterest implements Serializable {

    private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
    private long id;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "user_id")
    private User user;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "departure_airport_id")
    private Airport departureAirport;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "arrival_airport_id")
    private Airport arrivalAirport;

	@Column(name = "departure_date_time", columnDefinition= "TIMESTAMP WITH TIME ZONE", nullable = false)
    private OffsetDateTime departureDateTime;

	@Column(name = "arrival_date_time", columnDefinition= "TIMESTAMP WITH TIME ZONE", nullable = false)
    private OffsetDateTime arrivalDateTime;


	public FlightInterest(Airport departureAirport, Airport arrivalAirport, OffsetDateTime departureDateTime,
			OffsetDateTime arrivalDateTime) {
		this.departureAirport = departureAirport;
		this.arrivalAirport = arrivalAirport;
		this.departureDateTime = departureDateTime;
		this.arrivalDateTime = arrivalDateTime;
	}
	public FlightInterest() {
    }
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

    public Airport getDepartureAirport() {
        return departureAirport;
    }

    public void setDepartureAirport(Airport departureAirport) {
        this.departureAirport = departureAirport;
    }

    public Airport getArrivalAirport() {
        return arrivalAirport;
    }

    public void setArrivalAirport(Airport arrivalAirport) {
        this.arrivalAirport = arrivalAirport;
    }
    
	public OffsetDateTime getDepartureDateTime() {
		return this.departureDateTime;
	}

	public void setDepartureDateTime(OffsetDateTime departureDateTime) {
		this.departureDateTime = departureDateTime;
	}
    
	public OffsetDateTime getArrivalDateTime() {
		return this.arrivalDateTime;
	}

	public void setArrivalDateTime(OffsetDateTime arrivalDateTime) {
		this.arrivalDateTime = arrivalDateTime;
	}
}