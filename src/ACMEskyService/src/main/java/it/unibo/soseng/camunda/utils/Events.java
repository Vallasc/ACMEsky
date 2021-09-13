package it.unibo.soseng.camunda.utils;

/**
 * Tutti gli eventi che si verificano durante l'esecuzione dei task dei
 * processi.
 * 
 * @author Giacomo Vallorani
 * @author Andrea Di Ubaldo
 * @author Riccardo Baratin
 */
public final class Events {
    public static final String SAVE_LAST_MINUTE = "SaveLastMinute";
    public static final String SAVE_INTERESTS = "SaveInterest";
    public static final String START_PAY_OFFER = "StartPayOffer";
    public static final String PAY_OFFER = "PayOffer";
    public static final String PAYMENT_SUCCESSFUL = "PaymentSuccessful";
    public static final String RESET_1 = "Reset1";
    public static final String RESET_2 = "Reset2";
}
