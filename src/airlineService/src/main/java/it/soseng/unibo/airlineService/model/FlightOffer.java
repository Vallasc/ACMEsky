package it.soseng.unibo.airlineService.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "flightOffers")
public class FlightOffer {
    
    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "departure")
    private String departure;

    @Column(name = "departureTime")
    private LocalDateTime  departureTime;

    @Column(name = "destinationTime")
    private LocalDateTime destinationTime;

    @Column(name = "destination")
    private String destination;

    @Column(name = "price")
    private String price;

    public FlightOffer(){}

    public FlightOffer(String departure, LocalDateTime departureTime, LocalDateTime destinationTime, String destination, String price ) {
        this.departure = departure;
        this.departureTime = departureTime;
        this.destinationTime = destinationTime;
        this.destination = destination;
        this.price = price;
    }

  //   public FlightOffer(String departure, String departureTime, String destinationTime, String destination, String price ) {
  //     this.departure = departure;

  //     DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
  //     LocalDateTime depTime = LocalDateTime.parse(departureTime, formatter);
  //     this.departureTime = depTime;
  //     LocalDateTime destTime = LocalDateTime.parse(destinationTime, formatter);
  //     this.destinationTime = destTime;
  //     this.destination = destination;
  //     this.price = price;
  // }


  

    

	public Long getId() {
      return this.id;
    }

    public String getDeparture() {
      return this.departure;
    }

    public String getDestination() {
      return this.destination;
    }

    public LocalDateTime getDepartureTime() {
      return this.departureTime;
    }

    public LocalDateTime getDestinationTime() {
      return this.destinationTime;
    }

    public String getPrice() {
      return this.price;
    }

    public void setId(Long id) {
      this.id = id;
    }

    public void setDeparture(String departure) {
      this.departure = departure;
    }

    public void setDestination(String destination) {
      this.destination = destination;
    }
    public void setDepartureTime(String departureTime) {
      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
      LocalDateTime depTime = LocalDateTime.parse(departureTime, formatter);
      this.departureTime = depTime;
    }

    public void setDestinationTime(String destinationTime) {
      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
      LocalDateTime destTime = LocalDateTime.parse(destinationTime, formatter);
      this.destinationTime = destTime;
    }

    public void setPrice( String price) {
      this.price = price;
    }

//   @Override
//   public boolean equals(Object o) {

//     if (this == o)
//       return true;
//     if (!(o instanceof Employee))
//       return false;
//     Employee employee = (Employee) o;
//     return Objects.equals(this.id, employee.id) && Objects.equals(this.departure, employee.departure)
//         && Objects.equals(this.destination, employee.destination);
//   }

//   @Override
//   public int hashCode() {
//     return Objects.hash(this.id, this.departure, this.destination);
//   }

    // @Override
    // public String toString() {
    //   return "Employee{" + "id=" + this.id + ", departure='" + this.departure + '\'' + ", destination='" + this.destination + '\'' + '}';
    // }
}

