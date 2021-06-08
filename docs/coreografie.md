# Coreografie

### Generale

| Nome | Sigla | Commento |
|-|-| -|
| ACME | ACME | |
| Airline company | AIR | Indica tutte le possibili compagnie aeree |
| Rent company | RENT | Indica tutte le possibili compagnie di noleggio |
|Prontogram | PTG | |
|Bank | BANK | |
|Geodistance service | GEO | |
|USER | USER | |

```fsharp

// Richiesta voli alla compagnia aerea
// Viene ripetura per ogni compagnia aerea collegata ad ACMEsky
// queryFlights: Richesta di voli d'interesse per l'utente
// responseFlights: Voli disponibili dell'airline company
( queryFlights: ACME -> AIR ; responseFlights: AIR -> ACME )* | 

// Ricezione offerte last minute 
// Viene ripetura per ogni compagnia aerea collegata ad ACMEsky
// sendLastMinute: Voli last minute
( sendLastMinute: AIR -> ACME )* |

// Richiesta interesse per un volo
// requestInterest: messaggio di richiesta con andata, ritorno, partenza e arrivo
( requestInterest: USER -> ACME )* | 

( // Trovata offerta adatta all'utente
    (foundOffer: ACME -> Prontogram ; notifyUSER: Prontogram -> USER ; 
    ( // Utente conferma offerta
        (confirmOffer: USER -> ACME ; 
            (successResponse: ACME -> USER ; informAIR: ACME -> AIR; 
            ( confirmAvailableFlight: AIR -> ACME; confirmFlightToUSER: ACME -> USER; 
                askBankLink: ACME -> BANK ; responseLink: BANK -> ACME ; sendBANK: ACME -> USER ; payment: USER -> BANK ;  
            (
                (successPayment: BANK -> ACME; confirmSuccessPayment: ACME -> USER ; payTickets: ACME -> BANK ; receiveTickets: AIR -> ACME ;  
                    ( // Richiesta a GEO se costo > 1000
                        1 + 
                        (askForDistance: ACME -> GEO ; distanceResponse: GEO -> ACME; 
                            ( // Richiesta alla compagnia di nolleggio
                                1 +  (askForRent: ACME -> RENT; responseForRent: RENT-> ACME )
                                // sequenza 1 + (askForRent: a -> g; responseForRent: g-> a )
                            )
                        )
                    )
                ); successOrder: ACME -> USER
            )
            +
            (failPayment: BANK -> ACME; failOrder: ACME -> USER )
            ) + 
            flightNotAvailable: AIR -> ACME; FlightNotAvailableError: ACME -> USER
            )
            +
            failResponse: ACME -> USER
        )
    )) 
    + 
    1
)*
```
### Correttezza
```fsharp
(( query: ACME -> AIR ; response: AIR -> ACME)* | (sendLastMinute: AIR -> ACME )* ) |

// sequenza query: b-> a; response: a-> b
// sincrono corretto perchè prima riceve poi invia 
// condizioni di sender, receiver e disjoint rispettate
// sequenza corretta pertanto anche iteration è corretta.

// sequenza sendLastMinute: a -> b; 
// sequenza corretta poiché atomica, pertanto anche iteration è corretta.
|
( 
    request: USER -> ACME 
    // sequenza (request: c -> b)* | (..)*
)*
| 
( 
    (foundOffer: ACME -> Prontogram ; notifyUSER: Prontogram -> USER ; 
     // sequenza (foundOffer: b -> d ; notifyUSER: d -> c ; (..)) + 1
    ( 
        (confirmOffer: USER -> ACME ; 
         //sequenza confirmOffer: c -> b; (..) 
            (successResponse: ACME -> USER ; informAIR: ACME -> AIR;
            // sequenza (successResponse: b -> c; informAIR: b -> a; (..))  + failResponse: b -> c;
            ( 
                (confirmAvailableFlight: AIR -> ACME; confirmFlightToUSER: ACME -> USER;
                // sequenza confirmAvailableFlight: a -> b; confirmFlightToUSER: b -> c; 
                askBankLink: ACME -> BANK ; responseLink: BANK -> ACME ; sendBANK: ACME -> USER ; payment: USER -> BANK ;  
                // sequenza askBankLink: b -> e ; responseLink: e -> b ; sendBANK: b -> c ; payment: c -> e ; (..) + (flightNotAvailable: a -> b; FlightNotAvailableError: b -> c)
                    (
                        (successPayment: BANK -> ACME; confirmSuccessPayment: ACME -> USER ; payTickets: ACME -> BANK ; receiveTickets: AIR -> ACME ;
                        // sequenza (successPayment: e -> b ; confirmSuccessPayment: b -> c ; payTickets: b -> c ; receiveTickets: a -> b ; (..)); successOrder: b -> c ;  +  
                        // (failPayment: e -> b; failOrder: b -> c )
                            ( 
                                1 + 
                                (askForDistance: ACME -> GEO ; distanceResponse: GEO -> ACME; 
                                // sequenza 1 + (askForDistance: b -> f ; distanceResponse: f -> b;(..)) 
                                    ( 
                                        1 +  (askForRent: ACME -> RENT; responseForRent: RENT-> ACME )
                                        // sequenza 1 + (askForRent: b -> g; responseForRent: g-> b )
                                    )
                                )
                            )
                        ); successOrder: ACME -> USER; 
                    )
                    +
                    (failPayment: BANK -> ACME; failOrder: ACME -> USER )
                )
                + 
                (flightNotAvailable: AIR -> ACME; FlightNotAvailableError: ACME -> USER)
            )
            +
            failResponse: ACME -> USER 
        )
    )) 
    + 
    1
)*
```