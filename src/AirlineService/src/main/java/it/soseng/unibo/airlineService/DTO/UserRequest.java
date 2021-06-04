package it.soseng.unibo.airlineService.DTO;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZonedDateTime;

import javax.validation.constraints.NotBlank;


public class UserRequest {

    @NotBlank(message = "departureCity is mandatory")
    public String departureCity;

    @NotBlank(message = "destinationCity is mandatory")
    public String destinationCity;

    @NotBlank(message = "departureDate is mandatory")
    public OffsetDateTime departureDate;    
    
    @NotBlank(message = "destinationDate is mandatory")
    public OffsetDateTime destinationDate;

    public UserRequest() {
    }

    

}
