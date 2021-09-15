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

/**
 * descrive le entità delle compagnia aerea specificandone i campi con cui
 * vengono registrati sul DB nella tabella airlines
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
@Entity
@Table(name = "airlines")
public class Airline implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private long id;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "entity_id", nullable = false)
    private DomainEntity entity;

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

    public String getWsAddress() {
        return this.wsAddress;
    }

    public void setWsAddress(String wsAddress) {
        this.wsAddress = wsAddress;
    }
}