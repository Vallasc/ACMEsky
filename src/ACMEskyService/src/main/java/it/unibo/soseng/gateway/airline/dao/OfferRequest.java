package it.unibo.soseng.gateway.airline.dao;

//import it.unibo.soseng.model.Flight;

public class OfferRequest {
    private String flightId;

    public void setFlightId(String flightId) {
        this.flightId = flightId;
    }

    public String getFlightId() {
        return flightId;
    }

    /*public Flight toFlight(){
        return new Flight(this.flightId);
    }*/
}
