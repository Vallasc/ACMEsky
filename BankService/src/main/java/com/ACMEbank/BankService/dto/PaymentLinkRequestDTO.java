package com.ACMEbank.BankService.dto;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

public class PaymentLinkRequestDTO {

    @Min(1)
	public long expireTime;

    @Min(1)
	public int amount;

    @NotBlank(message = "Description is mandatory")
	public String description;

	public String notificationUrl;
    
    public PaymentLinkRequestDTO(){}
}
