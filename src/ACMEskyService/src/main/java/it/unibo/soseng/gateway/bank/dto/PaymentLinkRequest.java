package it.unibo.soseng.gateway.bank.dto;

public class PaymentLinkRequest {
    
    private double amount;
    private String description;
    private String notificationUrl;

    
    public PaymentLinkRequest(double totalPrice, String description, String notificationUrl) {
        this.amount = totalPrice;
        this.description=description;
        this.notificationUrl=notificationUrl;
    }

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
