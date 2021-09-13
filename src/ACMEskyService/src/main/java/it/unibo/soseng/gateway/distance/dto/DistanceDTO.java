package it.unibo.soseng.gateway.distance.dto;

import java.io.Serializable;

/**
 * Gli oggetti istanziati da questa classe descrivono le distanze dagli
 * indirizzi degli aereoporti dei voli e agli indirizzi degli utenti che hanno
 * acquistato l'offerta
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
public class DistanceDTO implements Serializable {
    private float value;
    private String distance;
    private String status;

    public float getValue() {
        return value;
    }

    public String getStatus() {
        return status;
    }

    public String getDistance() {
        return distance;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setStringDistance(String distance) {
        this.distance = distance;
    }

    public void setValue(float value) {
        this.value = value;
    }

}
