package com.ACMEbank.BankService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.ACMEbank.BankService.model.User;

public interface UserRepository extends JpaRepository<User, Long> {

    @Query(value = "SELECT * FROM USERS u WHERE u.LOGIN_ID = ?1 AND u.password = ?2", nativeQuery = true)
    User findByLogin(String loginId, String password);

    @Query(value = "SELECT * FROM USERS u WHERE u.LOGIN_ID = ?1", nativeQuery = true)
    User findByLoginId( String loginId);

    @Modifying
    @Query(value = "UPDATE USERS u SET u.BALANCE = u.BALANCE + ?1 WHERE u.LOGIN_ID = ?2", nativeQuery = true)
    void deposit(int amount, String loginId);

    @Modifying
    @Query(value = "UPDATE USERS u SET u.BALANCE = u.BALANCE - ?1 WHERE u.LOGIN_ID = ?2", nativeQuery = true)
    void pay(int amount, String loginId);
}