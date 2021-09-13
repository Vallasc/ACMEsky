package it.unibo.soseng.gateway.bank.dto;

import java.io.Serializable;

/**
 * Gli oggetti istanziati da questa classe rappresentano le richieste che i
 * servizi esterni effettuano presso le route stabilite dalle banche per
 * l'autenticazione
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
public class AuthRequestDTO implements Serializable {

    private String userId;
    private String password;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
