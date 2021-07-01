package it.unibo.soseng.gateway.airline.dto;

public class AirlineDTO {
    
    long id;
    String ws_address;

    
    public AirlineDTO(long id, String ws_address) {
        this.id = id;
        this.ws_address = ws_address;
    }


    public long getId() {
        return id;
    }


    public void setId(long id) {
        this.id = id;
    }


    public String getWs_address() {
        return ws_address;
    }


    public void setWs_address(String ws_address) {
        this.ws_address = ws_address;
    }

    
}
