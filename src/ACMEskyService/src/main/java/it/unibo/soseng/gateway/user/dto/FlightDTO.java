package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;
import java.time.OffsetDateTime;

import com.fasterxml.jackson.annotation.JsonIgnore;

import it.unibo.soseng.model.Flight;

/**
 * Le istanze di questa classe descrivono i voli delle offerte come Data
 * Transfer Object da utilizzare nei corpi delle richieste rivolte ai servizi
 * esterni
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

public class FlightDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String flightCode;
    private String departureAirportCode;
    private String arrivalAirportCode;
    private String departureCity;
    private String arrivalCity;
    private String departureTimestamp;
    private String arrivalTimestamp;
    private float price;
    private String airlineName;

    public String getFlightCode() {
        return flightCode;
    }

    public String getArrivalCity() {
        return arrivalCity;
    }

    public void setArrivalCity(String arrivalCity) {
        this.arrivalCity = arrivalCity;
    }

    public String getDepartureCity() {
        return departureCity;
    }

    public void setDepartureCity(String departureCity) {
        this.departureCity = departureCity;
    }

    public void setFlightCode(String flightCode) {
        this.flightCode = flightCode;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getArrivalTimestamp() {
        return arrivalTimestamp;
    }

    public void setArrivalTimestamp(String arrivalTimestamp) {
        this.arrivalTimestamp = arrivalTimestamp;
    }

    public String getDepartureTimestamp() {
        return departureTimestamp;
    }

    public void setDepartureTimestamp(String departureTimestamp) {
        this.departureTimestamp = departureTimestamp;
    }

    public String getArrivalAirportCode() {
        return arrivalAirportCode;
    }

    public void setArrivalAirportCode(String arrivalAirportCode) {
        this.arrivalAirportCode = arrivalAirportCode;
    }

    public String getDepartureAirportCode() {
        return departureAirportCode;
    }

    public void setDepartureAirportCode(String departureAirportCode) {
        this.departureAirportCode = departureAirportCode;
    }

    public String getAirlineName() {
        return this.airlineName;
    }

    public void setAirlinename(String airlineName) {
        this.airlineName = airlineName;
    }

    @JsonIgnore
    public OffsetDateTime getDepartureOffsetDateTime() {
        return OffsetDateTime.parse(this.departureTimestamp);
    }

    @JsonIgnore
    public OffsetDateTime getArrivalOffsetDateTime() {
        return OffsetDateTime.parse(this.arrivalTimestamp);
    }

    @JsonIgnore
    public void setDepartureOffsetDateTime(OffsetDateTime departurDateTime) {
        this.departureTimestamp = departurDateTime.toString();
    }

    @JsonIgnore
    public void setArrivalOffsetDateTime(OffsetDateTime arrivalDateTime) {
        this.arrivalTimestamp = arrivalDateTime.toString();
    }

    public static FlightDTO fromFlight(Flight flight) {
        FlightDTO dto = new FlightDTO();
        dto.airlineName = flight.getAirlineId().getEntity().getUsername();
        dto.arrivalAirportCode = flight.getArrivalAirport().getAirportCode();
        dto.departureAirportCode = flight.getDepartureAirport().getAirportCode();
        dto.arrivalCity = flight.getArrivalAirport().getCityName();
        dto.departureCity = flight.getDepartureAirport().getCityName();
        dto.flightCode = flight.getFlightCode();
        dto.price = flight.getPrice();
        dto.setDepartureOffsetDateTime(flight.getDepartureDateTime());
        dto.setArrivalOffsetDateTime(flight.getArrivalDateTime());
        return dto;
    }
}
