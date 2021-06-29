import { Airport } from "./airport";

export class Flight {
    flightCode: string;
    departure_airport: Airport;
    arrival_airport: Airport;
    AirlineName: string;
    departureDateTime: Date;
    arrivalDateTime: Date;
    price: number;
}