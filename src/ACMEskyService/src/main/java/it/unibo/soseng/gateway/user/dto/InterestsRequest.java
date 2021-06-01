package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

public class InterestsRequest implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @NotNull
    private SingleFlightInterest outboundFlight;
    private SingleFlightInterest flightBack;

    public SingleFlightInterest getOutboundFlight() {
        return outboundFlight;
    }

    public void setOutboundFlight(SingleFlightInterest outboundFlight) {
        this.outboundFlight = outboundFlight;
    }

    public SingleFlightInterest getFlightBack() {
        return flightBack;
    }

    public void setFlightBack(SingleFlightInterest flightBack) {
        this.flightBack = flightBack;
    }
}