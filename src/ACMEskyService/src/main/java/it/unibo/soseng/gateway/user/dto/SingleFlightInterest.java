package it.unibo.soseng.gateway.user.dto;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

public class SingleFlightInterest {

    @NotNull
    private String departureAirportCode;

    @NotNull
    private String arrivalAirportCode;

    @Min(value = 0)
    private long departureTimestamp;

    @Min(value = 0)
    private long arrivalTimestamp;

    public String getDepartureAirportCode() {
        return departureAirportCode;
    }

    public void setDepartureAirportCode(String departureAirportCode) {
        this.departureAirportCode = departureAirportCode;
    }

    public long getArrivalTimestamp() {
        return arrivalTimestamp;
    }

    public void setArrivalTimestamp(long arrivalTimestamp) {
        this.arrivalTimestamp = arrivalTimestamp;
    }

    public long getDepartureTimestamp() {
        return departureTimestamp;
    }

    public void setDepartureTimestamp(long departureTimestamp) {
        this.departureTimestamp = departureTimestamp;
    }

    public String getArrivalAirportCode() {
        return arrivalAirportCode;
    }
    
    public void setArrivalAirportCode(String arrivalAirportCode) {
        this.arrivalAirportCode = arrivalAirportCode;
    }
}
