package it.soseng.unibo.airlineService.model;

public class Iban {
    // Unica istanza della classe
    private static Iban instance = null;
    private String ibanCoordinates = "IT44A0300203280446531574273";


    // Costruttore invisibile
    private Iban() {} 

    public static Iban getInstance() {
        // Crea l'oggetto solo se NON esiste:
        if (instance == null) {
            instance = new Iban();
        }
        return instance;
    }

    /* Getter and Setter form property 'ibanCoordinates' */

    public String getIban(){
        return this.ibanCoordinates;
    }


}

