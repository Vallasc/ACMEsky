package com.ACMEbank.BankService.dto;

import javax.validation.constraints.NotBlank;

public class AuthRequestDTO {
    @NotBlank(message = "UserId is mandatory")
    public String userId;
    @NotBlank(message = "Password is mandatory")
    public String password;

    public AuthRequestDTO(){}
}
