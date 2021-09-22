
# Coreografie
In questa sezione vengono mostrate le coreografie che descrivono l'interazione tra i diversi attori.

## Nomenclatura

| Nome                | Sigla            | Commento                                |
| - | - | - |
| ACME                | ACME             |                                         |
| Airline service     | AIR<sub>k</sub>  | Indica la k-esima compagnia aerea       |
| Rental service      | RENT<sub>t</sub> | Indica la t-esima compagnia di noleggio |
| Prontogram          | PTG              |                                         |
| Bank service        | BANK             |                                         |
| Geodistance service | GEO              |                                         |
| User                | USER<sub>x</sub> | Indica l'x-esimo utente                 |

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
// repsponseLastMinute: risposta successo o fallimento
( sendLastMinute: AIRₖ -> ACME ; repsponseLastMinute: ACME -> AIRₖ )*
|

// Registrazione interesse dell'utente (ripetuta per tutti gli  utenti)
// requestInterest: messaggio di richiesta con A/R
// responseInterest: risposta successo o fallimento
( requestInterest: USERₓ -> ACME ; responseInterest: ACME -> USERₓ )* 
|   

// Notifica dell'offerta all'utente
// offerToken: mesaagio di offerta A/R
// notifyUser: messaggio di notifica di Prontogram
// notifyResponse: risposta da parte dell'utene dell'avvenuta ricezione
// messageSended: risposta da parte di prontogram dell'avvenuto invio
( offerToken: ACME -> PTG ; notifyUser: PTG -> USERₓ ; 
  notifyResponse: USERₓ -> PTG ; messageSended: PTG -> ACME )*
|

// Richiesta ticket
// getInvoice: mesaagio di richiesta ricevuta dell'offerta pagata
// invoice: messaggio con la ricevuta del viaggio
( getInvoice: USERₓ -> ACME ; invoice: ACME -> USERₓ )*
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
      requestPaymentLink: USERₓ -> ACME ;
      bookTickets: ACME -> AIRₖ ;
      (   
        // Tickets ok
        // bookTickets: prenota i biglietti 
        // responseTickets: biglietti prenotati
        // requestBankLink: richiesta creazione link di pagamento
        // responselink: link di pagamento generato dalla banca
        // paymentLink: link di pagamento generato dalla banca
        // payment: pagamento attraverso il link generato
        (
          responseTickets: AIRₖ -> ACME ;
          requestBankLink: ACME -> BANK ; 
          responselink: BANK -> ACME ;
          paymentLink: ACME -> USERₓ ;
          payment: USERₓ -> BANK ;
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
                  ( // Richiesta a Rent service se distanza <30Km
                    1 
                    +  
                    (
                      (
                        // requestDistanceRent: richiesta distanza noleggio
                        // responseDistanceRent: risposta con distanza
                        requestDistanceRent: ACME -> GEO ; 
                        responseDistanceRent: GEO -> ACME 
                      )* ;
                      // requestRentDeparture: richiesta noleggio andata
                      // responseRentDeparture: risposta nolleggio andata
                      // requestRentReturn: richiesta noleggio ritorno
                      // responseRentReturn: risposta nolleggio ritorno
                      requestRentDeparture: ACME -> RENTₜ ; 
                      responseRentDeparture: RENTₜ-> ACME ;
                      requestRentReturn: ACME -> RENTₜ ; 
                      responseRentReturn: RENTₜ-> ACME 
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
              unbookTickets: ACME -> AIRₖ ;
              emitCoupon: ACME -> BANK 
            )
          ) 
        )
        // Errore nella prenotazione dei biglietti
        // flightNotFound: volo non trovato
        // errorTickets: errore volo non disponibile
        +
        (
          flightNotFound: AIRₖ -> ACME ;
          errorTickets: ACME -> USERₓ
        )
      )
    )
    +
    // ACMEsky controlla l'offerta e non è più disponibile
    // responseOfferError: errore offerta
    responseOfferError: ACME -> USERₓ
  )
)*

```

&nbsp;

## Verifica condizioni connectedness delle coreografie

Analizzando la coreografia si nota che essa fa parte del caso asincrono.
Per stabilire la connectedness, e per una migliore lettura, la coreografia è stata divisa in 6 blocchi:

1. __Query dei voli__
2. __Ricezione offerte last-minute__
3. __Registrazione interesse dell'utente__
4. __Notifica dell'offerta all'utente__
5. __Richiesta della tickets dell'offerta__
5. __Conferma dell'offerta e pagamento__

Essendo queste sotto-coreografie eseguite in parallelo non ci sono condizioni da rispettare, pertanto, si è passati a valutare la corretteza di ogni singolo blocco.

#### Query dei voli

```fsharp
( queryFlights: ACME -> AIRₖ ; responseFlights: AIRₖ -> ACME )*
```
E' connessa per la sequenza in quanto il ricevente in ___queryFlights___ è il mittente di ___responseFlights___.
E' connessa anche per l'iterazione in quanto il ricevente in ___responseFlights___ è il mittente di ___queryFlights___.

#### Ricezione offerte last-minute

```fsharp
( sendLastMinute: AIRₖ -> ACME ; repsponseLastMinute: ACME -> AIRₖ )*
```
E' connessa in quanto il ricevente in ___sendLastMinute___ è il mittente di ___repsponseLastMinute___.
E' connessa anche per l'iterazione in quanto il ricevente in ___repsponseLastMinute___ è il mittente di ___sendLastMinute___.

#### Registrazione interesse dell'utente

```fsharp
( requestInterest: USERₓ -> ACME ; responseInterest: ACME -> USERₓ )* 
```
E' connessa in quanto il ricevente in ___requestInterest___ è il mittente di ___responseInterest___.
E' connessa anche per l'iterazione in quanto il ricevente in ___responseInterest___ è il mittente di ___requestInterest___.

#### Notifica dell'offerta all'utente

```fsharp
( offerToken: ACME -> PTG ; notifyUser: PTG -> USERₓ ; notifyResponse: USERₓ -> PTG ; messageSended: PTG -> ACME )*
```
E' connessa in quanto il ricevente in ___offerToken___ è il mittente di ___notifyUser___, il ricevente in ___notifyUser___ è il mittente di ___notifyResponse___, il ricevente in ___notifyResponse___ è il mittente di ___messageSended___.
E' connessa anche per l'iterazione in quanto il ricevente in ___messageSended___ è il mittente di ___offerToken___.

### Richiesta ricevuta dell'offerta

```fsharp
( getInvoice: USERₓ -> ACME ; invoice: ACME -> USERₓ )*
```
E' connessa in quanto il ricevente in ___getInvoice___ è il mittente di ___invoice___.
E' connessa anche per l'iterazione in quanto il ricevente in ___invoice___ è il mittente di ___getInvoice___.


### Conferma dell'offerta e pagamento

```fsharp
1. ( confirmOffer: USERₓ -> ACME ; 
```
E' connessa in quanto il ricevente di ___confirmOffer___ è il mittente di __(3)__ e di __(27)__.
```fsharp
2.   ( 
3.     ( responseOfferOk: ACME -> USERₓ ; requestPaymentLink: USERₓ -> ACME ; bookTickets: ACME -> AIRₖ
```
E' connessa per la sequenza in quanto il ricevente di ___responseOfferOk___ è il mittente di ___requestPaymentLink___, il ricevente di ___requestPaymentLink___ è il mittente di ___bookTickets___.
```fsharp
4.       (   
5.         (
6.           responseTickets: AIRₖ -> ACME ;
7.           requestBankLink: ACME -> BANK ; responselink: BANK -> ACME ;
8.           paymentLink: ACME -> USERₓ ;
9.           payment: USERₓ -> BANK ;
```
E' connessa per la sequenza in quanto il ricevente di ___responseTickets___ è il mittente di ___requestBankLink___, il ricevente di ___requestBankLink___ è il mittente di ___responselink___, il ricevente di ___responselink___ è il mittente di ___paymentLink___ e il ricevente di ___paymentLink___ è il mittente di ___payment___.

Inoltre, è connessa per la choice perché il destinatario di ___payment___ è il mittente di __(11)__ e di __(21)__

```fsharp
10.          ( 
11.            ( successPaymentBank: BANK -> ACME ;
```
E' connessa per la choice perché il destinatario di ___successPaymentBank___ è il mittente di __(13)__
```fsharp
12.              ( 1 + 
13.                ( requestDistance: ACME -> GEO ; responseDistance: GEO -> ACME ; 
```
E' connessa per la sequenza perché il destinatario di ___requestDistance___ è il mittente di ___responseDistance___.
E' connessa per la choice perché il destinatario di ___responseDistance___ è il mittente di __(14)__
```fsharp
14.                  ( 1 +  ( ( requestDistanceRent: ACME -> GEO ; responseDistanceRent: GEO -> ACME )* ; 
```
E' connessa per la sequenza perché il destinatario di ___requestDistanceRent___ è il mittente di ___responseDistanceRent___.
E' connessa per l'iterazione perché destinatario di ___responseDistanceRent___ è il mittente di ___requestDistanceRent___, quindi la coreografia può essere iterata.
```fsharp
15.                      requestRentDeparture: ACME -> RENTₜ ; responseRentDeparture: RENTₜ-> ACME ;
16.                      requestRentReturn: ACME -> RENTₜ ; responseRentReturn: RENTₜ-> ACME 
17                     )
18.                  )
19.                 )
20.               )
```
E' connessa per la sequenza perché il destinatario di ___responseDistanceRent___ è il mittente di ___requestRentDeparture___, il destinatario di ___requestRentDeparture___ è il mittente di ___responseRentDeparture___, il destinatario di ___responseRentDeparture___ è il mittente di ___requestRentReturn___ e il destinatario di requestRentReturn è il mittente di ___responseRentReturn___.
```fsharp
21.             ) + ( errorPaymentBank: BANK -> ACME ; 
22.                   unbookTickets: ACME -> AIRₖ ; unbookTicketsResponse: AIRₖ -> ACME ; 
23.                   emitCoupon: ACME -> BANK ; emitCouponResponse: BANK -> ACME
                )
```
E' connessa per la sequenza perché il destinatario di ___errorPaymentBank___ è il mittente di ___unbookTickets___, il destinatario di ___unbookTickets___ è il mittente di ___unbookTicketsResponse___, il destinatario di ___emitCoupon___ è il mittente di ___emitCouponResponse___.

```fsharp
24.           )
25.         ) + ( flightNotFound: AIRₖ -> ACME ; errorTickets: ACME -> USERₓ )
```
E' connessa per la choice perchè i mittenti di __(6)__ e di __(25)__ sono gli stessi.
E' connessa per la sequenza perché il destinatario di ___flightNotFound___ è il mittente di ___errorTickets___.
```fsharp
26.       )
27.     ) + responseOfferError: ACME -> USERₓ
28.   ) 
```
E' connessa per la choice i sender di __(3)__ e di __(27)__ sono gli stessi.
```fsharp
29. )*
```

La coreografia è connessa per l'iterazione in quanto __(25)__ e __(27)__ terminano con il ricevente __USER__ che è il mittente di __(1)__, mentre __(24)__ termina con __ACME__ che è connessa con __(1)__ secondo il pattern Receiver.

&nbsp;

## Proiezioni

### ACMEsky

```fsharp
proj(QueryDeiVoli, ACME) = 
    ____________
  ( queryFlights@AIRₖ ; responseFlights@AIRₖ )*
```
```fsharp
proj(RicezioneOfferteLastMinute, ACME) = 
                          __________________
  ( sendLastMinute@AIRₖ ; repsponseLastMinute@AIRₖ )*
```
```fsharp
proj(RegistrazioneInteresse, ACME) = 
                            ________________
  ( requestInterest@USERₓ ; responseInterest@USERₓ )*
```
```fsharp
proj(NotificaOfferta, ACME) = 
    __________
  ( offerToken@PTG ; 1 ; 1 ; messageSended@PTG )*
```
```fsharp
proj(RichiestaRicevuta, ACME) = 
                       _______
  ( getInvoice@USERₓ ; invoice@USERₓ )*
```
```fsharp
proj(AcquistoOfferta, ACME) = 
  ( confirmOffer@USERₓ ; 
    (                                                     ___________
      (responseOfferOk@USERₓ ; requestPaymentLink@USERₓ ; bookTickets@AIRₖ
        (
          ( 
            responseTickets@AIRₖ ;
            ______________
            requestBankLink@BANK ; responselink@BANK ;
            ___________
            paymentLink@USERₓ ; 1 ;
            (
              (
                successPaymentBank@BANK ;
                        _______________
                ( 1 + ( requestDistance@GEO ; responseDistance@GEO ;
                            ___________________
                  ( 1 + ( ( requestDistanceRent@GEO ; responseDistanceRent@GEO )* ;
                    ____________________
                    requestRentDeparture@RENTₜ ; responseRentDeparture@RENTₜ ;
                    _________________
                    requestRentReturn@RENTₜ ; responseRentReturn@RENTₜ
                  ) )
                ) ) _____________        __________
              ) + ( unbookTickets@AIRₖ ; emitCoupon@BANK )
            )
                                  ____________
          ) + flightNotFound@AIRₖ errorTickets@USERₓ 
        )
          __________________
      ) + responseOfferError@USERₓ
    )
  )*
```

### Utente

```fsharp
proj(QueryDeiVoli, USERₓ) = 
  ( 1 ; 1 )*
```
```fsharp
proj(RicezioneOfferteLastMinute, USERₓ) = 
  ( 1 ; 1 )*
```
```fsharp
proj(RegistrazioneInteresse, USERₓ) = 
    _______________
  ( requestInterest@ACME ; responseInterest@ACME )*
```
```fsharp
proj(NotificaOfferta, USERₓ) = 
                         ______________
  ( 1 ; notifyUser@PTG ; notifyResponse@PTG ; 1 )*
```
```fsharp
proj(RichiestaRicevuta, USERₓ) = 
    __________
  ( getInvoice@ACME ; invoice@ACME )*
```
```fsharp
proj(AcquistoOfferta, USERₓ) = 
    ____________
  ( confirmOffer@ACME ; 
    (                          __________________
      ( responseOfferOk@ACME ; requestPaymentLink@ACME ; 1 ;
        (
          ( 1 ; 1 ; 1 ; paymentLink@ACME ; payment@BANK ;
            (
              (
                1 ;
                ( 1 + ( 1 ; 1 ;
                  ( 1 + (( 1 ; 1)* ; 1 ; 1 ; 1 ; 1 ))
                ))
              ) + ( 1 ; 1 )
            )
          ) + ( 1 ; errorTickets@ACME )
        )
      ) + responseOfferError@ACME
    )
  )*
```

### Airline service

```fsharp
proj(QueryDeiVoli, AIRₖ) = 
                        _______________
  ( queryFlights@ACME ; responseFlights@ACME )*
```
```fsharp
proj(RicezioneOfferteLastMinute, AIRₖ) = 
    ______________
  ( sendLastMinute@ACME ; repsponseLastMinute@ACME )*
```
```fsharp
proj(RegistrazioneInteresse, AIRₖ) = 
  ( 1 ; 1 )*
```
```fsharp
proj(NotificaOfferta, AIRₖ) = 
  ( 1 ; 1 ; 1 ; 1 )*
```
```fsharp
proj(RichiestaRicevuta, AIRₖ) =
  ( 1 ; 1 )*
```
```fsharp
proj(AcquistoOfferta, AIRₖ) =
  ( 1 ; 
    (
      (1 ; 1 ; bookTickets@ACME ;
        (
          ( _______________
            responseTickets@ACME ;
            1 ; 1 ; 1 ; 1 ;
            (
              ( 1 ;
                ( 1 + ( 1 ; 1 ;
                  ( 1 + (( 1 ; 1)* ; 1 ; 1 ; 1 ; 1 ))
                ))
              ) + ( unbookTickets@ACME ; 1 )
            )   _______________
          ) + ( responseTickets@ACME ; 1 )
        )
      ) + 1
    )
  )*
```

### Prontogram

```fsharp
proj(QueryDeiVoli, PTG) = 
  ( 1 ; 1 )*
```
```fsharp
proj(RicezioneOfferteLastMinute, PTG) =
  ( 1 ; 1 )*
```
```fsharp
proj(RegistrazioneInteresse, PTG) = 
  ( 1 ; 1 )*
```
```fsharp
proj(NotificaOfferta, PTG) = 
                      __________
  ( offerToken@ACME ; notifyUser@USERₓ ; 
                           _____________
    notifyResponse@USERₓ ; messageSended@ACME )*
```
```fsharp
proj(RichiestaRicevuta, PTG) =
  ( 1 ; 1 )*
```
```fsharp
proj(AcquistoOfferta, PTG) = 
  ( 1 ; 
    (
      ( 1 ; 1 ; 1 ;
        (
          ( 1 ; 1 ; 1 ; 1 ; 1 ;
            (
              ( 1 ;
                ( 1 + ( 1 ; 1 ;
                  ( 1 + (( 1 ; 1)* ; 1 ; 1 ; 1 ; 1 ))
                ))
              ) + ( 1 ; 1 )
            )
          ) + ( 1 ; 1 )
        )
      ) + 1
    )
  )*
```

### Bank service

```fsharp
proj(QueryDeiVoli, BANK) = 
  ( 1 ; 1 )*
```
```fsharp
proj(RicezioneOfferteLastMinute, BANK) = 
  ( 1 ; 1 )*
```
```fsharp
proj(RegistrazioneInteresse, BANK) = 
  ( 1 ; 1 )*
```
```fsharp
proj(NotificaOfferta, BANK) = 
  ( 1 ; 1 ; 1 ; 1 )*
```
```fsharp
proj(RichiestaRicevuta, BANK) = 
  ( 1 ; 1 )*
```
```fsharp
proj(AcquistoOfferta, BANK) = 
  ( 1 ; 
    (
      ( 1 ; 1 ; 1 ;
        (
          (                            ____________
            1 ; requestBankLink@ACME ; responselink@ACME ; 
            1 ; payment@USERₓ ;
            (
              ( __________________
                successPaymentBank@ACME ;
                        _______________
                ( 1 + ( 1 ; 1 ;
                  ( 1 + (( 1 ; 1)* ; 1 ; 1 ; 1 ; 1 ))
                ))
              ) + ( 1 ; emitCoupon@ACME )
            )
          ) + ( 1 ; 1 )
        )
      ) + 1
    )
  )*
```

### Geographical Distance service

```fsharp
proj(QueryDeiVoli, GEO) = 
  ( 1 ; 1 )*
```
```fsharp
proj(RicezioneOfferteLastMinute, GEO) = 
  ( 1 ; 1 )*
```
```fsharp
proj(RegistrazioneInteresse, GEO) = 
  ( 1 ; 1 )*
```
```fsharp
proj(NotificaOfferta, GEO) = 
  ( 1 ; 1 ; 1 ; 1 )*
```
```fsharp
proj(RichiestaRicevuta, GEO) = 
  ( 1 ; 1 )*
```
```fsharp
proj(AcquistoOfferta, GEO) = 
  ( 1 ; 
    (
      ( 1 ; 1 ; 1 ;
        (
          ( 1 ; 1 ; 1 ; 1 ; 1 ;
            (
              ( 1 ;
                                               ________________
                ( 1 + ( requestDistance@ACME ; responseDistance@ACME ;
                                                      ____________________
                  ( 1 + (( requestDistanceRent@ACME ; responseDistanceRent@ACME )* ; 
                    1 ; 1 ; 1 ; 1 ))
                ))
              ) + ( 1 ; 1 )
            )
          ) + ( 1 ; 1 )
        )
      ) + 1
    )
  )*
```

### Rental Service

```fsharp
proj(QueryDeiVoli, RENTₜ) = 
  ( 1 ; 1 )*
```
```fsharp
proj(RicezioneOfferteLastMinute, RENTₜ) = 
  ( 1 ; 1 )*
```
```fsharp
proj(RegistrazioneInteresse, RENTₜ) = 
  ( 1 ; 1 )*
```
```fsharp
proj(NotificaOfferta, RENTₜ) = 
  ( 1 ; 1 ; 1 ; 1 )*
```
```fsharp
proj(RichiestaRicevuta, RENTₜ) = 
  ( 1 ; 1 )*
```
```fsharp
proj(AcquistoOfferta, RENTₜ) = 
  ( 1 ; 
    (
      ( 1 ; 1 ; 1 ;
        (
          ( 1 ; 1 ; 1 ; 1 ; 1 ;
            (
              ( 1 ;
                ( 1 + ( 1 ; 1 ;  
                  ( 1 + (( 1 ; 1)* ; 
                                                _____________________
                    requestRentDeparture@ACME ; responseRentDeparture@ACME ;
                                             __________________
                    requestRentReturn@ACME ; responseRentReturn@ACME ))
                ))
              ) + ( 1 ; 1 )
            )
          ) + ( 1 ; 1 )
        )
      ) + 1
    )
  )*
```

&nbsp;
<div class="page-break"></div>
