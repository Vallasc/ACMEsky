export type { Airport, Interest, User, Address, PaymentResponse, Flight, Offer }

interface Airport {
    name: string
    code: string
    cityName: string
    countryCode: string
}

interface Interest {
    id?: number
    outboundFlight : {
        departureAirportCode: string
        arrivalAirportCode: string
        departureTimestamp: string
    }
    flightBack : {
        departureAirportCode: string
        arrivalAirportCode: string
        departureTimestamp: string
    }
    priceLimit: number
}

interface User {
    email: string
    password: string
    name: string
    surname: string
    prontogramUsername: string
}

interface Address {
    offerToken: string
    postCode: string
    address: string
    cityName: string
    country: string
}

interface PaymentResponse {
    offerCode: string
    paymentLink: string
}

interface Flight {
    flightCode: string
    departureAirportCode: string
    arrivalAirportCode: string
    departureCity: string
    arrivalCity: string
    departureTimestamp: string
    arrivalTimestamp: string
    airlineName: string
    price: float
}

interface Offer {
    outboundFlight: Flight
    flightBack: Flight
    totalPrice: float
    token: string
    rent: boolean
}