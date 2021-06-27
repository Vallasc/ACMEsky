package it.unibo.soseng.gateway.user.dto;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

public class UserSignUpRequest {
    @Email(message = "Email should be valid")
    private String email;

    @NotNull(message = "Password cannot be null")
    private String password;

    @NotNull(message = "ProntogramUsername cannot be null")
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
