package it.soseng.unibo.airlineService.repository;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import it.soseng.unibo.airlineService.model.FlightOffer;

/**
 * Quest'interfaccia gestisce la tabella FLIGHT_OFFERS
 * 
 * @author Andrea Di Ubaldo andrea.diubaldo@studio.unibo.it
 */
public interface FlightOfferRepository extends JpaRepository<FlightOffer, Long> {

    /**
     * query di ricerca dei voli con l'aereoporto di partenza e arrivo passati come
     * argomenti della funzione
     * 
     * @param departure
     * @param arrival
     * @return
     */
    @Query(value = "SELECT * FROM FLIGHT_OFFERS o WHERE o.DEPARTURE_AIRPORT_CODE = ?1 AND O.ARRIVAL_AIRPORT_CODE = ?2 ", nativeQuery = true)
    public ArrayList<FlightOffer> searchFlightOffers(String departure, String arrival);

}