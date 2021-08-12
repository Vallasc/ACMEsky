package it.unibo.soseng.camunda.utils;

// METTERE I NOMI DELLE VARIBILI CON INIZIALE MINUSCOLA
public final class ProcessVariables {
    // Flights manager
    public static final String AIRLINE_FLIGHT_OFFERS = "airlineFlightOffers";
    public static final String AIRLINE_NAME = "airlineName";
    public static final String INTEREST_FLIGHTS_LIST = "InterestflightsList";
    public static final String FLIGHTS_TO_SAVE = "FlightOfferToSave";
    public static final String AIRLINE_SERVICES_INDEX = "airlineService";
    public static final String AIRLINE_SERVICES = "airlineServices";


    // Interest manager
    public static final String USER_INTERESTS_REQUEST = "userInterestsRequest";

    //UserOffer
    public static final String USER_OFFER_REQUEST = "userOfferRequest";
    public static final String OFFER_TOKEN = "offerToken";
    public static final String IS_VALID_TOKEN = "isValidToken";
    public static final String IS_OFFER_EXPIRED = "isOfferExpired";


    // OfferPayment
    public static final String USER_ADDRESS = "userAddress"; 
    public static final String USER_DISTANCE = "userDistance";  // float meters
    public static final String RENT_OUTBOUND = "rentOutbound"; // BookRentResponse
    public static final String RENT_BACK = "rentBack"; // BookRentResponse

    // Offers manager
    public static final String AVAILABLE_FLIGHTS = "availableFlight";
    public static final String USER_INTERESTS = "userInterests";
    public static final String USER_INTEREST_INDEX = "userInterestsIndex";
    public static final String CURRENT_USER_INTEREST= "currentUserInterest";
    public static final String PRONTOGRAM_USERNAME = "prontogramUsername";
    public static final String THERE_IS_FLIGHTS = "thereIsFlights";
    public static final String GENERATED_OFFER = "generatedOffer";


    // Commmon
    public static final String PROCESS_ERROR = "processError";
    public static final String BUSINESS_KEY = "businessKey";
    public static final String USERNAME = "username";
    public static final String ASYNC_RESPONSE = "asyncResponse";
    public static final String RESPONSE = "response";
    public static final String URI_INFO = "uriInfo";


    public static final String ERRORS_IN_PAYMENT_REQ = "ErrorsPaymentReq";
    public static final String USER_OFFER = "userOffer";
    public static final String PAYMENT_LINK = "paymentLink";
    public static final String PROCESS_STATE = "processState";
    // Processes
    public static final String PROCESS_SAVE_INTEREST = "processSaveInterest";
    public static final String PROCESS_CONFIRM_BUY_OFFER = "processConfirmBuyOffer";
    public static final String PROCESS_SAVE_LAST_MINUTE_OFFER = "processSaveLastMinuteOffer";

    // Premium Service Error
    public static final String PREMIUM_SERVICE_ERROR = "PremiumServiceError";
     
}
