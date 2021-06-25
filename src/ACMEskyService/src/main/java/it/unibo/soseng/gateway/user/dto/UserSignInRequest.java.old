package it.unibo.soseng.gateway.user.dto;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

public class UserSignInRequest {
    
    @NotNull(message = "Name cannot be null")
    private String name;

    @NotNull(message = "Surname cannot be null")
	private String surname;

    @Email(message = "Email should be valid")
    private String email;

    @NotNull(message = "Password cannot be null")
    private String password;

    @NotNull(message = "ProntogramToken cannot be null")
    private String prontogramToken;

    @NotNull(message = "Address cannot be null")
    private String address;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

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

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

}
