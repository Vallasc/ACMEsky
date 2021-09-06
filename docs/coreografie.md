# Coreografie

## Nomenclatura

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

## Coreografia complessiva del sistema

```fsharp
// Query dei voli (ripetuta per tutte le compagnie aeree)
// Viene ripetuta per ogni compagnia aerea collegata ad ACMEsky
// queryFlights: Richesta di voli d'interesse per l'utente
// responseFlights: Voli disponibili dell'Airline company
( queryFlights: ACME -> AIRₖ ; responseFlights: AIRₖ -> ACME )* 
| 

// Ricezione offerte last minute (ripetuta per tutte le compagnie aeree)
// Viene ripetuta per ogni compagnia aerea collegata ad ACMEsky
// sendLastMinute: invia le offerte last minute
( sendLastMinute: AIRₖ -> ACME )*
|

// Registrazione interesse dell'utente (ripetuta per tutti gli  utenti)
// requestInterest: messaggio di richiesta con A/R
( requestInterest: USERₓ -> ACME )* 
|   

// Notifica dell'offerta all'utente
// offerToken: mesaagio di offerta A/R
// notifyUser: messaggio di notifica di Prontogram
( offerToken: ACME -> PTG ; notifyUser: PTG -> USERₓ )*
|

// Conferma dell'offerta e pagamento
// confirmOffer: messaggio di conferma offerta e pagamento
( 
    confirmOffer: USERₓ -> ACME ; 
    (
        // ACMEsky conferma che l'offerta è disponibile
        // responseOfferOk: messaggio di conferma offerta
        // requestPaymentLink: richiesta di pagamento da parte dell'utente
        (   
            responseOfferOk: ACME -> USERₓ ;
            requestPaymentLink: USERₓ -> ACME ; // REQUEST1
            (   
                // Tickets ok
                // bookTickets: prenota i biglietti 
                // responseTickets: biglietti prenotati
                // requestBankLink: richiesta creazione link di pagamento
                // responselink: link di pagamento generato dalla banca
                // paymentLink: link di pagamento generato dalla banca
                // payment: pagamento attraverso il link generato
                // responsePayment: stato del pagamento
                (
                    bookTickets: ACME -> AIRₖ ;
                    responseTickets: AIRₖ -> ACME ;
                    requestBankLink: ACME -> BANK ; 
                    responselink: BANK -> ACME ;
                    paymentLink: ACME -> USERₓ ; // RESPONSE1
                    payment: USERₓ -> BANK ;
                    responsePayment: BANK -> USERₓ ;
                    (
                        // Pagamento avvenuto con successo
                        // successPaymentBank: esito pagamento
                        (
                            successPaymentBank: BANK -> ACME ;

                            // Controllo Premium service
                            (
                                // Richiesta a Geodistance se costo > 1000€
                                1 
                                + 
                                // requestDistance: richiesta calcolo della distanza
                                // responseDistance: distanza calcolata
                                (
                                    requestDistance: ACME -> GEO ; 
                                    responseDistance: GEO -> ACME ; 
                                    (   // Richiesta alla compagnia di noleggio se distanza <30Km
                                        1 
                                        +  
                                        // requestRent1: richiesta noleggio veicoli 1
                                        // responseRent1: risposta nolleggio 1
                                        // requestRent2: richiesta noleggio veicoli 2
                                        // responseRent2: risposta nolleggio 2
                                        (
                                            requestRent1: ACME -> RENTₜ₁ ; 
                                            responseRent1: RENTₜ₁-> ACME ;
                                            requestRent2: ACME -> RENTₜ₂ ; 
                                            responseRent2: RENTₜ₂-> ACME 
                                        )
                                    )
                                )
                            )
                        )
                        +
                        (
                            // Errore nel pagamento
                            // unbookTickets: cancella la prenotazione dei biglietti
                            // emitCoupon: pagamento fallito
                            unbookTickets: ACME -> AIRₖ
                            emitCoupon: ACME -> BANK ;

                        )
                    ) ;
                    // L'utente richiede i biglietti
                    // requestTickets: l'utente richiede i biglietti
                    // ticketSummary: summary tickets o errore
                    requestTickets : USERₓ -> ACME ; // REQUEST2
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
        // responseOfferError: errore offerta
        responseOfferError: ACME -> USERₓ
    )
)

// Richiesta ticket
// getInvoice: mesaagio di richiesta ricevuta dell'offerta pagata
// invoice: messaggio con la ricevuta del viaggio
( getInvoice: USERₓ -> ACME ; invoice: ACME -> USERₓ )*

```
## Verifica condizioni connectedness delle coreografie
<!--Analizzando la coreografia si nota che essa fa parte del caso asincrono. -->
Per stabilire la connectedness, e anche per una migliore lettura, la coreografia è stata divisa in 5 blocchi:
1. __Query dei voli__
2. __Ricezione offerte last-minute__
3. __Registrazione interesse dell'utente__
4. __Notifica dell'offerta all'utente__
5. __Conferma dell'offerta e pagamento__

Essendo queste sotto-coreografie eseguite in parallelo non ci sono condizioni da rispettare, pertanto, si è passati a valutare la corretteza di ogni singolo blocco.
#### Query dei voli
```fsharp
( queryFlights: ACME -> AIRₖ ; responseFlights: AIRₖ -> ACME )* 
```
E' connessa in quanto il ricevente in ___queryFlights___ è il mittente di ___responseFlights___.

#### Ricezione offerte last-minute
```fsharp
( sendLastMinute: AIRₖ -> ACME )*
```
Non è connessa, ma non è un problema in quanto ACME per scelta implementativa rimane in attesa di una richiesta.SBAGLIATO

#### Registrazione interesse dell'utente
```fsharp
( requestInterest: USERₓ -> ACME )* 
```
Non è connessa, ma non è un problema in quanto ACME per scelta implementativa rimane in attesa di una richiesta. SBAGLIATO

#### Notifica dell'offerta all'utente
```fsharp
( offerToken: ACME -> PTG ; notifyUser: PTG -> USERₓ )*
```
Non è connessa, ma non è un problema in quanto PTG  e USERₓ per scelta implementativa rimangono sempre in attesa di richieste.SBAGLIATO

#### Conferma dell'offerta e pagamento
```fsharp
( offerToken: ACME -> PTG ; notifyUser: PTG -> USERₓ )*
```
\
\
\
&nbsp;


## Proiezioni

### ACMEsky
```fsharp

```


















Semantica sincrona


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