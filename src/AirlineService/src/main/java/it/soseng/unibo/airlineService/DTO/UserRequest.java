package it.soseng.unibo.airlineService.DTO;

import java.time.OffsetDateTime;

import javax.validation.constraints.NotBlank;


public class UserRequest {

    @NotBlank(message = "departure is mandatory")
    public String departure;

    @NotBlank(message = "arrival is mandatory")
    public String arrival;

    @NotBlank(message = "departureDate is mandatory")
    public OffsetDateTime departureDate;    
    
    @NotBlank(message = "arrivalDate is mandatory")
    public OffsetDateTime arrivalDate;

    public UserRequest() {
    }

    

}
