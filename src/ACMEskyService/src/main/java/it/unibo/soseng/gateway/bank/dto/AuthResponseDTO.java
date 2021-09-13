package it.unibo.soseng.gateway.bank.dto;

import java.io.Serializable;

/**
 * Gli oggetti istanziati da questa classe rappresentano le risposte della banca
 * ai servizi che richiedono l'autenticazione.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
public class AuthResponseDTO implements Serializable {

    private String jwtToken;

    public String getJwtToken() {
        return jwtToken;
    }

    public void setJwtToken(String jwtToken) {
        this.jwtToken = jwtToken;
    }

}
