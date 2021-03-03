include "console.iol"
include "Time.iol"
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

execution { concurrent }

init {
  println@Console("Rent server ON")()
}

main {
    bookRent( request )( response ) {
      dateTime = request.toDateTime;
			dateTime.format = "yyyy-MM-dd'T'HH:mm:ssZ"
			getTimestampFromString@Time(dateTime)(toTimestamp)

      fromTimestamp = toTimestamp - (1000 * 60 * 60 * 2)
      fromTimestamp.format = "yyyy-MM-dd'T'HH:mm:ssZ"
      getDateTime@Time( fromTimestamp )( dateTimeResponse )

      response.status = "ok"
      response.departureDateTime = dateTimeResponse
      response.rentId = "odassdasdadask"
    }
}

// jolie2wsdl -i rent.iol --namespace www.unibo.it --portName Rent --portAddr http://localhost:8080 --o rentService.wsdl server.ol