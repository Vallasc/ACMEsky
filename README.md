<!---
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
--->

# ACMEsky

Progetto di Ingegneria del Software Orientata ai Servizi
A.A. 2020/2021

La documentazione web è disponibile al link https://vallasc.github.io/ACMEsky/docs/
## Descrizione del dominio e del problema
ACMESky offre un servizio di che permette ai clienti di specificare, attraverso un portale web, il proprio interesse a trasferimenti aerei di andata e ritorno che si tengano in un periodo definito e ad un costo inferiore ad un certo limite impostato.

ACMESky quotidianamente interroga le compagnie aeree per ottenere le quotazioni dei voli di interesse per i propri clienti.

ACMESky riceve anche offerte last-minute dalle compagnie che le inviano al momento dell’attivazione senza cadenza prefissata.

Quando ACMESky trova un volo compatibile con una richieste di un cliente prepara un’offerta.

L’offerta viene inviata al cliente tramite l’APP di messaggistica Prontogram. Il cliente, se interessato, ha quindi 24 ore di tempo per connettersi al portale web di ACMESky per confermare l’offerta, specificandone il codice ricevuto via Prontogram.

In fase di conferma il cliente deve anche procedere al pagamento, per la gestione del quale ACMESky si appoggia ad un fornitore di servizi bancari: ACMESky reindirizza il cliente verso il sito del fornitore e quindi attende dal fornitore il messaggio che conferma l’avvenuto pagamento.

Nel caso in cui il costo del volo risulti essere superiore ai 1000 euro ACMESky offre al cliente un servizio gratuito di trasferimento da/verso l'aeroporto se questo si trova entro i 30 chilometri dal suo domicilio.

In questo caso ACMESky fa uso di diverse compagnie di noleggio con autista con cui ha degli accordi commerciali. La compagnia scelta è quelle che risulta avere una sede più vicina al domicilio del cliente. A tale compagnia ACMESky invia una richiesta per prenotare un trasferimento che parta due ore prima dell’orario previsto per il decollo del volo.

## Vincoli al problema

- Le offerte generate provengono dalla stessa compagnia aerea
- Non viene gestito lo scambio di denaro dalla banca alla compagnia aerea 
- Se uno dei servizi per la gestione del calcolo premium non risponde i voli vengono acquistati senza servizi accesori
- Ogni attore deve essere autenticato per poter interagire con ACMEsky

La soa è composta dai seguenti servizi:

TODO
TODO

## Struttura della relazione
* [Coreografie](docs/coreografie)
* [BPMN](docs/BPMN)
* [Coreografie BPMN](docs/coreografieBPMN)
* [UML](docs/UML)
* [Struttura SOA](docs/struttura)
* [Esecuzione](docs/esecuzione)

* Servizi
    * [ACMEsky](src/ACMEskyService/)
        * [Service](src/ACMEskyService/)
        * [Database](src/ACMEskyDB/)
        * [Web](src/ACMEskyWeb/)
    * [AirlineService](src/AirlineService/)
    * [BankService](src/BankService/)
    * [Prontogram](src/Prontogram/)
    * [RentService](src/RentService/)
    * [GeographicalDistance](src/GeographicalDistanceService/)

TODO Spostare in STRUTTURA

| Service | Port |
| - | - |
| ACMEsky | - |
| web | 80 |
| api | 8080 |
| Postgres | 5050 |
| BankService | 8070 |
| AirlineNationalService | 8060 |
| AirlineService | 8061 |
| ProntogramService | 8050 |
| ProntogramFrontEnd | 8051 |
| GeocraphicalService | 8040 |
| RentService1 | 8030 |
| RentService2 | 8032 |

<div class="page-break"></div>
