package it.unibo.soseng.gateway.user.dto;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

public class UserUpdateRequest {
    @Email(message = "Email should be valid")
    private String email;

    @NotNull(message = "Password cannot be null")
    private String password;

    private String newPassword;
    private String newProntogramToken;

    public String getNewProntogramToken() {
        return newProntogramToken;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public void setNewProntogramToken(String newProntogramToken) {
        this.newProntogramToken = newProntogramToken;
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
