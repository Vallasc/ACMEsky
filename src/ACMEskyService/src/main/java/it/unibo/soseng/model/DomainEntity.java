package it.unibo.soseng.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="domain_entities")
public class DomainEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private long id;

    @Column(name = "username", nullable = false, unique = true)
    private String username;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "salt", nullable = false)
    private String salt;

    @Column(name = "role", nullable = false)
    private String role;


    public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

    public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

    public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

    public String getSalt() {
		return this.salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

    public String getRole() {
		return this.role;
	}

	public void setRole(String role) {
		this.role = role;
	}
}
