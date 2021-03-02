include "console.iol"
include "rent.iol"

inputPort Rent {
  Location: "socket://localhost:8080"
  Protocol: soap {
    .wsdl = "./rentService.wsdl"
    .wsdl.port = "Rent"
    .dropRootValue = true
  }
  Interfaces: RentInterface
}


init
{
  println@Console("Server ON")()
}

main {
    bookRent( request )( response ) {
        response.status = "ok"
        response.departureTimeMillis = 333
        response.rentId = "dsadsadas"
    }
}

// jolie2wsdl -i rent.iol --namespace www.unibo.it --portName Rent --portAddr http://localhost:8080 --outputFile rentService.wsdl server.ol
// jolie2wsdl -i rent.iol --namespace www.unibo.it --portName Rent --portAddr http://localhost:8080 --o rentService.wsdl server.ol