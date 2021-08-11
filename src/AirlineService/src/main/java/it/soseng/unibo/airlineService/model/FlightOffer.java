package it.soseng.unibo.airlineService.model;

import java.time.OffsetDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Questa classe definisce le caratteristiche delle offerte di volo
 * definendo per ogni attributo un campo della tabella FLIGHT_OFFERS che verrà generata
 * quando verrà creata la prima istanza di flightOffer
 * @author Andrea Di Ubaldo
 * andrea.diubaldo@studio.unibo.it
 */
@Entity
@Table(name = "flightOffers")
public class FlightOffer {
    
    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "departure_airport_code")
    private String departureCode;

    @Column(name = "departure_date_time", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private OffsetDateTime  departureTime;

    @Column(name = "arrival_date_time", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private OffsetDateTime arrivalTime;

    @Column(name = "arrival_airport_code")
    private String arrivalCode;

    @Column(name = "airline_id")
    private String airline_id;

    @Column(name = "price")
    private double price;

    @Column(name = "place")
    private String place;

    @Column(name = "expire_offer", columnDefinition = "TIMESTAMP WITH TIME ZONE")
    private OffsetDateTime expiryDate;

    @Column(name = "flag")
    private boolean soldFlag = false;

    public FlightOffer(){}


	
    /** 
     * @return Long id dell'offerta
     */
    public Long getId() {
        return this.id;
      }

    /** 
     * @return String id dell'aereoporto di arrivo
     */
    public String getArrivalCode() {
      return arrivalCode;
    }

    /** 
     * @return LocalDateTime il giorno e l'ora della partenza
     */
    public OffsetDateTime getDepartureTime() {
      return this.departureTime;
    }

    /** 
     * @return LocalDateTime il giorno e l'ora di arrivo
     */
    public OffsetDateTime getArrivalTime() {
      return this.arrivalTime;
    }

    /** 
     * @return String id dell'aereoporto di partenza
     */
    public String getDepartureCode() {
      return departureCode;
    }

    /** 
     * @return double il prezzo dell'offerta
     */
    public double getPrice() {
      return this.price;
    }

    /** 
     * @return String il posto del viaggiatore sull'aereo
     */
    public String getPlace() {
      return this.place;
    }


    /** 
     * @return long la data di scadenza dell'offerta espressa in forma numerica 
     */
    public OffsetDateTime getExpiryDate() {
      return this.expiryDate;
    }

    /** 
     * @return boolean il valore del campo soldFlag che indica se il volo è già stato venduto o no
     */
    public boolean getSoldFlag(){
      return this.soldFlag;
    }

    /**
     * @return String la compagnia aerea che offre l'offerta
     */
    public String getAirline_id() {
      return airline_id;
    }

    

    /** 
     * imposta l'id dell'aereoporto di arrivo
     */
    public void setArrivalCode(String arrivalCode) {
      this.arrivalCode = arrivalCode;
    }

    
    /** 
     * imposta il giorno e l'ora della partenza
     * @param departureTime
     */
    public void setDepartureTime(String departureTime) {
      OffsetDateTime zonedDateTime = OffsetDateTime.parse(departureTime);
      this.departureTime = zonedDateTime;
    }

    
    /** 
     * imposta il giorno e l'ora dell'arrivo
     * @param arrivalTime
     */
    public void setArrivalTime(String arrivalTime) {
      OffsetDateTime zonedDateTime = OffsetDateTime.parse(arrivalTime);      
      this.arrivalTime = zonedDateTime;
    }


    /** 
     * imposta l'id dell'aereoporto di partenza
     */
    public void setDepartureCode(String departureCode) {
      this.departureCode = departureCode;
    }

    /** 
     * imposta il prezzo dell'offerta
     * @param price
     */
    public void setPrice( double price) {
      this.price = price;
    }

    /** 
     * imposta il numero di posto del passeggero sull'aereo
     * @param place
     */
    public void setPlace(String place) {
       this.place=place;
    }

    /** 
     * imposta la data di scadenza dell'offerta
     * @param expiryDate
     */
    public void setExpiryDate() {
      OffsetDateTime expiryDate = departureTime.minusDays(7);      
      this.expiryDate=expiryDate;
    }


    /** 
     * imposta il flag relativo all'acquisto o meno dell'offerta
     */
    public void setSoldFlag(boolean value){
      this.soldFlag = value;
    }

    /**
     * imposta la compagnia aerea che offre l'offerta
     * @param airline_id
     */
    public void setAirline_id(String airline_id) {
      this.airline_id = airline_id;
    }




    

    

    

}
