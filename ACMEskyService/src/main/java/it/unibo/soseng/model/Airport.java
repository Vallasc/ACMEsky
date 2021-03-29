package it.unibo.soseng.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="airports")
public class Airport implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
    private long id;

    @Column(name = "airport_code", nullable = false)
    private String aiportCode;

    @Column(name = "address", nullable = false) 
    private String address;

    @Column(name = "name", nullable = false) 
    private String name;


    public long getId() {
        return id;
    }

    public void setId(long aiportId) {
        this.id = aiportId;
    }

    public String getAiportCode() {
        return aiportCode;
    }

    public void setAiportCode(String aiportCode) {
        this.aiportCode = aiportCode;
    }

    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
