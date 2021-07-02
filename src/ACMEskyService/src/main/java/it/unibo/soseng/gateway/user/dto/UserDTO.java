package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

public class UserDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private String email;
    private String password;
    private String prontogramUsername;

    public String getProntogramUsername() {
        return prontogramUsername;
    }

    public void setProntogramUsername(String prontogramUsername) {
        this.prontogramUsername = prontogramUsername;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
}
