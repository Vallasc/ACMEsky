package it.unibo.soseng.model;
import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;


public class UserRequest {

    @NotBlank(message = "departureCity is mandatory")
    public String departureCity;

    @NotBlank(message = "destinationCity is mandatory")
    public String destinationCity;

    @NotBlank(message = "departureDate is mandatory")
    public LocalDateTime departureDate;    
    
    @NotBlank(message = "destinationDate is mandatory")
    public LocalDateTime destinationDate;

    public UserRequest() {
    }

    

}