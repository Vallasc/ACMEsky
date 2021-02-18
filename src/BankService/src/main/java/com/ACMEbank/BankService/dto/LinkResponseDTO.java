package com.ACMEbank.BankService.dto;

public class LinkResponseDTO {
	public String path;
	public String paymenToken;

	public LinkResponseDTO(){}
	
	public LinkResponseDTO(String path, String paymenToken){
		this.path = path;
		this.paymenToken = paymenToken;
	}
}
