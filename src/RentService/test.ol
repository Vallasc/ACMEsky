include "console.iol"
include "time.iol"
include "rent.iol"

outputPort RentOutput {
  Location: "socket://localhost:8080"
  Protocol: soap {
    .wsdl = "./rentService.wsdl"
    .wsdl.port = "Rent"
    .dropRootValue = true
  }
  Interfaces: RentInterface
}

main {
    request.clientName = "Mario"
    request.clientSurname = "Verdi"
    request.fromAddress = "Piazza Verdi 69, 40127, Bologna"
    request.toAddress = "Via del lavoro 10, 40136, Bologna"
    request.toDateTime = "2021-03-03T10:36:23+0100"
    bookRent@RentOutput( request )( response )
    println@Console("Status: "+response.status)()
    println@Console("Departure DateTime: "+response.departureDateTime)()
    println@Console("Rent ID: "+response.rentId)()
}


