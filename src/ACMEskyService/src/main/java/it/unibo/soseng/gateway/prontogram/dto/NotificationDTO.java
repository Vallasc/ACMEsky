package it.unibo.soseng.gateway.prontogram.dto;

import java.io.Serializable;

import it.unibo.soseng.model.GeneratedOffer;

public class NotificationDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String message;
    private String prontogramUsername; // Vedere come impostare in base a prontogram

    public void setProntogramUsername(String prontogramUsername) {
        this.prontogramUsername = prontogramUsername;
    }

    public String getProntogramUsername() {
        return this.prontogramUsername;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return this.message;
    }

    // TODO costruire il messaggio in base all'offerta
    public static NotificationDTO fromOffer(GeneratedOffer offer, String prontogramUsername){
        NotificationDTO notification = new NotificationDTO();
        String message = "<table>qualcosa dentro utilizzando offer</table>" + offer.getToken();
        notification.setMessage(message);
        notification.setProntogramUsername(prontogramUsername);
        return notification;
    }
}

