package com.ACMEbank.BankService.dto;

public class AuthResponseDTO {
    public String jwtToken;

    public AuthResponseDTO(){}
    
    public AuthResponseDTO(String token) {
        this.jwtToken = token;
    } 
}
