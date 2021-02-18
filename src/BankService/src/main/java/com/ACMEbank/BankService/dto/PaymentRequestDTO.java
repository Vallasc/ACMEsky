package com.ACMEbank.BankService.dto;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

public class PaymentRequestDTO {

    @Min(1)
	public int amount;

    @NotBlank(message = "Description is mandatory")
	public String IBAN;

    @NotBlank(message = "Description is mandatory")
	public String description;
    
    public PaymentRequestDTO(){}
}
