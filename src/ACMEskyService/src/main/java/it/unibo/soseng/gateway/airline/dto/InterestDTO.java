package it.unibo.soseng.gateway.airline.dto;

import java.io.Serializable;
import java.time.OffsetDateTime;

/**
 * La classe che caratterizza il DTO del volo di interesse dell'utente che viene
 * passato come body nelle richieste che ACMEsky manda alle compagnie aeree per
 * cercare i voli compatibili
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
public class InterestDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    public String departure;
    public String arrival;
    public String departureDate;

    public InterestDTO(String departure, String arrival, String departureDateTime) {
        this.departure = departure;
        this.arrival = arrival;
        this.departureDate = departureDateTime;
    }

}
