package it.soseng.unibo.airlineService.DTO;

import java.time.OffsetDateTime;
import java.time.format.DateTimeParseException;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonIgnore;


public class UserRequest {

    @NotBlank(message = "departure is mandatory")
    public String departure;

    @NotBlank(message = "arrival is mandatory")
    public String arrival;

    @NotBlank(message = "departureDate is mandatory")
    public String departureDate;    
    
    @JsonIgnore
    public OffsetDateTime getDepartureOffsetDateTime() throws DateTimeParseException {
        return OffsetDateTime.parse(departureDate);
    }
    
    public UserRequest() {
    }


    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        UserRequest other = (UserRequest) obj;
        if (arrival == null) {
            if (other.arrival != null)
                return false;
        } else if (!arrival.equals(other.arrival))
            return false;
        if (departure == null) {
            if (other.departure != null)
                return false;
        } else if (!departure.equals(other.departure))
            return false;
        if (departureDate == null) {
            if (other.departureDate != null)
                return false;
        } else if (!departureDate.equals(other.departureDate))
            return false;
        return true;
    }

    

}
