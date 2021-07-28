package it.unibo.soseng.gateway.bank.dto;

public class PaymentLink {
    
    private String path;
    private String paymentToken;

    
    public String getPath() {
        return path;
    }
    public void setPath(String path) {
        this.path = path;
    }
    public String getPaymentToken() {
        return paymentToken;
    }
    public void setPaymentToken(String paymentToken) {
        this.paymentToken = paymentToken;
    }

    
    
}
