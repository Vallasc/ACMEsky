package it.unibo.soseng.gateway.distance.dto;

import java.io.Serializable;

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
