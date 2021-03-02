include "console.iol"
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
    request.clientName = "Pippo"
    request.clientSurname = "Coca"
    request.fromAddress = "Piazza Verdi 69, 40127, Bologna"
    request.toAddress = "Via del lavoro 10, 40136, Bologna"
    request.timeMillis = 0000023433424
    bookRent@RentOutput( request )( response )
    println@Console("status"+response.status)()
}

// wsdl2jolie wsdl_uri [output filename]

