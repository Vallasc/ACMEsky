package it.unibo.soseng.gateway.auth.dto;

import javax.validation.constraints.NotNull;

/**
 * Gli oggetti istanziati da questa classe rappresentano le richieste che i
 * servizi esterni effettuano presso le route preposte da ACMEsky per
 * l'autenticazione
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
public class AuthRequestDTO {

    @NotNull(message = "Username cannot be null")
    private String username;

    @NotNull(message = "Password cannot be null")
    private String password;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
