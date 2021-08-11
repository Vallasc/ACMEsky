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

    // TODO costruire il messaggio in base all'offerta
    public static NotificationDTO fromOffer(GeneratedOffer offer, String prontogramUsername){
        NotificationDTO notification = new NotificationDTO();
        String message = "<table>TODO token "+offer.getToken()+"</table>";
        notification.setMessage(message);
        notification.setUsername(prontogramUsername);
        notification.setInfo("Nuova offerta per te!\n");
        return notification;
    }
}

