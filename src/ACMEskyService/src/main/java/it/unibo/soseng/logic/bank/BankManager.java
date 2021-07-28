package it.unibo.soseng.logic.bank;

import java.io.IOException;

import javax.inject.Inject;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import it.unibo.soseng.gateway.bank.BankClient;
import it.unibo.soseng.gateway.bank.dto.AuthRequest;
import it.unibo.soseng.gateway.bank.dto.AuthResponse;
import it.unibo.soseng.gateway.bank.dto.PaymentLink;
import it.unibo.soseng.gateway.bank.dto.PaymentLinkRequest;
import okhttp3.ResponseBody;

public class BankManager {

    @Inject
    BankClient bankClient;
    
    public AuthResponse getToken(String wsAddress, AuthRequest reqDTO) throws IOException, InterruptedException{

        String token = bankClient.auth(wsAddress, reqDTO);

        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(token);
        
            AuthResponse res = new AuthResponse();
                res.setToken(root.get("jwtToken").toString());

        return res;
    }

    public PaymentLink getPaymentLink(String wsAddress, String token, PaymentLinkRequest payReq ) throws IOException, InterruptedException, ErrorReceivedPayLinkException{

        ResponseBody res = bankClient.paymentLink(wsAddress, token, payReq);
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(res.string());
        
        PaymentLink infoPayment = new PaymentLink();
            infoPayment.setPath(root.get("path").toString());
            infoPayment.setPaymentToken(root.get("paymenToken").toString());
        
        return infoPayment;
        
    }

    public class ErrorReceivedPayLinkException extends Exception {
        private static final long serialVersionUID = 1L;
    }
}
