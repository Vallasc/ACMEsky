package it.unibo.soseng.model;
import java.io.Serializable;
import javax.persistence.*;

@Entity
@Table(name="users")
public class User implements Serializable {
    /**

     */
    private static final long serialVersionUID = 1L;
    private long id;
    private String name;
	private String surname;
    private String email;
	private String password;
    private String prontogramToken;
    private String address;
	
	@Id
	@Column(name="user_id",nullable=false,columnDefinition="integer")
	public long getId() {
		return this.id;
	}
	public void setId(long id) {
		this.id = id;
	}

	@Column(name="name",nullable=false,columnDefinition="varchar(255)")
	public String getName() {
		return this.name;
	}
	public void setName(String name) {
		this.name = name;
	}

    @Column(name="surname",nullable=false,columnDefinition="varchar(255)")
	public String getSurname() {
		return this.surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
	}

    @Column(name="email",nullable=false,columnDefinition="varchar(255)")
	public String getEmail() {
		return this.email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

    @Column(name="password",nullable=false,columnDefinition="varchar(255)")
	public String getPassword() {
		return this.password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
 
    @Column(name="prontogram_token",nullable=false,columnDefinition="varchar(255)")
	public String getProntogramToken() {
		return this.prontogramToken;
	}
	public void setProntogramToken(String prontogramToken) {
		this.prontogramToken = prontogramToken;
	}

    @Column(name="address",nullable=false,columnDefinition="varchar(255)")
	public String getAddress() {
		return this.address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
}
