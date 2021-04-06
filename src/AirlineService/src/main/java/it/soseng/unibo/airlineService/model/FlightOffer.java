package it.soseng.unibo.airlineService.model;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
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
@Entity
@Table(name = "flightOffers")
public class FlightOffer {
    
    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "departure_airport_id")
    private String departureId;

    @Column(name = "departure_airport_name")
    private String departureAirportName;

    @Column(name = "departure_airport_address")
    private String departure;

    @Column(name = "departure_date_time")
    private ZonedDateTime  departureTime;

    @Column(name = "arrival_date_time")
    private ZonedDateTime arrivalTime;

    @Column(name = "arrival_airport_address")
    private String arrival;

    @Column(name = "arrival_airport_name")
    private String arrivalAirportName;

    @Column(name = "arrival_airport_id")
    private String arrivalId;

    @Column(name = "airline_id")
    private String airline_id;

    @Column(name = "price")
    private double price;

    @Column(name = "expire_offer")
    private long expiryDate;

    @Column(name = "flag")
    private boolean bookableFlag = true;

    public FlightOffer(){}


	
  /** 
   * @return Long id dell'offerta
   */
  public Long getId() {
      return this.id;
    }

    public String getArrivalId() {
      return arrivalId;
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
    public String getArrival() {
      return this.arrival;
    }

    
    /** 
     * @return LocalDateTime il giorno e l'ora della partenza
     */
    public ZonedDateTime getDepartureTime() {
      return this.departureTime;
    }

    
    /** 
     * @return LocalDateTime il giorno e l'ora di arrivo
     */
    public ZonedDateTime getArrivalTime() {
      return this.arrivalTime;
    }

    public String getDepartureId() {
      return departureId;
    }

    

    
    /** 
     * @return double il prezzo dell'offerta
     */
    public double getPrice() {
      return this.price;
    }

    public long getExpiryDate(ZonedDateTime departureTime) {

      //LocalDateTime period = departureTime.minusDays(7);
      ZonedDateTime period = departureTime.minusDays(7);      
      return period.toInstant().toEpochMilli();
  }

    
    /** 
     * @return boolean il valore del campo bookableFlag che indica se il volo è prenotabile o no
     */
    public boolean getBookableFlagValue(){
      return this.bookableFlag;
    }

    
    public void setArrivalId(String arrivalId) {
      this.arrivalId = arrivalId;
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
     * @param arrival
     */
    public void setArrival(String arrival) {
      this.arrival = arrival;
    }
    
    /** 
     * imposta il giorno e l'ora della partenza
     * @param departureTime
     */
    public void setDepartureTime(String departureTime) {
      // DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
      ZonedDateTime zonedDateTime = ZonedDateTime.parse(departureTime);
      this.departureTime = zonedDateTime;
    }

    
    /** 
     * imposta il giorno e l'ora dell'arrivo
     * @param arrivalTime
     */
    public void setArrivalTime(String arrivalTime) {
      ZonedDateTime zonedDateTime = ZonedDateTime.parse(arrivalTime);      
      this.arrivalTime = zonedDateTime;
    }


    public void setDepartureId(String departureId) {
      this.departureId = departureId;
    }

    /** 
     * imposta il prezzo dell'offerta
     * @param price
     */
    public void setPrice( double price) {
      this.price = price;
    }

    /** 
     * imposta il prezzo dell'offerta
     * @param expiryDate
     */
    public void setExpiryDate( long expiryDate) {
      this.expiryDate = expiryDate;
    }

    /** 
     * imposta il flag della prenotabilità a false
     */
    public void setBookableFlagFalse(){
      this.bookableFlag = false;
    }

    public String getAirline_id() {
      return airline_id;
    }

    public void setAirline_id(String airline_id) {
      this.airline_id = airline_id;
    }



    public String getDepartureAirportName() {
      return departureAirportName;
    }



    public void setDepartureAirportName(String departureAirportName) {
      this.departureAirportName = departureAirportName;
    }



    public String getArrivalAirportName() {
      return arrivalAirportName;
    }



    public void setArrivalAirportName(String arrivalAirportName) {
      this.arrivalAirportName = arrivalAirportName;
    }

    

    

    

}

