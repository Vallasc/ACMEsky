package it.unibo.soseng.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 * descrive le entità dei servizi di noleggio specificandone i campi con cui
 * vengono registrati sul DB nella tabella rent_services
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Entity
@Table(name = "rent_services")
public class RentService implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private long id;

    @OneToOne
    @JoinColumn(name = "entity_id")
    private DomainEntity entity;

    @Column(name = "address", nullable = false)
    private String address;

    @Column(name = "ws_address", nullable = false)
    private String wsAddress;

    public long getId() {
        return this.id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public DomainEntity getEntity() {
        return this.entity;
    }

    public void setEntity(DomainEntity entity) {
        this.entity = entity;
    }

    public String getAddress() {
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getWsAddress() {
        return this.wsAddress;
    }

    public void setWsAddress(String wsAddress) {
        this.wsAddress = wsAddress;
    }
}