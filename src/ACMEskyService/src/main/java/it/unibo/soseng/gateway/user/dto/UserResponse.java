package it.unibo.soseng.gateway.user.dto;

public class UserResponse {
    private String email;
    private String password;
    private String prontogramToken;

    public String getProntogramToken() {
        return prontogramToken;
    }

    public void setProntogramToken(String prontogramToken) {
        this.prontogramToken = prontogramToken;
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
