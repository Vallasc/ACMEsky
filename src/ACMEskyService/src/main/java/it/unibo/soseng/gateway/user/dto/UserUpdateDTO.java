package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

public class UserUpdateDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Email(message = "Email should be valid")
    private String email;

    @NotNull(message = "Password cannot be null")
    private String password;

    private String newPassword;
    private String newProntogramUsername;

    public String getNewProntogramUsername() {
        return newProntogramUsername;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public void setNewProntogramUsername(String newProntogramUsername) {
        this.newProntogramUsername = newProntogramUsername;
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
