include "console.iol"
include "time.iol"
include "rent.iol"
include "math.iol"
include "string_utils.iol"

inputPort Rent {
  Location: "socket://localhost:8080"
  Protocol: soap {
    .wsdl = "rentService.wsdl"
    .wsdl.port = "Rent"
    .dropRootValue = true
  }
  Interfaces: RentInterface
}

execution { concurrent }

init {
  println@Console("Rent server: " + args[0])()
}
            
main {
    bookRent( request )( response ){
      scope (bookrent) {
        install ( 
          FaultParams =>
            println@Console("ERROR: " + faultMsg)()
            response.status = faultMsg,
          InvalidTimestamp =>
            faultMsg = "INVALID_TIMESTAMP"
            throw( FaultParams, faultMsg )
        )

        if(request.clientName == "" || request.clientSurname == "") {
          faultMsg = "NAME_SURNAME_ERROR"
          throw(FaultParams, faultMsg)
        }
        // TODO Controllare esistenza indirizzi
        if(request.fromAddress == "" || request.toAddress == "") {
          faultMsg = "ADDRESS_ERROR"
          throw(FaultParams, faultMsg)
        }
        
        dateTime = request.arrivalDateTime;
        dateTime.format = "yyyy-MM-dd'T'HH:mm:ss"
        // Throws InvalidTimestamp
        getTimestampFromString@Time(dateTime)(arrivalToTimestamp)

        random@Math( )( randNum )
        // [0, 10]min
        randEarly = (int(randNum*10) * 1000 * 60);
        // toTimestamp - 2h - early
        departureTimestamp = arrivalToTimestamp - (1000 * 60 * 60 * 2) - randEarly
        departureTimestamp.format = "yyyy-MM-dd'T'HH:mm:ss"
        getDateTime@Time( departureTimestamp )( outDate  )
        response.departureDateTime = outDate;

        arrivalToTimestamp -= randEarly
        arrivalToTimestamp.format = "yyyy-MM-dd'T'HH:mm:ss"
        getDateTime@Time( arrivalToTimestamp )( outDate )
        response.arrivalDateTime = outDate;

        response.status = "OK"
        getRandomUUID@StringUtils(  )( outStr )
        outStr.begin = 0
        outStr.end = 8
        substring@StringUtils( outStr )( response.rentId )
      }
    }
}

// jolie2wsdl -i rent.iol --namespace www.unibo.it --portName Rent --portAddr http://localhost:8080 --o rentService.wsdl server.ol