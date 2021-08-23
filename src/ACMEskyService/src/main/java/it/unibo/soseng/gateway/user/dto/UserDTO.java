package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

import it.unibo.soseng.model.User;

public class UserDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private String email;
    private String name;
    private String surname;
    private String password;
    private String prontogramUsername;

    public String getProntogramUsername() {
        return prontogramUsername;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public static UserDTO fromUser(User user) {
        UserDTO dto = new UserDTO();
        dto.email = user.getEmail();
        dto.name = user.getName();
        dto.surname = user.getSurname();
        dto.prontogramUsername = user.getProntogramUsername();
        dto.password = user.getEntity().getPassword();
        return dto;
    }
}
