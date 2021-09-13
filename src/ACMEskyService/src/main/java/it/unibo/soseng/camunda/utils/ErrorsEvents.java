package it.unibo.soseng.camunda.utils;

/**
 * Questa classe contiene tutti i possibili errori nel contesto dei task da
 * eseguire.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
public class ErrorsEvents {
    public static final String SEND_TICKET_ERROR = "sendTicketError";
    public static final String RESPONSE_PAYMENT_LINK_ERROR = "paymentLinkError";
    public static final String DISTANCE_ERROR = "distanceServiceError";
    public static final String PREPARE_OFFER_ERROR = "prepareOfferError";
}
