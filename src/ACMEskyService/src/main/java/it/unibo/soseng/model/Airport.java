package it.unibo.soseng.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="airports")
public class Airport implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
    private long id;

    @Column(name = "code", nullable = false, unique = true)
    private String code;

    @Column(name = "name", nullable = false) 
    private String name;

    @Column(name = "city_name", nullable = false) 
    private String cityName;

    @Column(name = "country_code", nullable = false) 
    private String countryCode;

    @Column(name = "timezone", nullable = false) 
    private int timezone;

    @Column(name = "latitude", nullable = false) 
    private float latitude;

    @Column(name = "longitude", nullable = false) 
    private float longitude;


    public long getId() {
        return id;
    }

    public void setId(long aiportId) {
        this.id = aiportId;
    }

    public float getLongitude() {
        return longitude;
    }

    public void setLongitude(float longitude) {
        this.longitude = longitude;
    }

    public float getLatitude() {
        return latitude;
    }

    public void setLatitude(float latitude) {
        this.latitude = latitude;
    }

    public int getTimezone() {
        return timezone;
    }

    public void setTimezone(int timezone) {
        this.timezone = timezone;
    }

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    public String getAirportCode() {
        return code;
    }

    public void setAirportCode(String airportCode) {
        this.code = airportCode;
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
}
