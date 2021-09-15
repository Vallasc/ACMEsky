
# ACMEsky

Progetto di Ingegneria del Software Orientata ai Servizi
A.A. 2020/2021

La documentazione web è disponibile al link https://vallasc.github.io/ACMEsky/docs/

## Descrizione del dominio e del problema
ACMESky offre un servizio che permette ai clienti di specificare, attraverso un portale web, il proprio interesse a trasferimenti aerei di andata e ritorno che si tengano in un periodo definito e ad un costo inferiore ad un certo limite impostato.

ACMESky quotidianamente interroga le compagnie aeree per ottenere le quotazioni dei voli di interesse per i propri clienti.

ACMESky riceve anche offerte last-minute dalle compagnie che le inviano al momento dell’attivazione senza cadenza prefissata.

Quando ACMESky trova un volo compatibile con una richiesta di un cliente prepara un’offerta.

L’offerta viene inviata al cliente tramite l’APP di messaggistica Prontogram. Il cliente, se interessato, ha quindi 24 ore di tempo per connettersi al portale web di ACMESky per confermare l’offerta, specificandone il codice ricevuto via Prontogram.

In fase di conferma il cliente deve anche procedere al pagamento, per la gestione del quale ACMESky si appoggia ad un fornitore di servizi bancari: ACMESky reindirizza il cliente verso il sito del fornitore e quindi attende dal fornitore il messaggio che conferma l’avvenuto pagamento.

Nel caso in cui il costo del volo risulti essere superiore ai 1000 euro ACMESky offre al cliente un servizio gratuito di trasferimento da/verso l'aeroporto se questo si trova entro i 30 chilometri dal suo domicilio.

In questo caso ACMESky fa uso di diverse compagnie di noleggio con autista con cui ha degli accordi commerciali. La compagnia scelta è quelle che risulta avere una sede più vicina al domicilio del cliente. A tale compagnia ACMESky invia una richiesta per prenotare un trasferimento che parta due ore prima dell’orario previsto per il decollo del volo.

## Vincoli aggiuntivi

- Ogni attore deve essere autenticato e autorizzato per poter interagire con ACMEsky;
- I voli dell offerte generate provengono dalla stessa compagnia aerea;
- Non viene gestito lo scambio di denaro dalla banca alla compagnia aerea; 
- Se uno dei servizi per la gestione del calcolo premium non risponde i voli vengono acquistati senza servizi accesori;

Il progetto è composta dai seguenti servizi:
- **ACMEsky**:
- **Airline Service**:
- **Bank Service**:
- **Prontogram**:
- **GeoDistance Service**:
- **Rent Service**:


## Struttura della documentazione
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

<div class="page-break"></div>
