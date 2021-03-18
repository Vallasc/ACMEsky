package it.soseng.unibo.airlineService.repository;

import java.time.LocalDateTime;
import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import it.soseng.unibo.airlineService.model.FlightOffer;

/**
 * Quest'interfaccia gestisce la tabella FLIGHT_OFFERS
 * @author Andrea Di Ubaldo
 * andrea.diubaldo@studio.unibo.it
 */
public interface FlightOfferRepository extends JpaRepository<FlightOffer, Long> {

    @Query(value = "SELECT * FROM FLIGHT_OFFERS o WHERE o.DEPARTURE = ?1 AND O.DESTINATION = ?2 AND o.DEPARTURE_TIME = ?3 " +
                        "AND o.DESTINATION_TIME = ?4", nativeQuery = true)
    public ArrayList<FlightOffer> searchFlightOffers(String departure, String destination, LocalDateTime departureDate, 
                                                        LocalDateTime destinationDate);

}
