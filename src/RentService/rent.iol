type RentRequest: void {
    .clientName: string
    .clientSurname: string
    .fromAddress: string
    .toAddress: string
    .timeMillis: int
}

type RentResponse: void {
    .status: string
    .departureTimeMillis: int
    .rentId: string
}

interface RentInterface {
    RequestResponse:
        bookRent(RentRequest)(RentResponse)
}