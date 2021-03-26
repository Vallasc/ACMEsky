package it.unibo.soseng.model;
import java.io.Serializable;
import javax.persistence.*;
import org.joda.time.DateTime;

@Entity
@Table(name="airlines")
public class Airline implements Serializable {
    /**

  */
 private static final long serialVersionUID = 1L;
 private long id;
 private String username;
 private String password ;
 private String wsAddress;
 

 @Id
 @Column(name="airline_id",nullable=false,columnDefinition="integer")
 public long getId() {
     return this.id;
 }
 public void setId(long id) {
     this.id = id;
 }

 @Column(name="username",nullable=false,columnDefinition="varchar(255)")
 public String getUsername() {
     return this.username;
 }
 public void setUsername(String username) {
     this.username = username;
 }

 @Column(name="password",nullable=false,columnDefinition="varchar(255)")
 public String getPassword() {
     return this.password;
 }
 public void setPassword(String password) {
     this.password = password;
 }

 @Column(name="ws_address",nullable=false,columnDefinition="varchar(255)")
 public String getWsAddress() {
     return this.wsAddress;
 }
 public void setWsAddress(String wsAddress) {
     this.wsAddress = wsAddress;
 }

}