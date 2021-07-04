package it.soseng.unibo.airlineService.DTO;

import java.time.OffsetDateTime;

/**
 * Questa classe definisce le caratteristiche dei voli che verranno inviati ad ACMEsky
 * @author Andrea Di Ubaldo
 * andrea.diubaldo@studio.unibo.it
 */

public class Flight {
    
    private Long id;

    private String departureCode;

    private OffsetDateTime  departureTime;

    private OffsetDateTime arrivalTime;

    private OffsetDateTime expDate;

    private String arrivalCode;

    private String airline_id;

    private double price;



	
    /** 
     * @return Long id del volo
     */
    public Long getId() {
        return this.id;
      }

    public OffsetDateTime getExpDate() {
      return expDate;
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
     * @return String la compagnia aerea che offre l'offerta
     */
    public String getAirline_id() {
      return airline_id;
    }

    /**
     * imposta l'id del volo a partire da quello dell'offerta di volo generata
     * @param id
     */
    public void setId(long id){
        this.id=id;
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
    public void setDepartureTime(OffsetDateTime departureTime) {
      this.departureTime = departureTime;
    }

    
    /** 
     * imposta il giorno e l'ora dell'arrivo
     * @param arrivalTime
     */
    public void setArrivalTime(OffsetDateTime arrivalTime) {     
      this.arrivalTime = arrivalTime;
    }


    /** 
     * imposta l'id dell'aereoporto di partenza
     */
    public void setDepartureCode(String departureCode) {
      this.departureCode = departureCode;
    }

    /** 
     * imposta il prezzo del volo
     * @param price
     */
    public void setPrice( double price) {
      this.price = price;
    }

    public void setExpDate(OffsetDateTime expDate) {
      this.expDate = expDate;
    }



    /**
     * imposta la compagnia aerea che offre il volo
     * @param airline_id
     */
    public void setAirline_id(String airline_id) {
      this.airline_id = airline_id;
    }




    

    

    

}