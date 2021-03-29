package it.unibo.soseng.model;

import java.time.ZonedDateTime;
import java.io.Serializable;

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

	@ManyToOne
	@JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "departure_airport_id", nullable = false)
    private Airport departureAirport;

    @ManyToOne
    @JoinColumn(name = "arrival_airport_id", nullable = false)
    private Airport arrivalAirport;

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

	public User getUser() {
		return this.user;
	}

	public void setUserId(User user) {
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