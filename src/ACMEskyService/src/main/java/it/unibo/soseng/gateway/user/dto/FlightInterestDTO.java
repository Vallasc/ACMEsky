package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;
import java.time.OffsetDateTime;
import java.time.format.DateTimeParseException;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;

import it.unibo.soseng.model.FlightInterest;

public class FlightInterestDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull
    private String departureAirportCode;

    @NotNull
    private String arrivalAirportCode;

    @NotNull
    private String departureTimestamp;

    public FlightInterestDTO() {}

    public String getDepartureAirportCode() {
        return departureAirportCode;
    }

    public void setDepartureAirportCode(String departureAirportCode) {
        this.departureAirportCode = departureAirportCode;
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

    @JsonIgnore
    public OffsetDateTime getDepartureOffsetDateTime() throws DateTimeParseException {
        return OffsetDateTime.parse(departureTimestamp);
    }

    @JsonIgnore
    public void setDepartureOffsetDateTime(OffsetDateTime departureOffsetDateTime) {
        departureTimestamp = departureOffsetDateTime.toString();
    }

    public static FlightInterestDTO from(FlightInterest flightInterest){
        FlightInterestDTO dto = new FlightInterestDTO();
        dto.setArrivalAirportCode( flightInterest.getArrivalAirport().getAirportCode() );
        dto.setDepartureAirportCode( flightInterest.getDepartureAirport().getAirportCode() );
        dto.setDepartureOffsetDateTime( flightInterest.getDepartureDateTime() );
        return dto;
    }
}