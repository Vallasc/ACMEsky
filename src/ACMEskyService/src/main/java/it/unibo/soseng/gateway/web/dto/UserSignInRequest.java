package it.unibo.soseng.gateway.web.dto;

import javax.validation.constraints.NotNull;

public class UserSignInRequest {
    
    @NotNull
    private String name;

    @NotNull
	private String surname;

    @NotNull
    private String email;

    @NotNull
    private String password;

    @NotNull
    private String prontogramToken;

    @NotNull
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
