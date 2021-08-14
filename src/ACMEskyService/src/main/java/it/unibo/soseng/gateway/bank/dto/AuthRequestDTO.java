package it.unibo.soseng.gateway.bank.dto;

import java.io.Serializable;

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
