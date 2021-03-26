package it.unibo.soseng.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
public class FlightOffer {
    

    private Long id;

    private String departure;

    private LocalDateTime  departureTime;

    private LocalDateTime destinationTime;

    private String destination;

    private double price;

    private boolean bookableFlag = true;

    public FlightOffer(){}

    public FlightOffer(String departure, LocalDateTime departureTime, LocalDateTime destinationTime, String destination, double price ) {
        this.departure = departure;
        this.departureTime = departureTime;
        this.destinationTime = destinationTime;
        this.destination = destination;
        this.price = price;
    }


	
  /** 
   * @return Long id dell'offerta
   */
  public Long getId() {
      return this.id;
    }

    
    /** 
     * @return String la città di partenza del volo
     */
    public String getDeparture() {
      return this.departure;
    }

    
    /** 
     * @return String la città di destinazione
     */
    public String getDestination() {
      return this.destination;
    }

    
    /** 
     * @return LocalDateTime il giorno e l'ora della partenza
     */
    public LocalDateTime getDepartureTime() {
      return this.departureTime;
    }

    
    /** 
     * @return LocalDateTime il giorno e l'ora di arrivo
     */
    public LocalDateTime getDestinationTime() {
      return this.destinationTime;
    }

    
    /** 
     * @return double il prezzo dell'offerta
     */
    public double getPrice() {
      return this.price;
    }

    
    /** 
     * @return boolean il valore del campo bookableFlag che indica se il volo è prenotabile o no
     */
    public boolean getBookableFlagValue(){
      return this.bookableFlag;
    }

    
    /** 
     * imposta il luogo della partenza
     * @param departure 
     */
    public void setDeparture(String departure) {
      this.departure = departure;
    }

    
    /** 
     * imposta il luogo della destinazione
     * @param destination
     */
    public void setDestination(String destination) {
      this.destination = destination;
    }
    
    /** 
     * imposta il giorno e l'ora della partenza
     * @param departureTime
     */
    public void setDepartureTime(String departureTime) {
      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
      LocalDateTime depTime = LocalDateTime.parse(departureTime, formatter);
      this.departureTime = depTime;
    }

    
    /** 
     * imposta il giorno e l'ora dell'arrivo
     * @param destinationTime
     */
    public void setDestinationTime(String destinationTime) {
      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
      LocalDateTime destTime = LocalDateTime.parse(destinationTime, formatter);
      this.destinationTime = destTime;
    }

    
    /** 
     * imposta il prezzo dell'offerta
     * @param price
     */
    public void setPrice( double price) {
      this.price = price;
    }

    /** 
     * imposta il flag della prenotabilità a false
     */
    public void setBookableFlagFalse(){
      this.bookableFlag = false;
    }

}


