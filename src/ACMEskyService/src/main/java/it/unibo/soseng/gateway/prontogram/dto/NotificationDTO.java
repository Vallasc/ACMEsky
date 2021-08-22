package it.unibo.soseng.gateway.prontogram.dto;

import java.io.Serializable;

import it.unibo.soseng.model.GeneratedOffer;

public class NotificationDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String message;
    private String username;
    private String info;

    public void setUsername(String prontogramUsername) {
        this.username = prontogramUsername;
    }

    public String getusername() {
        return this.username;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return this.message;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getInfo() {
        return this.info;
    }

    public static NotificationDTO fromOffer(GeneratedOffer offer, String prontogramUsername){
        NotificationDTO notification = new NotificationDTO();
        String message = 
            "<h3>ACMEsky ha una nuova offerta per te!</h3><br/><br/>" +
            "<table>" +
                "<tr>" +
                    "<th>Codice offerta</th>" +
                    "<th> " + offer.getToken() + "</th>" +
                "</tr>" +
                "<tr>" +
                    "<th>Areoporto di partenza</th>" +
                    "<th> (" + offer.getOutboundFlight().getDepartureAirport().getAirportCode() + ")</th>" +
                "</tr>" +
                "<tr>" +
                    "<th>Areoporto di arrivo</th>" +
                    "<th> (" + offer.getOutboundFlight().getArrivalAirport().getAirportCode() + ")</th>" +
                "</tr>" +
                "<tr>" +
                    "<th>Data e ora andata</th>" +
                    "<th> " + offer.getOutboundFlight().getDepartureDateTime().toString() + "</th>" +
                "</tr>" +
                "<tr>" +
                    "<th>Data e ora ritorno</th>" +
                    "<th> " + offer.getFlightBack().getDepartureDateTime().toString() + "</th>" +
                "</tr>" +
                "<tr>" +
                    "<th>Prezzo totale</th>" +
                    "<th> " + String.format ("%.2f", offer.getTotalPrice()) + "€</th>" +
                "</tr>" +
            "</table>";
        notification.setMessage(message);
        notification.setUsername(prontogramUsername);
        notification.setInfo("Nuova offerta per te!\n Codice " + offer.getToken());
        return notification;
    }
}

