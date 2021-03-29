package com.ACMEbank.BankService.model;

import javax.persistence.*;

import com.ACMEbank.BankService.dto.UserRequestDTO;

/**
 * Modello per la gestione degli utenti registrati
 * Giacomo Vallorani 
 * giacomo.vallorani4@studio.unibo.it
 */
@Entity
@Table(name = "users")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	@Column(name = "name")
	private String name;

	@Column(name = "login_id", unique = true)
	private String loginId;

	@Column(name = "password")
	private String password;

    @Column(name = "balance")
	private long balance;

	public User() {}
	
	public User(String name, String password, String entryPoint) {
		this.name = name;
		this.password = password;
	}

	public long getId() {
		return id;
	}

	public String getLoginId() {
		return loginId;
	}

	public String getName() {
		return name;
	}

	public String getPassword() {
		return password;
	}

	public long getBalance() {
		return balance;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public void setBalance(long balance) {
		this.balance = balance;
	}

	public static User fromUserRequestDTO(UserRequestDTO dto){
		return new User(dto.name, dto.password, dto.entryPoint);
	}

}