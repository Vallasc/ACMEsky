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

/**
 * Servizio che gestisce gli utenti della banca
 * Giacomo Vallorani 
 * giacomo.vallorani4@studio.unibo.it
 */
@Service
public class UserService {

    @Autowired
    UserRepository userRepository;

    /**
     * Trova l'utente dato login e password
     * @param loginId identificativo utente
     * @param password
     * @return oggetto utente
     */
    public User findByLogin(String loginId, String password){
        return userRepository.findByLogin(loginId, password);
    }

    /**
     * Restituisce l'utente dato l'id
     * @param loginId identificativo utente
     * @return  oggetto utente
     */ 
    public User getUserByLoginId(String loginId) {
        return userRepository.findByLoginId(loginId);
    }

    /**
     * Restituisce l'utente dato l'id della tabella
     * @param id
     * @return ogetto utente
     */
    public User getUserById(long id) {
        return userRepository.findById(id).get();
    }

    /**
     * Registra l'utente nel db
     * @param userRequestDto oggetto richiesta utente
     * @return oggetto utente generato
     */
    public User register(UserRequestDTO userRequestDto) {
        int randomNum = ThreadLocalRandom.current().nextInt(10000, 99999 + 1);
        User result = userRepository.saveAndFlush(User.fromUserRequestDTO(userRequestDto));
        result.setLoginId(String.valueOf(randomNum)+String.valueOf(result.getId()));
        userRepository.saveAndFlush(result);
        return result;
    }

    /**
     * Deposita denaro nel conto dell'utente con id=userId
     * @param deposit richiesta deposito
     * @param userId identificativo utente
     */
    @Transactional
    public void deposit(DepositRequestDTO deposit, String userId){
        userRepository.deposit(deposit.amount, userId);
    }

    /**
     * Invia denaro
     * @param payment richiesta di pagamento
     * @param userId identificativo utente
     */
    @Transactional
    public void pay(PaymentRequestDTO payment, String userId){
        userRepository.pay(payment.amount, userId);
    }
}