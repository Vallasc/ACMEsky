package com.ACMEbank.BankService.dto;

public class LinkResponseDTO {
	public String path;
	public String paymentToken;

	public LinkResponseDTO(){}
	
	public LinkResponseDTO(String path, String paymentToken){
		this.path = path;
		this.paymentToken = paymentToken;
	}
}
