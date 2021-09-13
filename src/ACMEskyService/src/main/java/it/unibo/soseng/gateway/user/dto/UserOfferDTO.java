package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

/**
 * Le istanze di questa classe descrivono i token necessari all'utente per
 * richiedere il pagamento dell'offerta da acquistare, da utilizzare nei corpi
 * delle richieste rivolte ai servizi esterni
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
public class UserOfferDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "Token cannot be null")
    private String offerToken;

    public void setOfferToken(String offerToken) {
        this.offerToken = offerToken;
    }

    public String getOfferToken() {
        return this.offerToken;
    }

}
