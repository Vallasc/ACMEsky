---
stylesheet: https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/2.10.0/github-markdown.min.css
body_class: markdown-body
css: |-
  .page-break { page-break-after: always; }
  .markdown-body { font-size: 14px; }
  .markdown-body pre > code { white-space: pre-wrap; }
  .hidden { display: none }
pdf_options:
  format: a4
  margin: 25mm 15mm
  printBackground: true
---

\
\
\
\
\
\
\
&nbsp;

<div align="center" style="font-size: 16px">
Università di Bologna
</div>

\
\
\
&nbsp;
<div align="center" style="font-size: 22px">
Progetto di Ingegneria del Software Orientata ai Servizi
</div>

&nbsp;

<div align="center" style="font-size: 22px">
ACMEsky
</div>

\
\
\
\
\
\
&nbsp;
<div align="center" style="font-size: 16px">
Baratin Riccardo
</div>
<div align="center" style="font-size: 16px">
Di Ubaldo Andrea
</div>
<div align="center" style="font-size: 16px">
Vallorani Giacomo
</div>

\
\
\
\
\
\
&nbsp;
<div align="center" style="font-size: 14px">
Anno ccademico 2020/2021
</div>

&nbsp;
<div class="page-break"></div>

# ACMEsky
Progetto di Ingegneria del Software Orientata ai Servizi A.A. 2020/2021

La documentazione web è disponibile al link https://vallasc.github.io/ACMEsky/docs/

## Descrizione del dominio e del problema
ACMESky offre un servizio che permette ai clienti di specificare, attraverso un portale web, il proprio interesse a trasferimenti aerei di andata e ritorno che si tengano in un periodo definito e ad un costo inferiore ad un certo limite impostato.

ACMESky quotidianamente interroga le compagnie aeree per ottenere le quotazioni dei voli di interesse per i propri clienti.

ACMESky riceve anche offerte last-minute dalle compagnie che le inviano al momento dell’attivazione senza cadenza prefissata.

Quando ACMESky trova un volo compatibile con una richiesta di un cliente prepara un’offerta.

L’offerta viene inviata al cliente tramite l’App di messaggistica Prontogram. Il cliente, se interessato, ha quindi 24 ore di tempo per connettersi al portale web di ACMESky per confermare l’offerta, specificandone il codice ricevuto via Prontogram.

In fase di conferma il cliente deve anche procedere al pagamento, per la gestione del quale ACMESky si appoggia ad un fornitore di servizi bancari: ACMESky reindirizza il cliente verso il sito del fornitore e quindi attende dal fornitore il messaggio che conferma l’avvenuto pagamento.

Nel caso in cui il costo del volo risulti essere superiore ai 1000 euro ACMESky offre al cliente un servizio gratuito di trasferimento da/verso l'aeroporto se questo si trova entro i 30 chilometri dal suo domicilio.

In questo caso ACMESky fa uso di diverse compagnie di noleggio con autista con cui ha degli accordi commerciali. La compagnia scelta è quella che risulta avere una sede più vicina al domicilio del cliente. A tale compagnia ACMESky invia una richiesta per prenotare un trasferimento che parta due ore prima dell’orario previsto per il decollo del volo.

## Vincoli aggiuntivi
Durante il design del sistema sono stati aggiunti dei vincoli per raffinare le specifiche del progetto.
- Ogni attore deve essere autenticato e autorizzato per poter interagire con ACMEsky;
- I voli delle offerte generate provengono dalla stessa compagnia aerea;
- La compagnia aerea restituisce una lista di voli (non necessariamente A/R);
- Non viene gestito lo scambio di denaro dalla banca alla compagnia aerea; 
- Se uno dei servizi per la gestione del calcolo premium non risponde i voli vengono acquistati senza servizi accesori.

## Servizi implementati
- **ACMEsky**: Servizio che genera offerte di voli A/R in base agli interssi degli utenti. 
- **Airline Service**: Compagnia aerea.
- **Bank Service**: Gestore dei pagamenti.
- **Prontogram**: App  di messaggistica.
- **GeoDistance Service**: Servizio per il calcolo delle distanze geografiche.
- **Rent Service**: Servizio di noleggio con conducente.

<div class = "hidden" >

## Struttura della documentazione
* [Home](/README.md)
* [Coreografie](docs/coreografie.md)
* [Diagramma BPMN](docs/BPMN.md)
* [Coreografie BPMN](docs/coreografieBPMN.md)
* [Diaramma UML](docs/UML.md)
* [Struttura](docs/struttura.md)
* [Esecuzione](docs/esecuzione.md)
* Servizi
    * ACMEsky
        * [Service](src/ACMEskyService/README.md)
        * [Database](src/ACMEskyDB/README.md)
        * [Web](src/ACMEskyWeb/README.md)
    * [AirlineService](src/AirlineService/README.md)
    * [BankService](src/BankService/README.md)
    * [Prontogram](src/Prontogram/README.md)
    * [RentService](src/RentService/README.md)
    * [GeographicalDistance](src/GeographicalDistanceService/README.md)

</div>

<div class="page-break"></div>


# Struttura della documentazione
* [Coreografie](#coreografie)
* [Diagrammi BPMN](#diagramma-bpmn)
* [Coreografie BPMN](#diagramma-delle-coreografie-bpmn)
* [Diagrammi UML](#diagrammi-uml)
* [Struttura](#struttura-del-sistema)
* [Esecuzione](#istruzioni-per-lesecuzione-dello-stack-di-servizi)
* Servizi
    * ACMEsky
        * [Service](#acmesky-service)
        * [Database](#acmesky-database)
        * [Web](#acmesky-web)
    * [Airline Service](#airline-service)
    * [Bank Service](#bank-service)
    * [Prontogram](#prontogram)
    * [Rental Service](#rental-service)
    * [GeographicalDistance Service](#geographical-distance-service)

<div class="page-break"></div>

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

# Diagramma BPMN
In questa sezione della documentazione viene descritto il diagramma BPMN che rappresenta il comportamento dei processi
per ciò che concerne il flusso di controllo.

## Diagramma completo
![total](bpmn/img/Total.png)

 Per una migliore specificità e gestione della documentazione il diagramma verrà diviso in parti relative alle varie azioni degli attori, come ad esempio: la registrazione dell'interesse utente, la ricerca dei voli, salvataggio dei voli last-minute, gestione delle offerte, pagamento, ecc.

## Ricerca dei voli

![search_flights](bpmn/img/SearchFlights.png)

La ricerca dei voli alle Airline Services viene ripetuta ad un certo intervallo di tempo, per evitare sovraccaricare i sistemi. Per questo, i voli delle offerte di interesse degli utenti vengono salvati sul DB e, in seguito, vengono utilizzati per cercare i voli delle compagnie aeree. L'intervallo di tempo è variabile da 1 ora a pochi minuti poichè si cerca un compromesso tra un sistema efficiente e un sistema che non faccia aspettare troppo l'utente.

Quindi, ad un certo intervallo e per ciascun __Airline Service__, __ACMEsky__ recupera i voli di interesse degli utenti dal suo database ed effettua una ricerca mirata dei voli compatibili con essi. 
I voli presenti nella risposta vengono salvati all'interno del database (tabella _available_flights_). 
Se il timer della richiesta scade, per eventuali errori dovuti ad __Airline Service__, il sottoprocesso termina e si passa ad un'altra compagnia aerea.


## Registrazione delle offerte last-minute

![registrazione_voli_last-minute](bpmn/img/SaveLast-minute.png)

In questa parte si descrive il processo di ricezione e salvataggio dei voli last-minute. I servizi di __Airline Service__ mandano voli last-minute appena generati ad __ACMEsky__, la quale salva ciascuno di essi nel database, nello specifico nella tabella _available_flights_.


## Match voli con interesse utente

![matching tra voli e voli di interesse](bpmn/img/Flights-InterestMatching.png)

La generazione delle offerte di volo viene fatta ad un certo intervallo di tempo, ciò consente di non sovraccaricare il sistema e di evitare problemi di concorrenza con altri processi che generano le offerte. Per questo motivo, i voli delle offerte di interesse degli utenti vengono salvati sul database finchè non vengono processati per generare le offerte corrispondenti. L'intervallo di tempo è variabile da un'ora a pochi minuti poichè si cerca un compromesso tra un sistema efficiente e un sistema che non faccia aspettare l'utente.

Ogni ora, per ciascun offerta di interesse, __ACMEsky__ cerca tra i voli disponibili presenti nel database (tabella _available_flights_), se c'è una corrispondenza con i voli di interesse degli utenti (tabella _flights_interest_), allora prepara l'offerta, la salva nel database e la invia all'utente attraverso l'app di messaggistica __Prontogram__. In caso negativo semplicemente il sotto-processo termina passando all'interesse successivo.


## Registrazione dell'interesse dell'utente

![register_user_interest](bpmn/img/RegisterUserInterest.png)

Il seguente diagramma descrive il processo di raccolta e registrazione degli interessi degli utenti. L'utente descrive i suoi voli di interesse specificando: città/aereoporto di partenza, città/aereoporto di arrivo, data di partenza, data ritorno e quota massima di spesa.
__ACMEsky__ salva i voli di interesse nel suo database, in particolare, nella tabella _flights_interest_ e in _users_interests_, quest'ultima contiene i voli di interesse per uno specifico viaggio. 
Infine, __ACMEsky__ invia la conferma di avvenuta creazione.


## Conferma di acquisto, applicazione servizi premium e preparazione biglietti

![user_purchase_offer](bpmn/img/UserPurchaseOffer.png)

In questa parte del diagramma viene illustrata la conferma di acquisto dell'offerta da parte dell'utente, l'acquisto dell'offerta e l'applicazione dei servizi premium se l'offerta rispetta le caratteristiche necessarie. 
Infine, viene preparato il biglietto che poi l'utente potrà scaricare. 

Per una magiore comprensione il diagramma è stato diviso in blocchi più piccoli.

### Conferma dell'offerta da parte dell'utente

![confirm_user_offer](bpmn/img/ConfirmOffer.png)

L'app di __Prontogram__ notifica l'utente del fatto che c'è un'offerta disponibile.

L'utente riceve l'offerta e può decidere se confermarla o meno attraverso l'invio di un token legato all'offerta stessa. 

__ACMEsky__ recupera l'offerta corrispondente al token e si occupa di verificarne la validità, ovvero, di controllare che il tempo di accettazione dell'offerta non sia terminato. In caso positivo si verifica se l'offerta non sia scaduta e anche in questo caso se l'esito è positivo si invia all'utente la conferma di accettazione dell'offerta.
In caso contrario lo si informa dell'esito negativo dovuto alla scadenza dell'offerta o del token non valido ed il processo termina con un errore.

### Pagamento dell'offerta

![book_payment](bpmn/img/BookPayment.png)

Il sottoprocesso inizia con la richiesta, da parte dell'utente, di pagamento del biglietto relativo all'offerta accettata. __ACMEsky__ a questo punto si prende l'onere di prenotare i biglietti facendone richiesta all'__Airline Service__ che fornisce i voli dell'offerta. Se c'è un errore relativo all'impossibilità di prenotare l'offerta, poichè al servizio di airline risulta che l'offerta sia già stata acquistata o per qualsiasi altro problema, si invia un messaggio di errore all'utente ed il processo termina. 

Se la prenotazione va a buon fine, __ACMEsky__ chiederà il link di pagamento a __Bank Service__, la quale glielo invierà in risposta a meno di errori nel processo di pagamento. Successivamente, il link viene inoltrato all'utente che procederà al pagamento sulla piattaforma di __Bank Service__. Infine, __Bank Service__ comunica l'esito ad __ACMEsky__ che proseguirà nel sottoprocesso dei servizi premium.
Se il servizio della banca non risponde entro 5 minuti dalla generazione del link si procede, in via preventiva, alla compensazione dei biglietti e del pagamento. In questo caso il processo termina con errore.

### Servizi premium

![premium_service](bpmn/img/PremiumService.png)

In questa fase del processo di conferma, a condizioni rispettate, vengono applicati all'offerta i servizi premium. Inizialmente __ACMEsky__ controlla il prezzo dell'offerta, se questo supera i 1000€ invia una richiesta al servizio di __GeoDistance__ per calcolare la distanza dell'utente dall'areoporto. Nel caso in cui la distanza sia superiore ai 30 km si richiede al __Rent Service__ più vicino se c'è la possibilità di offrire all'utente un trasferimento dal suo domicilio all'aereoporto. Questa operazione viene ripetuta sia all'andata che al ritorno, e in tal caso verranno modificati i biglietti includendo le informazioni dei trasferimenti. Nel caso in cui distanza sia inferiore ai 30Km o il prezzo dell'offerta sia inferiore a 1000€ non verrà applicato nessun servizio.


## Preparazione dei biglietti

![prepare_tickets](bpmn/img/PrepareTickets.png)

Arrivati a questo punto viene cambiato lo stato dell'offerta e viene preparato il pdf contenente i biglietti che l'utente potrà scaricare. L'utente può in qualunque momento richiedere i biglietti che ha acquistato.


## Rimozione dei voli scaduti

![removing_expired_flights](bpmn/img/RemovingExpiredFlights.png)

Il processo di cancellazione dei voli scaduti presenti nel database avviene ogni 12 ore. I voli scaduti sono quei voli la cui data di scadenza è antecedente a quella in cui si effettua l'operazione di cancellazione. La cancellazione non comporta l'eliminazione effettiva del record che rappresenta quel volo, bensì un cambiamento di stato che porta ACMEsky a non considerare più quel volo come disponibile.


## Rimozione delle offerte scadute

![removing_expired_offers](bpmn/img/RemovingExpiredOffers.png)

Il processo di cancellazione delle offerte scadute presenti nel Database avviene ogni 12 ore. Le offerte di volo scadute comprendono i voli di andata e ritorno. Le offerte scadute sono quelle la cui data di scadenza del volo di partenza è antecedente a quella in cui si effettua l'operazione di cancellazione. La cancellazione non comporta l'eliminazione effettiva del record, bensì, un cambiamento di stato che porta ACMEsky a non considerare più i voli dell'offerta (e l'offerta in sè) come disponibili.


&nbsp;
<div class="page-break"></div>

# Diagramma delle coreografie BPMN
In questa sezione vengono mostrate le coreografie BPMN che mostrano le interazioni tra i processi relativi ai diversi
partecipanti.

## Diagramma completo

![Coreografia completa](coreografie_bpmn/img/diagram_all.png)

Il diagramma è stato suddiviso in parti per poterle spiegare singolarmente.

## Salvataggio degli interessi

![Invio interesse](coreografie_bpmn/img/send_interest.png)

La coreografia descrive come l'utente e *ACMEsky* interagiscono nello scenario dell'invio degli interessi. L'utente manda una User Interest, mentre ACMEsky risponde con un messaggio di corretto inserimento o di errore.


## Ricerca dei voli di interesse

![Ricerca dei voli](coreografie_bpmn/img/search_flights.png)

La coreografia descrive l'interazione tra *ACMEsky* e *Airline Service* al fine di cercare i voli che hanno una corrispondenza con quelli richiesti dagli utenti. Ogni ora e per ciascuna *Airline Service* registrata al servizio, *ACMEsky* recupera i voli di interesse degli utenti  e effettua una richiesta all'*Airline Service* che restituisce la lista dei voli disponibili.


## Ricezione dei voli last-minute

![Ricezione voli last-minute](coreografie_bpmn/img/last_minute.png)

La coreografia descrive come *ACMEsky* e *Airline Service* interagiscono nello scenario della ricezione e salvataggio dei voli last-minute. *Airline Service* invia i voli last-minute ad ACMEsky che risponde con un messaggio di corretto inserimento o di errore.


## Generazione dell'offerta

![Generazione offerta](coreografie_bpmn/img/make_offer.png)

La coreografia mostra come *ACMEsky*, *Prontogram* e l'utente si relazionano al fine di notificare l'utente della corretta generazione dell'offerta. Ogni ora, se ci sono delle nuove offerte per l'utente, *ACMEsky* manda un messaggio a *Prontogram* che a sua volta risponde con un messaggio di corretto inserimento o di errore. Successivamente *Prontogram* manda una notifica all'utente.


## Conferma e acquisto dell'offerta

![Conferma e acquisto](coreografie_bpmn/img/confirm_pay_offer.png)

La coreografia descrive come l'utente, *ACMEsky*, *Bank Service*, *Airline Service*, *GeoDistance Service* e *Rent Service* interagiscono nel contesto della conferma e acquisto dell'offerta di volo da parte dell'utente. Quest'ultimo, conferma la volontà di voler acquistare l'offerta proposta inserendo il token ricevuto tramite l'app di Prontogram nel portale web di *ACMEsky*, il quale risponde con un messaggio di corretto inserimento o di errore. 

*ACMEsky* verifica che l'offerta sia ancora valida, se non lo è il flusso termina. Altrimenti, il processo continua fino alla sotto-coreografia, in cui l'utente passa il token dell'offerta ed il suo indirizzo per richiedere il pagamento, che deve svolgere entro cinque minuti (pena la fine del processo). 
*ACMEsky* recupera l'offerta corrispondente al token ed effettua una richiesta ad *Airline Service* che gli restituisce i biglietti. Se l'offerta è ancora disponibile per l'acquisto *ACMEsky* procede con il recupero del link del pagamento mandando un messaggio a *Bank Service* fornendo i dettagli dell'offerta. La banca restituirà ad *ACMEsky* il link che successivamente verrà inviato all'utente. 
Se l'utente non effettua il pagamento tramite il link fornitogli entro cinque minuti il processo termina.

Se il prezzo dell'offerta è superiore a 1000€, *ACMEsky* calcolerà la distanza tra l'indirizzo dell'utente e quello dell'aereoporto di partenza, inviando i rispettivi indirizzi al servizio per il calcolo delle distanze che restituirà la distanza tra i due punti.
Se questa è superiore ai 30Km, *ACMEsky* si servirà nuovamente di *GeoDistance Service* per trovare la compagnia di noleggio più vicina.
Infine, viene prenotato il trasporto per l'andata e per il ritono dall'areoporto attraverso la *Rent Service* individuata.


## Recupero del biglietto

![Recupero del biglietto](coreografie_bpmn/img/request_ticket.png)

La coreografia descrive come l'utente richiede ad *ACMEsky* il biglietto precedentemente acquistato. L'utente specifica il biglietto al quale è interessato inviando il codice dell'offerta. Successivamente *ACMEsky* recupera il biglietto corrispondente all'offerta in formato PDF.

&nbsp;
<div class="page-break"></div>

# Diagrammi UML

In questa sezione vengono mostrati i diagrammi UML, il cui scopo principale è quello di descrivere le interazioni che vi sono tra i vari servizi che fanno parte della *SOA* (Service Oriented Architecture), attraverso l'utilizzo di ***capability*** e ***interface***. I diagrammi sono stati implementati utilizzando il profilo TinySOA.

Nei diagrammi UML sono riportate tre diverse tipologie di servizi:
* __Task__: espone le ***capability*** facenti parte dei processi interni all'organizzazione;
* __Entity__: fa riferimento ad una singola attività, possibilmente automatizzata;
* __Utility__: sono simili ai task, però non appartengono al dominio del problema.

## Ricerca voli
![Ricerca voli](uml/img/diagram1.png)
Nel diagramma riportato qui sopra vengono descritte le ***capabilty*** inerenti alla ricerca voli. In particolare, per il ruolo di ACMESky sono definite le seguenti ***capability***: ***FlightsManagement*** e ***DatabaseManagement***; Le quali vengono esposte da due interfacce ***Flights*** e ***Database***.
La capability ***FlightsManagement*** ha lo scopo di interrogare e ricevere le offerte di voli dalle compagnie aeree. Mentre, la capability ***DatabaseManagement*** si occupa di salvare le offerte ricevute dalle compagnie aeree nella base dati.

## Ricezione offerte last-minute
![Ricezione offerte last-minute](uml/img/diagram2.png)
Nel diagramma riportato qui sopra vengono descritte le capabilty inerenti alla ricezione delle offerte last-minute. In particolare per il ruolo di ACMESky sono definite le seguenti ***capability***: ***LastminuteFlightsManagement*** e ***DatabaseManagement***; Le quali vengono esposte da due interfacce ***LastMinuteFlights*** e ***DataBase***.
La capability ***FlightsManagement*** ha lo scopo di ricevere le offerte dei voli last-minute dalle compagnie aeree. Quest'ultime verranno poi memorizzate nella base dati  attraverso la capability ***DatabaseManagement***.

## Controllo periodico dei voli compatibili con gli interessi degli utenti 
![Controllo periodico dei voli compatibili con gli interessi degli utenti](uml/img/diagram3.png)
Nel diagramma riportato qui sopra vengono descritte le capabilty inerenti alla ricezione delle offerte last-minute. In particolare per il ruolo di ACMESky sono definite le seguenti ***capability***: ***MatchingFlightsManagement*** e ***DatabaseManagement***; Le quali vengono esposte da due interfacce ***HourlyMatchFlights*** e ***DataBase***.
La capability ***MatchingFlightsManagement***, dopo avere reperito i voli dalla base dati attraverso ***DatabaseManagement***, ha lo scopo di trovare l'offerta compatibile con quella di interesse per l'utente. Inoltre la capability ***MatchingFlightsManagement*** dipende dalla capability di invio messaggi di Prontogram, ***MessageManagement*** esposta dalla relativa interfaccia: ***Message***.
Per contattare l'utente la capability di Prontogram (***MessageManagement***) dipende da un'altra capability ***NotifyMessage*** la quale ha lo scopo di segnalare all'utente la presenza di nuovi voli attraverso un messaggio di notifica.

## Invio richiesta del volo da parte dell'utente
![Utente invia la richiesta di volo](uml/img/diagram4.png)
Nel diagramma riportato qui sopra vengono descritte le capabilty inerenti all'invio da parte di un utente della richiesta di un volo.
In particolare per il ruolo di ACMESky sono definite le seguenti ***capability***: ***UserInterestManagement*** e ***DatabaseManagement***; Le quali vengono esposte da due interfacce rispettivamente ***UserInterest*** e ***DataBase***.
In particolare la capability ***UserInterestManagement*** si occupa di ricevere la richiesta di un volo da parte di un utente esponendo quindi una dipendenza per la capability ***UserRequestManagment***, la quale ha lo scopo di inviare la richiesta dell'utente.
Invece, la capability ***DatabaseManagement*** si occupa di salvare la richiesta nella base dati di ACMESky.


## Controllo dell'offerta con token
![Controllo offerta con token](uml/img/diagram5.png)
Nel diagramma riportato qui sopra vengono descritte le capabilty inerenti al controllo dell'offerta di interesse attraverso l'utilizzo del token inviato dall'utente.
In particolare per il ruolo di ACMESky sono definite le seguenti ***capability***: ***TokenManagement*** e ***DatabaseManagement***; Le quali vengono esposte da due interfacce rispettivamente ***ReceiveToken*** e ***DataBase***.
Queste capability permettono al sistema di ricevere il token da parte di un utente, verificare la correttezza del token ricevuto e reperire la relativa
offerta dalla base dati di ACMESky.
 La capability ***TokenManagement*** dipende dalle interfacce che espongono la capability ***TokenManagement*** dell'utente per poter verificare la validità del codice inserito.

## Gestione dei pagamenti
![Gestione dei pagamenti](uml/img/diagram6.png)
Nel diagramma riportato qui sopra vengono descritte le capabilty inerenti alla gestione dei pagamenti effettuati dall'utente indirizzati ai vari servizi.
In particolare per il ruolo di ACMESky sono definite le seguenti ***capability***: ***BankManagement*** e ***TicketsManagement***; Le quali vengono esposte da un'unica interfaccia ***Bank*** e ***Tickets***.
La capability ***BankManagement*** di ACMESky si occupa di ricevere il link di pagamento dalla banca e di inviarlo all'utente. Quest'ultima riceve anche tutte le informazioni relative ad un avvenuto pagamento.
La capability ***TicketsManagement*** si occupa di prenotare il volo o di eliminare la prenotazione in caso di errori.

## Servizi accessori e ricezione tickets 
![Servizi accessori e ricezione tickets ](uml/img/diagram7.png)
Nel diagramma riportato qui sopra vengono descritte le capabilty inerenti ai servizi accessori e ricezione dei tickets di interesse.
In particolare per il ruolo di ACMESky sono definite le seguenti ***capability***: ***PremiumServiceManagement*** e ***OrderManagement***; Le quali vengono esposte da un'unica interfaccia ***PremiumService*** e ***Order***.
La capability ***PremiumServiceManagement*** si occupa di controllare tutte le condizioni per poter attivare il servizio premium, ossia controlla il prezzo dell'offerta, la distanza dall'aeroporto e l'eventuale prenotazione di un servizio di trasporto.
Infine la capability ***OrderManagement*** ha il compito di inviare i tickets richiesti dall'utente.

&nbsp;
<div class="page-break"></div>

# Struttura del sistema

In questa sezione si presenta la struttura interna di ACMEsky.

![struttura acmesky](struttura/structure1.png)

ACMEsky è stato sviluppato utilizzando *Java Enterprise Edition*. Per il deployment si è scelto *WildFly*, un application server open source multipiattaforma.
Come BPMS si è optato per *Camunda* che fornisce un deployment già configurato per *WildFly*.
I dati vengono gestiti da un database esterno al sistema.


ACMEsky, internamente, è stato suddiviso in più moduli che rispecchiano la struttura del codice, ognuno dei quali svolge un ruolo specifico nel sistema. Essi sono:

- **Camunda Delegate**: Sono le classi Java che implementano le funzionalità dei task nei processi BPMN.

- **Model**: Contiene le classi che rappresentano i dati utilizzati da ACMEsky. Attraverso l'utilizzo del framework JPA (Java Persistence API) le classi del *Model* vengono mappate nelle tabelle del database in maniera automatica.

- **Business logic**: In essa sono contenute tutte le classi Java che, utilizzando il *Model*, si occupano di gestire la logica business dei servizi di ACMEsky. Inoltre, si interfaccia con il DBMS per manipolare e archiviare i dati che vengono elaborati.

- **Gateway**: Raggruppa tutte le classi che implementano le API RESTful e SOAP di ACMEsky. La Business logic comunica con il *Gateway* per inviare e ricevere i messaggi dall'esterno. Inoltre, attraverso il filtro *JWT*, il *Gateway* autentica l'entità che effettua la richiesta e successivamente la autorizza a compiere operazioni su specifiche risorse. 

- **ACMEsky Web**: E' l'applicazione web di ACMEsky, essa permette all'utente di eseguire le richieste alle API di ACMEsky Sevice in maniera intuitiva. ACMEsky Web non è strettamente necessario per effettuare le richieste ai servizi esposti da ACMEsky, in quanto quest'ultimo potrebbe essere interrogato attraverso un semplice client REST.

&nbsp;

## Diagramma dei servizi

![struttura totale](struttura/structure2.png)
Per simulare un ambiente reale, ogni servizio, o parti de esso, è stato "incapsulato" in un container docker. Il diagramma mostra i container che vengono creati utilizzando il file `docker-compose.yml` che si trova nella root della repository del progetto.
Di seguito vengono spiegati brevemente i servizi e la loro counicazione con ACMEsky.

- **ACMEsky**
    - **ACMEsky Service**: Il server WildFly, che comprende il deployment di ACMEsky e Camunda BPMS, è stato inserito in un container. Esso si interfaccia con un altro container che contiene il database.
    - **ACMEsky Web**: L'applicazione web gira su un server NGNIX e si interfaccia ad ACMEsky attraverso le sue API RESTful.
- **Airline Service**: E' il servizio che simula una compagnia aerea, realizzato utilizzando il framework Spring. I servizi di Airline Service sono due: uno che offre voli nazionali e uno che offre voli internazionali, modificando il file `docker-compose.yml` è possibile aggiungerne di nuovi o rimuovere quelli già presenti. Essi si interfacciano ad ACMEsky utilizzando le API RESTful.
- **Bank Service**: E' il servizio con cui ACMEsky si interfaccia per la gestione simulata dei pagamenti, realizzato utilizzando il framework Spring. Viene ospitato in un container e comunica con ACMEsky attraverso le API RESTful.
- **GeographicalDistanceService**: E' il servizio di geolocalizzazione che calcola la distanza tra due indirizzi o coordinate geografiche. E' scritto in NodeJS utilizzando la libreria ExpressJS. Viene ospitato in un container e comunica con ACMEsky attraverso API RESTful.
- **Prontogram**: Applicazione web che permette all'utente di ricevere le notifiche delle offerte dei voli generate da ACMEsky. Il front-end è stato realizzatto utilizzando Angular, mentre il back-end è stato sviluppato utilizzando NodeJS. Comunica con ACMEsky attraverso API RESTful.
- **Rental Service**: E' il servizio di noleggio con autista. E' stato realizzato in Jolie. Comunica con ACMEsky attraverso SOAP. Nel deployment sono presenti due copie del servizio ciascuna distribuita all'interno di un container. 

&nbsp;

## Porte assegnate ai servizi nel file `docker-compose.yml`

| Service | Port |
| - | - |
| ACMEsky Service | 8080 |
| ACMEsky Web | 80 |
| Postgres | 5050 |
| BankService | 8070 |
| AirlineNationalService | 8060 |
| AirlineService | 8061 |
| ProntogramService | 8050 |
| ProntogramFrontEnd | 8051 |
| GeocraphicalService | 8040 |
| RentService1 | 8030 |
| RentService2 | 8032 |

&nbsp;
<div class="page-break"></div>

# Istruzioni per l'esecuzione dello stack di container

## Prerequisiti

- Docker
- Docker compose
- Un po' di pazienza!

## Esecuzione

Dalla root della repository eseguire
```sh
docker-compose up --build
```

I singoli servizi non devono essere compilati poiché questa operazione viene già fatta a tempo di build all'interno dei container.

&nbsp;
<div class="page-break"></div>

# Descrizione dei servizi
Di seguito vengono spiegati nel dettagglio i servizi.


# ACMEsky Service

ACMEsky Service è il modulo principale di ACMEsky, si relaziona con i vari servizi (AirlineServices, RentServices, Prontogram, BankService, ecc...) al fine di consentire agli utenti di richiedere ed acquistare le offerte dei voli che desiderano.

ACMEsky Service comunica con il database (PostgreSQL) per gestire le entità che possono essere utenti o altri servizi, in modo da poterli autenticare e autorizzare quando inviano richieste HTTP.
Inoltre, gestisce i voli di interesse degli utenti (A/R), i voli delle compagnie aeree (last-minute e non) e le offerte generate dai voli acquisiti dalle compagnie aeree.

Esso interagisce con ACMEsky Web per rapportarsi con gli utenti, raccoglie i voli di interesse degli utenti. Al momento dell'inserimento del token per acquistare l'offerta verifica se è ancora valida e procede con l'acquisto e il pagamento dei biglietti aerei. Infine, ACMEsky consentirà all'utente di visualizzare i biglietti dei voli precedentemente acquistati dopo aver applicato eventuali servizi aggiuntivi.

ACMEskyService si relaziona con i servizi di AirlineService (compagnie aeree) al fine di cercare, tra i voli che offrono, quelli che coincidono con gli interessi degli utenti. Gli interessi degli utenti sono composti da voli di andata e ritorno, mentre le offerte generate sono quelle che ACMEsky crea con i voli reali che riceve dalle compagnie aeree. Inoltre, il servizio riceve voli last-minute inviati dalle Airline Services con una certa frequenza.
Infine, ACMEsky recupera i biglietti dei voli che gli utenti vogliono acquistare tramite una richiesta alla compagnia aerea, nel caso di errori o problemi di pagamento cancella la prenotazione informando l'AirlineService corrispondente.

Per quanto riguarda il pagamento, il servizio interroga Bank Service (provider di pagamenti), per richiedere il link di pagamento da inviare all'utente, il quale poi interagirà con la banca per effettuare il pagamento. Infine, Bank Service informerà ACMEsky dell'avvenuto pagamento.

Il servizio di ACMEsky interagisce con quello del calcolo delle distanze geografiche "GeographicalDistance Service" e con quelli di noleggio "Rental Service" per applicare eventuali servizi aggiuntivi all'offerta acquistata dell'utente. Effettua le richieste a GeographicalDistance Service per calcolare la distanza utente - areoporto e
per trovare la compagnia di noleggio più vicina. Infine, prenota il trasferimento A/R da Rental Service e aggiunge i dettagli sulla ricevuta di viaggio.


## Tecnologie utilizzate e scelte progettuali

Il servizio è stato sviluppato utilizzando Java Enterprise Edition, il quale implementa la specifica JAX-RS (Java API for RESTful Web Services), un set di interfacce e annotazioni che facilitano lo sviluppo di applicazioni lato server. Per quanto riguarda il deployment si è scelto l'application server Wildfly che offre supporto completo a Java EE in tutti gli ambienti applicativi. E' stato utilizzato Camunda come BPMN per supportare i processi, il quale offre un deployment per Wildfly. Il servizio mette a disposizione la specifica di OpenAPI. I biglietti in formato pdf vengono generati grazie al framework opensource di Itext, che consente di convertire file html in pdf automaticamente. Il deployment di ACMEsky è basato sull'immagine Docker **_camunda-bpmn-platform:wildfly_** a cui viene aggiunto il file .war compilato dai sorgenti di ACMEsky.

Il progetto è composto dai seguenti moduli:

### camunda

Questa parte del progetto si compone di tre sottodirectory, ovvero flights_manager, offers_manager e user_manager: questo perchè si è voluto riprendere la struttura del diagramma BPMN, che divide i vari flussi di esecuzione dei processi in queste tre lane che si differenziano per la loro funzione e per gli attori con cui interagiscono. Ciascuna classe implementa un task di un processo o sottoprocesso presente nel flusso di esecuzione, implementando l'interfaccia JavaDelegate e definendo il metodo execute.

- **flights_manager** si suddivide nelle seguenti directory: _last_minute_ che ospita al proprio interno un file che consente di salvare le offerte che le compagniee aeree inviano ad ACMEsky, _remove_expired_flights_ la quale include i file per rimuovere i voli scaduti e _search_flights_ che consente di recuperare la lista degli AirlineService, cercare i voli di interesse e salvarli in db.
- **offers_manager** comprende i Delegate per rimuovere le offerte di volo e relativi voli scaduti, scegliere tra i voli disponibili quelli che corrispondono agli interessi degli utenti, preparare l'offerta e inviarla all'utente.
- **user_manager** si suddivide in: _book_payment_, che gestisce la prenotazione e l'acquisto dei biglietti aerei, _confirm_offer_, il quale si occupa della conferma dell'offerta espressa dall'utente inserendo il token e controllando che l'offerta sia ancora valida e _premium_service_, controlla l'applicazione di eventuali servizi aggiuntivi all'offerta. Infine _save_interest_ si occupa del salvataggio dell'offerta di interesse degli utenti.
  Gli altri file sono legati ai task finali relativi al cambiamento dello stato dell'offerta acquistata con successo, la cancellazione del contenuto delle variabili dell'ambiente e l'invio del biglietto acquistato dall'utente quando lo richiede.

Le classi presenti nella directory utils definiscono: le variabili dei processi, gli eventi di inizio e gli eventi di errore.

### gateway

Questa parte del progetto si compone di una directory per ciascun servizio, nelle quali si descrivono le interfacce esposte ad essi. Inoltre, ACMEsky implementa le api dei servizi esterni che verranno utilizzate dalla business logic.

### business logic

Ospita i manager, che utilizzando i modelli, implementa la business logic di ACMEsky. In particolare, interroga il database e attraverso il gateway comunica con i servizi esterni. Ciascuna classe si occupa della gestione dei servizi corrispondenti. E' composto da AirlineManager, BankManager, InterestManager e OfferManager.

### model

Descrive i dati coinvolti nel progetto: le entità (utente, AirlineService, BankService e RentService), i voli ricevuti dalle compagnie aeree e quelli di interesse, le offerte di interesse e quelle generate da ACMEsky, e gli aereoporti.

### security

Si occupa dell'autenticazione e dell'autorizzazione delle entità che fanno richieste attraverso le api di ACMEsky. Attraverso la route `/auth` è possibile autenticarsi e richiedere il token JWT, con il quale dovranno essere effettuate le successive richieste. Attraverso il token delle richieste viene consentito ai servizi di accedere alle risorse autorizzate per il proprio ruolo.

### utils

Contiene le classi che descrivono gli errori restituiti in caso di problemi nelle richieste, le variabili d'ambiente e quella di utilità per i pdf dei biglietti.

### Formato ricevuta

![Ricevuta](https://vallasc.github.io/ACMEsky/src/ACMEskyService/doc/ricevuta.png)

## API

Il file OpenAPI è disponibile al seguente [link](https://vallasc.github.io/ACMEsky/src/SwaggerUI/open-api.json)

<iframe title="API"
    width="900"
    height="2700"
    class="hidden"
    src="
    https://vallasc.github.io/ACMEsky/src/SwaggerUI/index.html?src=https://vallasc.github.io/ACMEsky/src/SwaggerUI/open-api.json
    ">
</iframe>

&nbsp;

## Risorse di autenticazione

| Risorsa | Descrizione|
| - | - |
| POST `/auth` | Questa risorsa consente di autenticarsi nel sistema. Si richiede un oggetto AuthRequestDTO come parametro, composto da un attributo username e un attributo password. ACMEsky restituirà un token valido.|
| PUT `/auth/refresh` | Questa risorsa consente alle entità di richiedere un nuovo token dato uno che sta per scadere. |

## Risorse per AirlineServices

| Risorsa | Descrizione|
| - | - |
| POST `/airlines/last_minute` | Questa risorsa è riservata esclusivamente agli AirlineServices. La chiamata a questa risorsa richiede come parametro una lista di oggetti AirlineFlightOfferDTO che verrà salvata nel database. |

## Risorse per BankServices

| Risorsa | Descrizione|
| - | - |
| GET `/bank/confirmPayment` | Questa risorsa è riservata esclusivamente ai servizi BankServices. La chiamata a questa risorsa richiede come parametro il codice dell'offerta di volo acquistata dall'utente.|

## Risorse per ACMEskyWeb

| Risorsa | Descrizione|
| - | - |
| GET `/airports`| Questa risorsa è riservata esclusivamente all'utente, esso accede a questa risorsa passando la query di ricerca dell'aereoporto per recuperare la lista dei suggerimenti.|
| GET `/airports/{code}`| Questa risorsa è riservata esclusivamente all'utente, restituisce l'aereoporto associato al codice IATA fornito come parametro.|
| POST `/interests`| Questa risorsa è riservata esclusivamente all'utente, e permette di inserire gli interessi specificati nell'oggetto UserInterestDTO.|
| GET `/interests`| Questa risorsa è riservata esclusivamente all'utente. Consente di recuperare la lista di tutte le offerte di interesse dell'utente che si è autenticato sulla piattaforma ACMEskyWeb.|
| GET `/interests/{id}`| Questa risorsa è riservata esclusivamente all'utente. Consente di recuperare l'offerta di interesse corrispondente all'identificativo passato come parametro del path della richiesta.|
| DELETE `/interests/{id}`| Questa risorsa è riservata esclusivamente all'utente. Permette di cancellare l'offerta di interesse con lo stesso identificativo di quello passato come parametro del path della richiesta.|
| PUT `/offers/confirm`| Questa risorsa è riservata esclusivamente all'utente. Il servizio web di ACMEsky chiama questa risorsa con un oggetto DTO dell'offerta di volo di interesse dell'utente come parametro per informare ACMEskyService del fatto che l'utente ha confermato l'offerta proposta inserendone il token. |
| PUT `/offers/paymentLink`| Questa risorsa è riservata esclusivamente all'utente. Consente di recuperare il link di pagamento passando il DTO dell'indirizzo dell'utente come parametro.|
| PUT `/offers/reset`| Questa risorsa è riservata esclusivamente all'utente. Consente di fare il reset del processo di conferma e acquisto dell'offerta passando come parametro un oggetto UserInterestDTO dell'utente. |
| GET `/offers/`| Questa risorsa è riservata esclusivamente all'utente. Restituisce le offerte generate da ACMEsky sulla base delle preferenze dell'utente, filtrando le offerte che non sono state acquistate. |
| GET `/offers/{token}`| Questa risorsa è riservata esclusivamente all'utente. Recupera l'offerta generata con il token corrispondete a quello specificato.|
| GET `/offers/{token}/ticket` | Questa risorsa è riservata esclusivamente all'utente. Restituisce il biglietto dell'offerta con il token specificato dal parametro. |
| GET `/users/me` | Questa risorsa è riservata esclusivamente all'utente. Recupera le informazioni dell'utente che si è autenticato.|
| POST `/users/` | Tutti i nuovi servizi e utenti possono effettuare chiamate a questa route per registrarsi su ACMEsky. Il servizio chiamante può effettuare chiamate a questa route passando come argomento un oggetto di tipo UserSignUpdDTO, contenente email, password, name, surname e prontogramUsername, per registrare un utente.|| PUT `/users/me` | Questa risorsa è riservata esclusivamente all'utente. Consente di modificare la password, il nome ed il cognome.|
| DELETE `/users/me` | Questa risorsa è riservata esclusivamente all'utente. Permette di cancellare l'utente dal db di ACMEsky.|

### comando per fare la build

```sh
mvn package
```

### comando per fare la build del servizio e far partire il container Docker

```sh
docker-compose up --build
```

&nbsp;
<div class="page-break"></div>

# ACMEsky Database

ACMEsky si interfaccia ad un database PostgreSQL.
Il file docker-compose, attraverso il file init.sql, contiene tuto il necessario per eseguire un'istanza del database con le tabelle e i record necessari ad ACMEsky.

## Database schema

|  | airports |
| - | - |
| PK | id |
|  | code |
|  | name |
|  | city_name |
|  | country_code |
|  | timezone |
|  | latitude |
|  | longitude |

La tabella ***airports*** contiene i record che rappresentano gli aereoporti nazionali e internazionali codificati secondo il codice IATA. Essa contiene il campo ***id*** (chiave primaria), ***code***  (codice dell'aereoporto in codifica IATA), ***name*** (nome dell'aereoporto), ***city_name*** (nome della città), ***country_code*** (codice del paese), ***timezone***(fuso orario), ***latitude*** e ***longitude*** (la posizione dell'aereoporto).

|  | domain_entities |
| - | - |
| PK | id |
|  | username |
|  | password |
|  | salt |
|  | role |

La tabella ***domain_entities*** contiene i record che descrivono le entità del dominio, ossia gli attori che interagiscono con ACMEsky al fine di raggiungere i propri scopi. Così è possibile riconoscere il ruolo di ciascun servizio/utente in base alle proprie credenziali, evitando relazioni con parti sconosciute. Ogni tupla contiene il valore corrispondente al campo ***id*** (chiave primaria), ai campi ***username*** e ***password*** (le credenziali), ***salt*** (dato random addizionato all'input della funzione one-way), e  ***role*** (il ruolo dell'entità nella SOA).

|  | users |
| - | - |
| PK | id |
| FK | entity_id |
|  | name |
|  | surname |
|  | email |
|  | prontogram_username |

La tabella ***users*** rappresenta gli utenti che interagiscono con il sistema. Il campo ***id*** è l'identificatore dell'utente nella tabella (Chiave primaria), ***entity_id*** è l'id con il quale è stato salvato l'utente sulla tabella ***domain_entities*** (Chiave esterna), ***name*** e ***surname*** sono il nome e cognome dell'utente, ***email*** è il campo contenente l'email con la quale l'utente si è registrato, mentre ***prontogram_username*** è il nome utente con il quale l'utente si è registrato sull'app di Prontogram. 

|  | flights_interest |
| - | - |
| PK | id |
| FK | user_id |
| FK | departure_airport_id |
| FK | arrival_airport_id |
|  | departure_date_time |
|  | used |

La relazione ***flights_interest*** descrive un volo di interesse, ossia un volo che un utente richiede attraverso il servizio di ACMEskyWeb per acquistarlo. La relazione ha un campo ***id*** (chiave primaria), ***user_id*** (chiave esterna della tabella ***users***), ***departure_airport_id*** e ***arrival_airport_id*** (indicano l'identificatore dell'aereoporto di partenza e arrivo), ***departure_date_time*** (data di partenza) e ***used*** (indica se ACMEsky ha già proposto all'utente il volo in un'offerta).  

|  | users_interests |
| - | - |
| PK | id |
| FK | user_id |
| FK | outbound_flight_interest_id |
| FK | flight_back_interest_id |
|  | price_limit |  
|  | expire_date |
|  | used |

La tabella ***users_interest*** descrive le i voli di interesse degli utenti A/R. Comprende i campi: ***id*** (chiave primaria), ***user_id*** (chiave esterna dell'utente nella tabella ***users***), ***outbound_flight_interest_id*** (chiave esterna del volo di interesse di andata in ***flights_interest***),***flight_back_interest_id*** (chave esterna del volo di interesse di ritorno in ***flights_interest***), ***price_limit*** (limite di prezzo che l'offerta non può superare), ***expire_date*** (data di scadenza entro cui l'offerta è prenotabile) e ***used*** (valore booleano che segnala se l'interesse è stata già gestita da ACMEsky). 

|  | airlines |
| - | - |
| PK | id |
| FK | entity_id |
|   | ws_address |

La tabella ***airlines*** fa riferimento ai servizi delle compagnie aeree (AirlineService). Comprende i seguenti campi: ***id*** (chiave primaria), ***entity_id*** (chaive esterna dell'entità in ***domain_entities***) e  ***ws_address*** (l'indirizzo del server del servizio a cui si possono fare richieste).

|  | flights |
| - | - |
| PK | id |
| FK | departure_airport_id |
| FK | arrival_airport_id |
| FK | airline_id |
|  | flight_code |
|  | departure_date_time |
|  | arrival_date_time |
|  | price |
|  | expire_date |
|  | booked |
|  | available |

La tabella ***flights*** descrive i voli che vengono recuperati interrogando la compagnia aerea sulla base dei voli di interesse degli utenti. Sono presenti i seguenti campi: ***id*** (chiave primaria), ***departure_airport_id*** (chiave esterna dell'aereoporto di partenza nella tabella ***airports***), ***arrival_airport_id*** (chiave esterna dell'aereoporto di arrivo nella tabella ***airports***), ***airline_id*** (chiave esterna della compagnia aerea nella tabella ***airlines***), ***flight_code*** (codice con il quale il volo viene registrato dalla compagnia), ***departure_date_time*** (data e ora di partenza del volo), ***arrival_date_time*** (data e ora di arrivo), ***price*** (prezzo del volo), ***expire_date*** (data di scadenza del volo, ossia quando non è più prenotabile), ***booked*** (indica se il volo è stato prenotato) e ***available*** (stabilisce se il volo è già stato inserito in un offerta, quindi non più inutilizzabile).  

|  | generated_offers |
| - | - |
| PK | id |
| FK | user_id |
| FK | outbound_flight_id |
| FK | flight_back_id |
|  | expire_date |
|  | total_price |
|  | booked |
|  | token |

La tabella ***generated_offers*** rappresenta le offerte di volo generabili da ACMEsky sulla base degli interessi degli utenti. E' composta dai seguenti campi: ***id*** (chiave primaria), ***user_id*** (chiave esterna dell'utente nella tabella ***users***), ***outbound_flight_id*** (chiave esterna del volo di andata nella tabella ***flights***), ***flight_backt_id*** (chiave esterna del volo di ritorno nella tabella ***flights***), ***total_price*** (prezzo dell'offerta A/R), ***expire_date*** (data di scadenza dell'offerta, ossia quando non è più prenotabile), ***booked*** (indica se l'offerta è stata prenotata o meno), ***token*** (codice dell'offerta).

|  | banks |
| - | - |
| PK | id |
| FK | entity_id |
|  | ws_address |

La tabella ***banks*** fa riferimento ai servizi bancari. E' composta dai seguenti campi: ***id*** (chiave primaria), ***entity_id*** (chiave esterna dell'entità della banca nella tabella ***domain_entities***) e ***ws_address*** (indirizzo del server del servizio).

|  | rent_services |
| - | - |
| PK | id |
| FK | entity_id |
|  | address |
|  | ws_address |

La tabella ***rent_services*** fa riferimento ai servizi di noleggio per accompagnare l'utente all'aereoporto. E' composta dai seguenti campi: ***id*** (chiave primaria), ***entity_id*** (chiave esterna riferita alla entità nella tabella ***domain_entities***) e  ***ws_address*** (indirizzo del server del servizio).

&nbsp;
<div class="page-break"></div>

# ACMEsky Web
ACMEsky Web è una single webpage application che viene utilizzata dall'utente per interfacciarsi ai servizi di ACMEsky. Non aggiunge nessuna funzionalità al sistema, il suo unico scopo è quello di fare da wrapper grafico alle API REST di ACMEsky.

## Tecnologie utilizzate
- Svelte
- Typescript
- Bootstrap

## Interfaccia grafica
### Home
![Home](https://vallasc.github.io/ACMEsky/src/ACMEskyWeb/doc/home.png)

### Aggiunta interesse
![Interesse](https://vallasc.github.io/ACMEsky/src/ACMEskyWeb/doc/interesse.png)

### Conferma e acquisto offerta
![offerta](https://vallasc.github.io/ACMEsky/src/ACMEskyWeb/doc/offerta.png)

### Riepilogo
![riepilogo](https://vallasc.github.io/ACMEsky/src/ACMEskyWeb/doc/riepilogo.png)


## Esecuzione

Installa le dipendenze

```bash
npm install
```

...poi fai partire [Rollup](https://rollupjs.org):

```bash
npm run dev
```
L'app viene servita all'indirizzo [localhost:5000](http://localhost:5000)

Per creare una versione ottimizzata
```bash
npm run build
```

&nbsp;
<div class="page-break"></div>

# Airline service

Airline Service è il servizio che simula la compagnia aerea. 
Attraverso le sue API permette di cercare i voli nel database e di acquistarne i biglietti. Inoltre, ad intervalli regolari, genera i voli last-minute e li invia ad ACMEsky.

Per simulare un ambiente reale è stato creato un file `docker-compose.yml` che contiene due istanze di Airline, ovvero national_airline e international_airline.
La prima offre voli da e verso aereoporti nazionali, mentre la seconda offre voli da e verso aereoporti internazionali.

## Tecnologie utilizzate e scelte progettuali

Il servizio è stato realizzato con il framework Spring boot che fornisce un ambiente per sviluppare applicazioni web JAVA e in particolare servizi REST. 

Al primo avvio, viene prelevata la lista dei voli dal file JSON inserito nella directory fileSampleOffers e viene caricata nel database.
Il file JSON è suddiviso due array: *"OFFERS"*, la quale include i biglietti per i voli subito disponibili e *"LAST-MINUTE"*  che racchiude i biglietti per i voli last-minute. Inoltre, è possibile aggiungere nuovi biglietti o rimuovere quelli già presenti integrando il file con nuovi oggetti.

La generazione dei biglietti per i voli last-minute viene efffettuata ogni 10 minuti scegliendo casualmente un volo tra quelli presenti nell'array.
Le offerte di volo vengono convertite automaticamente in nuovi oggetti "Volo" prima di essere inviati ad ACMEsky, per racchiudere solo le informaioni utili.

Prima di inviare le offerte last-minute Airline si deve autenticare da ACMEsky, in caso di esito positivo, riceve un token JWT che dovrà inserire nella richiesta di invio delle offerte.

Per la generazione dei biglietti aerei da inviare all'utente si è scelto di usare la libreria di Thymeleaf, che permette di generare file pdf partendo da un template in formato HTML e CSS riempito con i dati a runtime.

Per la persistenza dei dati è stato scelto H2, un leggero DBMS scritto in Java con tecnologia in-memory.

## Struttura del codice
Classi principali
- **FlightOfferService**: Contiene i metodi per la creazione, ed il salvataggio delle offerte di volo nel database e per l'eventuale invio, nel caso siano last-minute.
Inoltre, sono presenti i metodi per cercare le offerte di volo e per cambiare lo stato di acquisto dei biglietti. 
- **PdfService**: Si occupa di generare i file pdf che contengono le informazioni sui biglietti.

Il package **model** include le classi per la definizione dell'offerta di volo (**FlightOffer**) e la classe per la definizione di alcune utility per la generazione e gestione delle offerte (**FlightUtility**).

Il package **DTO** include le classi per rappresentare le richieste degli utenti (**UserRequest**), per rappresentare i voli che trovano una corrispondenza con gli interessi degli utenti (**Flight**), e il DTO per la richiesta di autenticazione (**AuthRequest**).

La directory **resources** contiene i file necessari per realizzare i biglietti aerei.

## API:
Il file OpenAPI è disponibile al seguente [link](https://vallasc.github.io/ACMEsky/src/AirlineService/swagger.json)


<iframe title="API"
    width="900"
    height="850"
    class="hidden"
    src="
    https://vallasc.github.io/ACMEsky/src/SwaggerUI/index.html?src=https://vallasc.github.io/ACMEsky/src/AirlineService/swagger.json
    ">
</iframe>

&nbsp;

## Risorse
| Risorsa | Descrizione |
| - | - |
| POST `/getFlights` | Ricerca dei voli disponibili nel database. Prende in input una lista di oggetti *UserRequest*. |
| GET `/getTickets`  | Acquista e eestituisce i biglietti identificati dal parametro *id* |

&nbsp;

## Esecuzione 

### Build fat Jar:
```sh
mvn package
```

### Come eseguire con Docker compose
```sh
docker-compose up --build
```

## Credenziali database

### DB console service 1

```sh
http://localhost:8060/h2
URL: jdbc:h2:file:/db
user: sa
passw:
```

### DB console service 2

```sh
http://localhost:8061/h2
URL: jdbc:h2:file:/db
user: sa
passw:
```
### URI
Gli URI riferiti dei container definiti in `docker-compose.yml`:
- http://localhost:8060 per airlineservice_national
- http://localhost:8061 per airlineservice_international

&nbsp;
<div class="page-break"></div>

# Bank service

Bank è il servizio con cui ACMEsky si interfaccia per la gestione dei pagamenti.
ACMEsky richiede a Bank i link di pagamento che poi verrano utilizzati dall'utente per pagare. Inoltre una volta effettuato il pagamento invia un messaggio ad ACMEsky con la relativa conferma.
Tutte le richieste che vengono fatte alla banca devono esere autenticate utilizzando il token JWT che può essere richieste utilizzando la route `/path`.

## Tecnologie utilizzate e scelte progettuali

Il servizio è stato realizzato utilizzando il framework Spring boot che fornisce un ambiente per sviluppare applicazioni web JAVA. Per l'autenticazione degli utenti e l'autorizzazione delle richieste è stato utilizzata la libreria *Spring-Security* in accoppiata con *jsonwebtoken*.
Per la gestione dei dati è stato utlizzato *H2*, un DBMS leggero che permette di salvare il database in un unico file.

### Schermata di pagamento

![Ricevuta](https://vallasc.github.io/ACMEsky/src/BankService/doc/pagamento.png)

## API:
Il file OpenAPI è disponibile al seguente [link](https://vallasc.github.io/ACMEsky/src/BankService/openapi.json)


<iframe title="API"
    width="900"
    height="1400"
    class="hidden"
    src="
    https://vallasc.github.io/ACMEsky/src/SwaggerUI/index.html?src=https://vallasc.github.io/ACMEsky/src/BankService/openapi.json&token=eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiYW5rSldUIiwic3ViIjoiOTI1NDYxIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9VU0VSIl0sImlhdCI6MTYyNDI5MTI5MywiZXhwIjoxNjI1Mzg1Mjk4fQ.xklR5LsgPF0cuI9Ico57g5QuvOJUH9DQyPt7H_RQoDHTk6XqR1Je7-T5wOiQY4CmMI9TR-UffZl_4254pg42wA
    ">
</iframe>

## Risorse

| Risorsa | Descrizione |
| - | - |
| POST `/users` | Risorsa che permette di creare un nuovo utente. |
| GET `/users/me` | Risorsa che restituisce le informazioni dell'utente loggato. |
| POST `/payments` | Risorsa che permette di generare un link di pagamento. |
| GET `/payments` | Risorsa che restituisce la lista dei link di pagamento associati all'utente. |
| POST `/auth` | Risorsa per autenticarsi nel sistema, restituisce un JWT che dovrà essere inserito in tutte le richieste. |


## Esecuzione

### Build fat Jar:
```sh
mvn package
```

### Come eseguire
```sh
mvnw spring-boot:run
```

### Come eseguire con Docker Compose
```sh
docker-compose up --build
```

## Credenziali database
```sh
http://localhost:8070/h2
URL: jdbc:h2:./db/bankdb
user: sa
passw:
```

&nbsp;
<div class="page-break"></div>

# Prontogram

![Prontogram](https://vallasc.github.io/ACMEsky/src/Prontogram/doc/prontogram.png)

Prontogram è una applicazione web che permette di inviare notifiche agli utenti che vi sono iscritti.
I messaggi inviati possono essere formattati utilizzado HTML, questo permette di rappresentare i dati in modo complesso (ad esempio in una tabella).

L'applicazione di Prontogram si divide in due parti: front-end e back-end.
La parte back-end si occupa di gestire tutte le chiamate delle API da e verso il client web. Mentre la parte fornt-end si occupa di creare l'interfaccia grafica e gestire le interazioni da parte dell'utente.


## Tecnologie utilizzate e scelte progettuali
La parte front-end e la parte back-end sono state sviluppate utilizzando tecnologie e pattern strutturali differenti. 

### Front-end
La parte front-end è stata realizzata utilizzando il framework Angular, il quale consente di scomporre l'interfaccia utente in blocchi gestibili e di separare l'interfaccia utente dall'implementazione rendendo la generazione di pagine lato server molto più semplice. L'architettura modulare di Angular consente di strutturare al meglio un'applicazione e permette di semplificare il processo di creazione della SPA (Single page application).

La parte front-end di Prontogram è formata da 3 micro-componenti:
- **AccountComponent** : componente che gestisce la parte di login e registrazione dell'utente;
- **NotificationComponent** : componente che gestisce le notifiche delle offerte ricevute da ACMEsky;
- **UserComponent** : componente che gestisce le informazioni relative all'utente, permettendo di modificare le informazioni inserite da quest'ultimo durante la fase di registrazione alla web application.

Per implementare il sistema di notifiche, è stato utilizzato il servizio "service worker" fornito da Angular. La comunicazione tra applicazione web e server viene stabilita utilizzando una coppia di chiavi VAPID. VAPID è l'acronimo di "Voluntary Application Server Identification" per il protocollo Web Push. Una coppia di chiavi VAPID è una coppia di chiavi crittografiche pubbliche/private che viene utilizzata nel seguente modo:
- *Chiave pubblica*: viene utilizzata come identificatore univoco del server per iscrivere l'utente alle notifiche inviate da quest'ultimo;
- *Chiave privata*: deve essere tenuta segreta (a differenza della chiave pubblica) e viene utilizzata dall'application server per firmare i messaggi, prima di inviarli al servizio Push per la consegna del messaggio.

### Back-end
La parte back-end è stata realizzata utilizzando Node.js, un runtime system open source multipiattaforma orientato agli eventi per l'esecuzione di codice JavaScript. Più nello specifico è stato utilizzato Express.js un web framework per Node.js, il quale offre strumenti di base per creare più velocemente applicazioni web.
Il package *models* include la classe per la definizione della notifica (*notification*), la classe per la definizione dell'utente (*user*) e la classe per la definizione della sottoscrizione al server(*subscription*).
Inoltre, è presente il package *routes*, il quale contiene tutti i percorsi per gestire le chiamate alle API del server.
Per salvare i dati ricevuti e inviati dal server è stato utilizzato MongoDB, un DBMS non relazionale orientato ai documenti. 

## API
Il file OpenAPI è disponibile al seguente [link](https://vallasc.github.io/ACMEsky/src/SwaggerUI/index.html?src=https://vallasc.github.io/ACMEsky/src/Prontogram/api.json)

<iframe title="API"
    width="900"
    height="1850"
    class="hidden"
    src="
    https://vallasc.github.io/ACMEsky/src/SwaggerUI/index.html?src=https://vallasc.github.io/ACMEsky/src/Prontogram/api.json
    ">
</iframe>

&nbsp;

## Risorse

| Risorsa  | Descrizione |
| - | - |
| POST `/notification/posts` | Esegue la creazione della notifica e il salvataggio della notifica nel database per poi inviarla a Prontogram attraverso il metodo sendNotification(). L'invio dell'offerta avviene in seguito ad una ricerca nel database dell'utente al quale è indirizzata. Gli utenti prima di ricevere le notifiche delle offerte dei voli devono aver eseguito la sottoscrizione al server, la quale avviene in automatico dopo aver effettuato il login all'applicazione web Prontogram. |
| DELETE `/notification/posts/{notificationId}` | Esegue la cancellazione di una notifica di un'offerta attraverso il passaggio come parametro dell'Id della notifica. |
| GET `/notification/gets/all/{username}` | Esegue il caricamento di tutte le notifiche delle offerte, attraverso il passaggio come parametro dell'username dell'utente corrispondente. |
| POST `/subscription/post/new` | Esegue la creazione e il salvataggio in database della sottoscrizione di un'utente al servizio di notifiche. Quest'ultima avviene in automatico dopo aver effettuato il login all'applicazione web Prontogram. |
| DELETE `/subscription/posts/{subendpoint}` | Esegue l'annullamento della sottoscrizione e la cancellazione di quest'ultima dal database. La chiamata a questa route avviene in automatico dopo aver effettuato il logout dall'applicazione web Prontogram. |
| GET `/subscription/gets/all` |  La chiamata a questa route permette di reperire tutte le sottoscrizioni effettuate dagli utente al server. |
| POST `/user/posts/` | Esegue la creazione di un nuovo utente e il suo salvataggio nel database. |
| DELETE `/user/posts/{userId}` | Esegue l'eliminazione di un utente dal database, attraverso il passaggio come parametro dell'Id dell'utente corrispondente. |
| PUT `/user/posts/{userId}` | Esegue l'update delle informazioni relative ad un'utente, attraverso il passaggio come parametro dell'Id dell'utente corrispondente. |
| GET `/user/gets/{id}` | La chiamata a questa route permette di reperire le informazioni relative ad un'utente, attraverso il passaggio come parametro dell'Id dell'utente corrispondente.|
| GET `/user/gets/all` |  La chiamata a questa route permette di reperire tutte le informazioni relative a tutti gli utenti presenti in database. |
| POST `/auth/register` | Esegue la registrazione di un utente a Prontogram andando a creare e salvare in database tutte le informazioni relative ad un'utente inserite durante la fase di registrazione. |
| POST `/auth/login` | Esegue il login da parte di un utente a Prontogram. |

## URI
```sh
- http://localhost:8050 per Prontogram back-end
- http://localhost:8051 per Prontogram front-end
- http://localhost:8052 per MongoDB 
```
## Esecuzione

### Come fare la build
```sh
cd front-end
npm install
ng build --prod  
```

### Come eseguire
```sh
cd static 
http-server 
```

### Eseguire con Docker Compose
```sh
docker-compose up --build
```

&nbsp;
<div class="page-break"></div>

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

# Geographical distance service
Servizio che si occupa di calcolare la distanza tra due punti specificati tramite indirizzo o coordinate geografiche. E' stato sviluppato utilizzando la libreria express.js, internamente utilizza le api di distancematrix.ai per il calcolo delle distanze.

### API:
| Risorsa | Parametri |
| - | -|
| GET `/distance` | **from**: indirizzo di partenza. |
| | **to**: indirizzo di arrivo. |

### Esempio 
```sh
http://localhost:8080/distance?from=Mura+Anteo+Zamboni+7+40126+Bologna+%28BO%29%0D%0A&to=Ferrara
```

## Come eseguire
```sh
npm install
node index.js -p 8080
```

## Eseguire con Docker Compose
```sh
docker-compose up
```
