package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

/**
 * Le istanze di questa classe descrivono le risposte alle richieste HTTP che
 * richiedono il link di pagamento dell'offerta di volo come Data Transfer
 * Object da utilizzare nei corpi delle richieste rivolte ai servizi esterni
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
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
