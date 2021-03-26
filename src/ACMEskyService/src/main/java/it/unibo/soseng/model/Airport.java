package it.unibo.soseng.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="airports")
public class Airport {
    private long id;
    private String aiportCode;
    private String address;
    private String name;

    @Id    
	@Column(name="id", 
            nullable=false, 
            columnDefinition="integer")
    public long getId() {
        return id;
    }

    public void setId(long aiportId) {
        this.id = aiportId;
    }

    @Id    
	@Column(name="airport_code", 
            length=20, 
            nullable=false)
    public String getAiportCode() {
        return aiportCode;
    }

    public void setAiportCode(String aiportCode) {
        this.aiportCode = aiportCode;
    }

    @Column(name="FIRST_NAME", length=20, nullable=false) 
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
