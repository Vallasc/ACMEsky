package it.unibo.soseng.gateway.user.dto;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

public class UserSignInRequest {
    @Email(message = "Email should be valid")
    private String email;

    @NotNull(message = "Password cannot be null")
    private String password;

    @NotNull(message = "ProntogramToken cannot be null")
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
