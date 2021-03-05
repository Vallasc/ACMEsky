type RentRequest: void {
    .clientName: string
    .clientSurname: string
    .fromAddress: string
    .toAddress: string
    .arrivalDateTime: string
}

type RentResponse: void {
    .status: string
    .departureDateTime?: string
    .arrivalDateTime?: string
    .rentId?: string
}

interface RentInterface {
    RequestResponse:
        bookRent(RentRequest)(RentResponse)
}