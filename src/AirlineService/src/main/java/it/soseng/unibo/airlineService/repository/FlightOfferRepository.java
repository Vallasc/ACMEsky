package it.soseng.unibo.airlineService.repository;

import java.time.OffsetDateTime;
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

    @Query(value = "SELECT * FROM FLIGHT_OFFERS o WHERE o.DEPARTURE_AIRPORT_CODE = ?1 AND O.ARRIVAL_AIRPORT_CODE = ?2 AND o.DEPARTURE_DATE_TIME = ?3 ", nativeQuery = true)
    public ArrayList<FlightOffer> searchFlightOffers(String departure, String arrival, OffsetDateTime departureDate);

}