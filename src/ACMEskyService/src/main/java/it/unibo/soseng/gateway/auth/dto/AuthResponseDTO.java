package it.unibo.soseng.gateway.auth.dto;

/**
 * Questa classe descrive la struttura delle risposte che ACMEsky invia ai
 * servizi che richiedono l'autenticazione per consegnare loro il token da
 * utilizzare durante l'autorizzazione delle richieste inviate sulle route
 * legate al loro ruolo
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
public class AuthResponseDTO {
    private String token;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
