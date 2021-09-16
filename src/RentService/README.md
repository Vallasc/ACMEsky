
# Rental service
Servizio che simula una compagnia di noleggio.

Implementato in Jolie, utilizza SOAP per esporre i servizi.

## Service ports
| Name | Endpoint (Location) |
| - | - |
| RentServicePort | http://localhost:8080 |

## PortType
| Operation | Input | Output |
| - | - | - |
| bookRent | RentRequest | RentResponse |

### RentRequest
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org soap/envelope/" xmlns:unib="www.unibo.it.xsd">
<soapenv:Header/>
    <soapenv:Body>
        <unib:bookRent>
        <clientName>?</clientName>
        <clientSurname>?</clientSurname>
        <fromAddress>?</fromAddress>
        <arrivalDateTime>?</arrivalDateTime>
        <toAddress>?</toAddress>
        </unib:bookRent>
    </soapenv:Body>
</soapenv:Envelope>
```

### RentRequest
```xml
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <SOAP-ENV:Body>
        <bookRentResponse>
            <departureDateTime xsi:type="xsd:string">?<departureDateTime>
            <arrivalDateTime xsi:type="xsd:string">?<arrivalDateTime>
            <status xsi:type="xsd:string">?</status>
            <rentId xsi:type="xsd:string">?</rentId>
        </bookRentResponse>
    </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## Bindings
| Name | Type | PortType | Style |
| - | - | - | - |
| RentSOAPBinding | SOAP11 | Rent | Document/Literal-Wrapped |

## Run service:
```sh
jolie server.ol $SERVICE_NAME
```

### Create and run the docker stack
```sh
docker-compose up
```
&nbsp;
<div class="page-break"></div>
