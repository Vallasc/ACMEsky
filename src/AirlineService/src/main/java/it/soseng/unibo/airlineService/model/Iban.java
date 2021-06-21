package it.soseng.unibo.airlineService.model;

/**
 * Questa classe definisce l'unica istanza della classe Iban,
 * definita secondo il pattern Singleton,
 * e in particolare le coordinate bancarie dell'istanza
 * @author Andrea Di Ubaldo
 * andrea.diubaldo@studio.unibo.it
 */
public class Iban {



    // Unica istanza della classe 
    private static Iban instance = null;

    private String ibanCoordinates;



    // Costruttore invisibile
    private Iban() {
    }

    
    /** 
     * @return Iban l'unica istanza della classe
     */
    public static Iban getInstance() {
        // Crea l'oggetto solo se NON esiste:
        if (instance == null) {
            instance = new Iban();
        }
        return instance;
    }

    
    /** 
     * @return String
     */
    /* Getter and Setter form property 'ibanCoordinates' */


    public String getIban() {
        return this.ibanCoordinates;
    }

    
    /** 
     * imposta le coordinate bancarie dell'istanza Iban
     * @param iban
     */
    public void setIban(String iban){
        this.ibanCoordinates = iban;
    }



}