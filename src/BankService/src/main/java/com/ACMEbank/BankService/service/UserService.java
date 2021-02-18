package com.ACMEbank.BankService.service;

import java.util.concurrent.ThreadLocalRandom;

import com.ACMEbank.BankService.dto.DepositRequestDTO;
import com.ACMEbank.BankService.dto.PaymentRequestDTO;
import com.ACMEbank.BankService.dto.UserRequestDTO;
import com.ACMEbank.BankService.model.User;
import com.ACMEbank.BankService.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//TODO documentazione
@Service
public class UserService {

    @Autowired
    UserRepository userRepository;

    public User findByLogin(String loginId, String password){
        return userRepository.findByLogin(loginId, password);
    }

    public User getUserByLoginId(String loginId) {
        return userRepository.findByLoginId(loginId);
    }

    public User getUserById(long id) {
        return userRepository.findById(id).get();
    }

    public User register(UserRequestDTO dto) {
        int randomNum = ThreadLocalRandom.current().nextInt(10000, 99999 + 1);
        User result = userRepository.saveAndFlush(User.fromUserRequestDTO(dto));
        result.setLoginId(String.valueOf(randomNum)+String.valueOf(result.getId()));
        userRepository.saveAndFlush(result);
        return result;
    }

    @Transactional
    public void deposit(DepositRequestDTO deposit, String userId){
        userRepository.deposit(deposit.amount, userId);
    }

    @Transactional
    public void pay(PaymentRequestDTO payment, String userId){
        userRepository.pay(payment.amount, userId);
    }
}