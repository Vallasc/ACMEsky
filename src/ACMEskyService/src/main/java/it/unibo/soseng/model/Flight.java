package it.unibo.soseng.model;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="flights")
public class Flight {

    private long id;
    private long departure_airport_id;
    private long arrival_airport_id;
    private long airline_id;
    private DateTime departure_date_time;
    private DateTime arrival_date_time;
    private float price;
    private DateTime expire_date;
    private boolean booked;

}