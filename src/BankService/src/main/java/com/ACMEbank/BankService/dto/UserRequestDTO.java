package com.ACMEbank.BankService.dto;

import javax.validation.constraints.NotBlank;

public class UserRequestDTO {
	@NotBlank(message = "Name is mandatory")
	public String name;

	@NotBlank(message = "Password is mandatory")
	public String password;

	public UserRequestDTO(){}
}
