package com.ACMEbank.BankService.dto;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

public class PaymentLinkRequestDTO {

    @Min(1)
	public int amount;

    @NotBlank(message = "HTML description is mandatory")
	public String description;

    @NotBlank(message = "notificationUrl is mandatory")
	public String notificationUrl;
    
    public PaymentLinkRequestDTO(){}
}
