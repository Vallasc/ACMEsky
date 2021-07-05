package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import it.unibo.soseng.model.UserInterest;

public class UserInterestDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private long id;

    @NotNull
    private FlightInterestDTO outboundFlight;

    @NotNull
    private FlightInterestDTO flightBack;

    @NotNull
    @Min(10)
    @Max(1000)
    private double priceLimit;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public double getPriceLimit() {
        return priceLimit;
    }

    public void setPriceLimit(double priceLimit) {
        this.priceLimit = priceLimit;
    }
    
    public FlightInterestDTO getOutboundFlight() {
        return outboundFlight;
    }


    public void setOutboundFlight(FlightInterestDTO outboundFlight) {
        this.outboundFlight = outboundFlight;
    }

    public FlightInterestDTO getFlightBack() {
        return flightBack;
    }

    public void setFlightBack(FlightInterestDTO flightBack) {
        this.flightBack = flightBack;
    }

    public static UserInterestDTO from(UserInterest userInterest){
        UserInterestDTO dto = new UserInterestDTO();
        dto.setId( userInterest.getId() );
        dto.setOutboundFlight( FlightInterestDTO.from(userInterest.getOutboundFlightInterest()) );
        dto.setFlightBack( FlightInterestDTO.from( userInterest.getFlightBackInterest() ) );
        return dto;
    }
}