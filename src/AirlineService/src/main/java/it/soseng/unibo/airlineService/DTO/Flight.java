package it.soseng.unibo.airlineService.DTO;

import java.time.OffsetDateTime;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Questa classe definisce le caratteristiche dei voli che verranno inviati ad
 * ACMEsky
 * 
 * @author Andrea Di Ubaldo andrea.diubaldo@studio.unibo.it
 */

public class Flight {

  private Long id;

  private String departureCode;

  private String departureTime;

  private String arrivalTime;

  private String arrivalCode;

  private String expDate;

  private String airlineName;

  private float price;

  /**
   * @return Long id del volo
   */
  public Long getId() {
    return this.id;
  }

  public String getExpDate() {
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
  public String getDepartureTime() {
    return this.departureTime;
  }

  /**
   * @return LocalDateTime il giorno e l'ora di arrivo
   */
  public String getArrivalTime() {
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
  public float getPrice() {
    return this.price;
  }

  /**
   * @return String la compagnia aerea che offre l'offerta
   */
  public String getAirlineName() {
    return airlineName;
  }

  /**
   * imposta l'id del volo a partire da quello dell'offerta di volo generata
   * 
   * @param id
   */
  public void setId(long id) {
    this.id = id;
  }

  /**
   * imposta l'id dell'aereoporto di arrivo
   */
  public void setArrivalCode(String arrivalCode) {
    this.arrivalCode = arrivalCode;
  }

  /**
   * imposta il giorno e l'ora della partenza
   * 
   * @param departureTime
   */
  public void setDepartureTime(String departureTime) {

    this.departureTime = departureTime;
  }

  /**
   * imposta il giorno e l'ora dell'arrivo
   * 
   * @param arrivalTime
   */
  public void setArrivalTime(String arrivalTime) {
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
   * 
   * @param price
   */
  public void setPrice(float price) {
    this.price = price;
  }

  public void setExpDate(String expDate) {
    this.expDate = expDate;
  }

  /**
   * imposta la compagnia aerea che offre il volo
   * 
   * @param airline_id
   */
  public void setAirlineName(String airlinename) {
    this.airlineName = airlinename;
  }

  @JsonIgnore
  public OffsetDateTime getDepartureOffsetDateTime() {
    return OffsetDateTime.parse(this.departureTime);
  }

  @JsonIgnore
  public OffsetDateTime getArrivalOffsetDateTime() {
    return OffsetDateTime.parse(this.arrivalTime);
  }

  @JsonIgnore
  public OffsetDateTime getExpiredOffsetDateTime() {
    return OffsetDateTime.parse(this.expDate);
  }
}