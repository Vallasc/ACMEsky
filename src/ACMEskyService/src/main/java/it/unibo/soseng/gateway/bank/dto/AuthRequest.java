package it.unibo.soseng.gateway.bank.dto;

public class AuthRequest {
    
    private String userId;
    private String password;

    
    public AuthRequest(String acmeUser, String acmePass) {
        this.userId=acmeUser;
        this.password=acmePass;
    }
    
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
