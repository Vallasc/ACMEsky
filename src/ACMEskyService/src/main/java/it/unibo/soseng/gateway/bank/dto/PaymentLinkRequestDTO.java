package it.unibo.soseng.gateway.bank.dto;

import java.io.Serializable;

/**
 * Gli oggetti istanziati da questa classe rappresentano le richieste da inviare
 * ai servizi bancari per richiedere il link di pagamento delle offerte di volo.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
public class PaymentLinkRequestDTO implements Serializable {

    private double amount;
    private String description;
    private String notificationUrl;

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getNotificationUrl() {
        return notificationUrl;
    }

    public void setNotificationUrl(String notificationUrl) {
        this.notificationUrl = notificationUrl;
    }
}
