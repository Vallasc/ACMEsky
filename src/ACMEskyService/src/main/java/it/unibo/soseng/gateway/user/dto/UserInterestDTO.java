package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import it.unibo.soseng.model.FlightInterest;
import it.unibo.soseng.model.UserInterest;

public class UserInterestDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private long id;

    @NotNull
    private FlightInterestDTO outboundFlight;

    private FlightInterestDTO flightBack;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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
        FlightInterest flightBack = userInterest.getFlightBackInterest();
        if( flightBack != null)
            dto.setFlightBack( FlightInterestDTO.from(flightBack) );
        else
            dto.setFlightBack( null );
        return dto;
    }
}