
# Rent Service
Servizio che simula una compagnia di noleggio.

Utilizza SOAP per esporre i servizi.

## Service ports
| Name | Endpoint (Location) |
| - | - |
| RentServicePort | http://localhost:8080 |

## PortType: Rent
| Operation | Input | Output |
| - | - | - |
| bookRent | RentRequest | RentResponse |

## Bindings
| Name | Type | PortType | Style |
| - | - | - | - |
| RentSOAPBinding | SOAP11 | Rent | Document/Literal-Wrapped |

### Run:
```sh
jolie server.ol $SERVICE_NAME
```

### Create and run the docker stack
```sh
docker-compose up
```
