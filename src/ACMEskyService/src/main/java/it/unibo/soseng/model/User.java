package it.unibo.soseng.model;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="users")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private long id;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "entity_id", nullable = false)
    private DomainEntity entity;

    @Column(name = "email", nullable = false)
    private String email;

	@Column(name = "name", nullable = false)
    private String name;

	@Column(name = "surname", nullable = false)
    private String surname;

    @Column(name = "prontogram_username", nullable = false)
    private String prontogramUsername;

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSurname() {
		return this.surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public DomainEntity getEntity() {
		return this.entity;
	}

	public void setEntity(DomainEntity entity) {
		this.entity = entity;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
 
	public String getProntogramUsername() {
		return this.prontogramUsername;
	}

	public void setProntogramUsername(String prontogramUsername) {
		this.prontogramUsername = prontogramUsername;
	}

}
