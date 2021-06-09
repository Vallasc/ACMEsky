# Coreografie

### Generale

| Nome | Sigla | Commento |
|-|-| -|
| ACME | ACME | |
| Airline company | AIR | Indica tutte le possibili compagnie aeree |
| Rent company | RENT | Indica tutte le possibili compagnie di noleggio |
|PTG | PTG | |
|Bank | BANK | |
|Geodistance service | GEO | |
|USER | USER | |

```fsharp

// Richiesta voli alla compagnia aerea
// Viene ripetura per ogni compagnia aerea collegata ad ACMEsky
// queryFlights: Richesta di voli d'interesse per l'utente
// responseFlights: Voli disponibili dell'airline company
( queryFlights: ACME -> AIR ; responseFlights: AIR -> ACME )* 
| 
// Ricezione offerte last minute 
// Viene ripetura per ogni compagnia aerea collegata ad ACMEsky
// sendLastMinute: Voli last minute
( sendLastMinute: AIR -> ACME )* 
|
// Richiesta interesse per un volo
// requestInterest: messaggio di richiesta con A/R o solo A 
( requestInterest: USER -> ACME )* 
|   
// Trovata offerta adatta all'utente
// foundOffer: mesaagio di offerta A/R o A
// notifyUSER: messaggio di notifica di Prontogram
(
    foundOffer: ACME -> PTG ; notifyUSER: PTG -> USER ; 
    (
        // L'utente conferma l'offerta
        // confirmOffer: messaggio di conferma offerta e pagamento
        ( 
            confirmOffer: USER -> ACME ; 
            (
                // ACMEsky conferma che l'offerta è disponibile
                // successOffer: messaggio di conferma offerta
                // requestBankLink: richiesta creazione link di pagamento
                // responselink: link di pagamento generato dalla banca
                // paymentLink: link di pagamento generato dalla banca
                // payment: pagamento attraverso il link generato
                (   
                    successOffer: ACME -> USER ;
                    requestBankLink: ACME -> BANK ; 
                    responselink: BANK -> ACME ;
                    paymentLink: ACME -> USER ;
                    payment: USER -> BANK ;
                    (
                        // successPayment: pagamento avvenuto con successo
                        // bookTickets: prenota e riceve i biglietti 
                        // tickets: biglietti prenotati
                        (
                            successPayment: BANK -> ACME ;
                            bookTickets: ACME -> AIR ;
                            tickets: AIR -> ACME ;
                            (
                                (   // Controllo Premium service
                                    (   // Richiesta a Geodistance se costo > 1000
                                        1 
                                        + 
                                        // requestDistance: richiesta calcolo della distanza
                                        // responseDistance: distanza calcolata
                                        (
                                            requestDistance: ACME -> GEO ; 
                                            responseDistance: GEO -> ACME ; 
                                            (   // Richiesta alla compagnia di noleggio
                                                1 
                                                +  
                                                // askForRent: richiesta noleggio veicoli
                                                // responseRent: risposta nolleggio
                                                (
                                                    askForRent: ACME -> RENT ; 
                                                    responseRent: RENT-> ACME 
                                                )
                                            )
                                        )
                                    ) ; 
                                    ticketSummary : ACME -> USER 
                                )
                                +
                                errorTickets: ACME -> USER
                            )
                        )
                        +
                        // Errore nel pagamento
                        // failPayment: pagamento fallito
                        // errorPayment: messaggio di errore
                        (   
                            failPayment: BANK -> ACME ;
                            errorPayment: ACME -> USER
                        )
                    )
                )
                +
                // ACMEsky controlla l'offerta e non è più disponibile
                // errorOffer: messaggio di errore dell'offerta
                errorOffer: ACME -> USER
            )
        )
        +
        // L'utente non conferma l'offerta
        1
    )
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
    (foundOffer: ACME -> PTG ; notifyUSER: PTG -> USER ; 
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