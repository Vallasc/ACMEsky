export type { Airport, Interest, User }

interface Airport {
    name : string
    code : string
    cityName : string
    countryCode : string
}

interface Interest {
    outboundFlight : {
        departureAirportCode : string
        arrivalAirportCode : string
        departureTimestamp : string
    }
    flightBack : {
        departureAirportCode : string
        arrivalAirportCode : string
        departureTimestamp : string
    } | null
}

interface User {
    email : string
    password : string
    prontogramUsername : string
}