package com.ACMEbank.BankService.dto;

import javax.validation.constraints.Min;

public class DepositRequestDTO {

    @Min(1)
    public int amount;

    public DepositRequestDTO(){}
    
    public DepositRequestDTO(int amount){
        this.amount = amount;
    }
}
