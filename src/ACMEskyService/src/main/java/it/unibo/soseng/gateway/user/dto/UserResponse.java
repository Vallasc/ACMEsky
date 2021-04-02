package it.unibo.soseng.gateway.user.dto;

public class UserResponse {
    private String name;
    private String surname;
    private String email;
    private String password;
    private String prontogramToken;
    private String address;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
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
}
