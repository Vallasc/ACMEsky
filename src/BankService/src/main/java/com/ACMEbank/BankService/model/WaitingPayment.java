package com.ACMEbank.BankService.model;

import javax.persistence.*;

import com.ACMEbank.BankService.dto.PaymentLinkRequestDTO;

/**
 * Modello per la gestione dei link di pagamento
 * Giacomo Vallorani 
 * giacomo.vallorani4@studio.unibo.it
 */
@Entity
@Table(name = "waiting_payments")
public class WaitingPayment {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	@Column(name = "user_id")
	private String userId;

	@Column(name = "expire_time")
	private long expireTime;

	@Column(name = "amount")
	private int amount;

    @Column(name = "description")
	private String description;
    
    // Generato automaticamente
    @Column(name = "payment_token")
	private String paymentToken;

	@Column(name = "payed")
	private boolean payed;

	@Column(name = "notification_url")
	private String notificationUrl;

	public WaitingPayment() {}

	public WaitingPayment(long expireTime, int amount, String description, String notificationUrl) {
		this.expireTime = expireTime;
		this.amount = amount;
        this.description = description;
		this.notificationUrl = notificationUrl;
	}

	public long getId() {
		return id;
	}

	public String getUserId() {
		return userId;
	}

	public long getExpireTime() {
		return expireTime;
	}

	public int getAmount() {
		return amount;
	}

	public String getDescription() {
		return description;
	}

    public String getPaymentToken() {
		return paymentToken;
	}

	public boolean getPayed() {
		return payed;
	}

	public String getNotificationUrl() {
		return notificationUrl;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

    public void setPaymentToken(String token) {
		this.paymentToken = token;
	}

	public void setPayed(boolean payed) {
		this.payed = payed;
	}

	public static WaitingPayment fromRequestPaymentDTO(PaymentLinkRequestDTO dto){
		long expireTime = System.currentTimeMillis() + (1000 * 60 * 15 ); // 15 minuti alla scadenza del link
		return new WaitingPayment(expireTime, dto.amount, dto.description, dto.notificationUrl);
	}

}