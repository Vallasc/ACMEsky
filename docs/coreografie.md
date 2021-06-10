# Coreografie
## Nomenclatura
### Nomenclatura

| Nome | Sigla | Commento |
|-|-| -|
| ACME | ACME | |
| Airline company | AIR<sub>k</sub> | Indica la k-esima compagnia aerea |
| Rent company | RENT<sub>t</sub> | Indica la t-esima compagnia di noleggio |
|Prontogram | PTG | |
|Bank | BANK | |
|Geodistance service | GEO | |
|USER | USER<sub>x</sub> | Indica l'x-esimo utente |

&nbsp;

### Coreografia complessiva del sistema
```fsharp

// Query dei voli (ripetuta per tutte le compagnie aeree)
// Viene ripetuta per ogni compagnia aerea collegata ad ACMEsky
// queryFlights: Richesta di voli d'interesse per l'utente
// responseFlights: Voli disponibili dell'Airline company
( queryFlights: ACME -> AIRₖ ; responseFlights: AIRₖ -> ACME )* 
| 
// Ricezione offerte last minute (ripetuta per tutte le compagnie aeree)
// Viene ripetuta per ogni compagnia aerea collegata ad ACMEsky
// sendLastMinute: Voli last minute
( sendLastMinute: AIRₖ -> ACME )*
|
// Registrazione interesse dell'utente (ripetuta per tutti gli  utenti)
// requestInterest: messaggio di richiesta con A/R o solo A
// responseInterest: messaggio di conferma
( requestInterest: USERₓ -> ACME ; responseInterest: USERₓ -> ACME )* 
|   
// Notifica dell'offerta all'utente
// offerToken: mesaagio di offerta A/R o A
// notifyUser: messaggio di notifica di Prontogram
( offerToken: ACME -> PTG ; notifyUser: PTG -> USERₓ )*
|
// Conferma dell'offerta e pagamento
// confirmOffer: messaggio di conferma offerta e pagamento
// responseOffer: messaggio di conferma offerta
( 
    confirmOffer: USERₓ -> ACME ; 
    responseOffer: ACME -> USERₓ ;
    (
        // ACMEsky conferma che l'offerta è disponibile
        // requestPaymentLink: richiesta di pagamento da parte dell'utente

        // bookTickets: prenota e riceve i biglietti 
        // tickets: biglietti prenotati

        // requestBankLink: richiesta creazione link di pagamento
        // responselink: link di pagamento generato dalla banca
        // paymentLink: link di pagamento generato dalla banca
        // payment: pagamento attraverso il link generato
        // responsePayment: stato del pagamento
        // responsePaymentBank: esito pagamento
        (   
            requestPaymentLink: USERₓ -> ACME ; // REQUEST1

            bookTickets: ACME -> AIRₖ ;
            tickets: AIRₖ -> ACME ;
            (   
                // Tickets ok
                (
                    requestBankLink: ACME -> BANK ; 
                    responselink: BANK -> ACME ;
                    paymentLink: ACME -> USERₓ ; // RESPONSE1
                    payment: USERₓ -> BANK ;
                    responsePayment: BANK -> USERₓ ;
                    responsePaymentBank: BANK -> ACME ;
                    (
                        // Pagamento avvenuto con successo
                        (   // Controllo Premium service
                            // Richiesta a Geodistance se costo > 1000
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
                                    // requestRent: richiesta noleggio veicoli
                                    // responseRent: risposta nolleggio
                                    (
                                        requestRent: ACME -> RENTₜ ; 
                                        responseRent: RENTₜ-> ACME 
                                    )
                                )
                            )
                        )
                        +
                        // Errore nel pagamento
                        // unbookTickets: cancella la prenotazione dei biglietti
                        unbookTickets: ACME -> AIRₖ
                    ) ;
                    // L'utente richiede i biglietti
                    // tickets: l'utente richiede i biglietti
                    // ticketSummary: summary tickets o errore
                    tickets : USERₓ -> ACME ; // REQUEST2
                    ticketSummary : ACME -> USERₓ // RESPONSE2

                )
                // Errore nella prenotazione dei biglietti
                // errorTickets: errore volo non disponibile
                +
                errorTickets: ACME -> USERₓ // RESPONSE1
            )
        )
        +
        // ACMEsky controlla l'offerta e non è più disponibile
        1
    )
)
```
### Correttezza
Per stabilire la correttezza, e anche per una migliore lettura, la coreografia è stata divisa in 5 blocchi:
1. **Query dei voli**
2. **Ricezione offerte last-minute**
3. **Registrazione interesse dell'utente**
4. **Notifica dell'offerta all'utente**
5. **Conferma dell'offerta e pagamento**

Essendo queste sotto-coreografie eseguite in parallelo non ci sono condizioni da rispettare, pertanto, si è passati a valutare la corretteza di ogni singolo blocco.


La coreografia progettata rientra nel caso asincrono. 


\
\
\
&nbsp;

### Corr
```fsharp





(( query: ACME -> AIRₖ ; response: AIRₖ -> ACME)* | (sendLastMinute: AIRₖ -> ACME )* ) |

// sequenza query: b-> a; response: a-> b
// sincrono corretto perchè prima riceve poi invia 
// condizioni di sender, receiver e disjoint rispettate
// sequenza corretta pertanto anche iteration è corretta.

// sequenza sendLastMinute: a -> b; 
// sequenza corretta poiché atomica, pertanto anche iteration è corretta.
|
( 
    request: USERₓ -> ACME 
    // sequenza (request: c -> b)* | (..)*
)*
| 
( 
    (foundOffer: ACME -> PTG ; notifyUSERₓ: PTG -> USERₓ ; 
     // sequenza (foundOffer: b -> d ; notifyUSERₓ: d -> c ; (..)) + 1
    ( 
        (confirmOffer: USERₓ -> ACME ; 
         //sequenza confirmOffer: c -> b; (..) 
            (successResponse: ACME -> USERₓ ; informAIRₖ: ACME -> AIRₖ;
            // sequenza (successResponse: b -> c; informAIRₖ: b -> a; (..))  + failResponse: b -> c;
            ( 
                (confirmAvailableFlight: AIRₖ -> ACME; confirmFlightToUSERₓ: ACME -> USERₓ;
                // sequenza confirmAvailableFlight: a -> b; confirmFlightToUSERₓ: b -> c; 
                askBankLink: ACME -> BANK ; responseLink: BANK -> ACME ; sendBANK: ACME -> USERₓ ; payment: USERₓ -> BANK ;  
                // sequenza askBankLink: b -> e ; responseLink: e -> b ; sendBANK: b -> c ; payment: c -> e ; (..) + (flightNotAvailable: a -> b; FlightNotAvailableError: b -> c)
                    (
                        (successPayment: BANK -> ACME; confirmSuccessPayment: ACME -> USERₓ ; payTickets: ACME -> BANK ; receiveTickets: AIRₖ -> ACME ;
                        // sequenza (successPayment: e -> b ; confirmSuccessPayment: b -> c ; payTickets: b -> c ; receiveTickets: a -> b ; (..)); successOrder: b -> c ;  +  
                        // (failPayment: e -> b; failOrder: b -> c )
                            ( 
                                1 + 
                                (askForDistance: ACME -> GEO ; distanceResponse: GEO -> ACME; 
                                // sequenza 1 + (askForDistance: b -> f ; distanceResponse: f -> b;(..)) 
                                    ( 
                                        1 +  (askForRent: ACME -> RENTₜ; responseForRent: RENTₜ-> ACME )
                                        // sequenza 1 + (askForRent: b -> g; responseForRent: g-> b )
                                    )
                                )
                            )
                        ); successOrder: ACME -> USERₓ; 
                    )
                    +
                    (failPayment: BANK -> ACME; failOrder: ACME -> USERₓ )
                )
                + 
                (flightNotAvailable: AIRₖ -> ACME; FlightNotAvailableError: ACME -> USERₓ)
            )
            +
            failResponse: ACME -> USERₓ 
        )
    )) 
    + 
    1
)*
```