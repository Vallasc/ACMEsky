package it.unibo.soseng.gateway.bank.dto;

import java.io.Serializable;

/**
 * Gli oggetti istanziati da questa classe descrivono i link al pagamento che
 * vengono inviati dalle banche per consentire agli utenti di effettuare il
 * pagamento.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
public class PaymentLinkDTO implements Serializable {

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
