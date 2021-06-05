package it.soseng.unibo.airlineService.DTO;

import java.time.OffsetDateTime;

import javax.validation.constraints.NotBlank;

public class FlightDTO {

    @NotBlank(message = "id is mandatory")
    public long id;
    
    @NotBlank(message = "departureCity is mandatory")
    public String departureId;

    @NotBlank(message = "destinationCity is mandatory")
    public String destinationId;

    @NotBlank(message = "departureDate is mandatory")
    public OffsetDateTime departureDate;    
    
    @NotBlank(message = "destinationDate is mandatory")
    public OffsetDateTime destinationDate;

    @NotBlank(message  = "airline_id")
    public String airline_id;

    @NotBlank(message = "price")
    public double price;

    @NotBlank(message = "flag")
    private boolean bookedFlag = false;

    @NotBlank(message = "expire_offer")
    private OffsetDateTime expiryDate;

    public FlightDTO(long id, String departureId, String destinationId, OffsetDateTime departureDate, 
                            OffsetDateTime destinationDate, String airline_id, double price, OffsetDateTime expTime){
        
                                this.id=id;
                                this.departureId=departureId;
                                this.destinationId=destinationId;
                                this.departureDate=departureDate;
                                this.destinationDate=destinationDate;
                                this.airline_id=airline_id;
                                this.price=price;
                                this.expiryDate=expTime;
                            }
}
