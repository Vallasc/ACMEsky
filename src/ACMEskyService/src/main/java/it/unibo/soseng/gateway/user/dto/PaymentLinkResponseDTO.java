package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

public class PaymentLinkResponseDTO implements Serializable {
    private String offerCode;
    private String paymentLink;

    public String getPaymentLink() {
        return paymentLink;
    }

    public String getOfferCode() {
        return offerCode;
    }

    public void setOfferCode(String offerCode) {
        this.offerCode = offerCode;
    }
    
    public void setPaymentLink(String paymentLink) {
        this.paymentLink = paymentLink;
    }
}
