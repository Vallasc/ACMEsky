package it.unibo.soseng.gateway.user.dto;

import java.io.Serializable;

import it.unibo.soseng.model.Airport;

/**
 * Le istanze di questa classe descrivono gli aereoporti come Data Transfer
 * Object da utilizzare nei corpi delle richieste rivolte ai servizi esterni
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */

public class AirportDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String code;
    private String name;
    private String cityName;
    private String countryCode;

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public static AirportDTO from(Airport airport) {
        AirportDTO response = new AirportDTO();
        response.setCode(airport.getAirportCode());
        response.setName(airport.getName());
        response.setCityName(airport.getCityName());
        response.setCountryCode(airport.getCountryCode());
        return response;
    }
}
