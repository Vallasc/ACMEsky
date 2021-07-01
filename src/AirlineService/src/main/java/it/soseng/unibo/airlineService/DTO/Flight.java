package it.soseng.unibo.airlineService.DTO;

import java.time.OffsetDateTime;

/**
 * Questa classe definisce le caratteristiche dei voli che verranno inviati ad ACMEsky
 * @author Andrea Di Ubaldo
 * andrea.diubaldo@studio.unibo.it
 */

public class Flight {
    
    private Long id;

    private String departureId;

    private OffsetDateTime  departureTime;

    private OffsetDateTime arrivalTime;

    private OffsetDateTime expDate;

    private String arrivalId;

    private String airline_id;

    private double price;

    private boolean soldFlag;



public boolean isSoldFlag() {
      return soldFlag;
    }




    public void setSoldFlag(boolean soldFlag) {
      this.soldFlag = soldFlag;
    }




public OffsetDateTime getExpDate() {
      return expDate;
    }

    

	
    /** 
     * @return Long id del volo
     */
    public Long getId() {
        return this.id;
      }

    /** 
     * @return String id dell'aereoporto di arrivo
     */
    public String getArrivalId() {
      return arrivalId;
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
    public String getDepartureId() {
      return departureId;
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
    public void setArrivalId(String arrivalId) {
      this.arrivalId = arrivalId;
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
    public void setDepartureId(String departureId) {
      this.departureId = departureId;
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