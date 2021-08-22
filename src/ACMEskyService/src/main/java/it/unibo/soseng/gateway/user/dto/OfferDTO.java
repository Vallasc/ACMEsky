package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

import it.unibo.soseng.model.GeneratedOffer;

public class OfferDTO implements Serializable {
    
    private static final long serialVersionUID = 1L;

    private FlightDTO outboundFlight;
    private FlightDTO flightBack;
    private float totalPrice;
    private String token;
    private boolean rent;

    
    public FlightDTO getOutboundFlight() {
        return outboundFlight;
    }

    public boolean getRent() {
        return rent;
    }

    public void setRent(boolean rent) {
        this.rent = rent;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public FlightDTO getFlightBack() {
        return flightBack;
    }

    public void setFlightBack(FlightDTO flightBack) {
        this.flightBack = flightBack;
    }

    public void setOutboundFlight(FlightDTO outboundFlight) {
        this.outboundFlight = outboundFlight;
    }

    public static OfferDTO fromOffer(GeneratedOffer offer){
        OfferDTO dto = new OfferDTO();
        dto.token = offer.getToken();
        dto.outboundFlight = FlightDTO.fromFlight(offer.getOutboundFlight());
        dto.flightBack = FlightDTO.fromFlight(offer.getFlightBack());
        dto.totalPrice = (float) offer.getTotalPrice();
        dto.rent = offer.getRent();
        return dto;
    }
}
