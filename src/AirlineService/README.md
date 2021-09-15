# Airline service

A demo version of AirlineService

## Introduzione

Airline Service è il servizio che genera e invia ad ACMEsky i voli last-minute e quei voli che hanno una corrispondenza con i voli di interesse degli utenti raccolti da ACMEsky stessa. I voli vengono generati dopo circa 10 minuti che il servizio viene attivato e inviati ad ACMEsky su richiesta dei clienti, mentre i voli last-minute vengono generati e passati ogni 10 minuti indipendentemente dalla presenza di voli di interesse ad essi corrispondenti.

Il servizio manda i biglietti relativi ai voli per cui gli utenti manifestano la volontà di acquistare tramite il servizio di ACMEskyWeb.

Al momento sono attive 2 istanze di AirlineService che comunicano con ACMEsky, ovvero national_airline e international_airline.
La prima istanza offre voli da e verso aereoporti nazionali, mentre la seconda offre voli da aereoporti nazionali o internazionali verso quelli internazionali. Per il resto i due servizi si comportano allo stesso modo (generazione delle offerte di volo, creazione e invio automatico nel caso siano offerte last-minute, gestione dei voli acquistati dagli utenti, invio dei biglietti, ecc.). Le due istanze vengono create grazie a Docker.

## Panoramica

### Informazioni generali su tecnologie e scelte progettuali del servizio

Il servizio è stato realizzato con il framework Spring boot che fornisce fin da subito un minimo di configurazione per sviluppare applicazioni web JAVA e in particolare servizi REST. Si è scelto di utilizzare Apache Maven per la gestione delle dipendenze del progetto, l'importazione di tutte le librerie necessarie per sviluppo del progetto e i relativi JAR, l'esecuzione dei vari goal per fare la build e l'esecuzione del servizio.
Si è deciso di usare Docker per creare due istanze di AirlineService specificando nel dockerFile la versione di Java e i vari jar da copiare ed eseguire, mentre nel docker-compose.yml si è definita la lista delle immagini dei container da creare, le variabili di ambiente racchiuse nel file di configurazione di ciascun immagine, i volumi tra cui figurano i file JSON necessari per generare le offerte di volo e il db, le porte con cui si interfacciano con l'esterno e la rete a cui sono collegati tutti i container che vengono creati.

I file JSON dei voli sono suddivisi in due liste principali: "OFFERS", la quale ospita le liste che contengono gli oggetti JSON dei biglietti per i voli "normali", mentre "LAST-MINUTE" racchiude le liste che includono al proprio interno i biglietti per i voli last-minute. Infatti ci sono due liste fatte apposta per separare i voli standard dai voli last-minute: ciascuna di queste liste contiene a sua volta un insieme di array JSON che rappresentano i voli che il servizio organizza, e ciascun array contiene gli oggetti JSON rappresentanti i biglietti disponibili per un dato volo. La creazione dei biglietti dei voli standard avviene una sola volta convertendo gli oggetti JSON contenuti nelle liste in offerte di volo dopo 10 minuti dall'avvio del servizio, mentre la generazione dei biglietti per i voli last-minute viene fatta ogni 10 minuti scegliendo casualmente tra le liste di voli la lista che contiene i biglietti da creare, che verranno a loro volta convertiti in offerte di volo e inviati ad ACMEsky. In entrambi i casi le offerte di volo create vengono salvate sul Database. Si è scelto di convertire gli oggetti JSON dei biglietti nelle offerte di volo. Infatti le offerte di volo vengono convertite automaticamente in nuovi oggetti chiamati "Volo" prima di essere inviati ad ACMEsky per non mostrare informazioni inutili per l'utente come l'identificatore della compagnia aerea o la data di scadenza dell'offerta stessa, utili ai servizi per gestire i voli più comodamente. É possibile aggiungere nuovi biglietti o rimuovere quelli già presenti integrando i file con nuove liste di oggetti JSON che ne rispettano le caratteristiche, ovvero una chiave con l'opportuno nome per ogni campo e un valore adatto.

Le offerte corrispondenti ai voli di interesse degli utenti vengono recuperate dal DB con una query che cerca tutte quelle offerte che hanno gli stessi aereoporti di partenza e arrivo dei voli richiesti e che partono lo stesso giorno dei voli di interesse degli utenti, a prescindere dall'ora esatta della partenza. Vengono ignorate tutte le offerte di voli last-minute (poichè ACMEsky li ha già ricevuti) e le offerte i cui biglietti sono stati già venduti. Il servizio invia ad ACMEsky solo voli non scaduti al momento della creazione nel caso dei voli, e al momento dell'invio se si tratta di voli last-minute. Prima di inviare le offerte last-minute il servizio chiede ad ACMEsky di autenticarsi e, in caso di esito positivo, riceve un token jwt che dovrà presentare nel campo Authorization nell'header della richiesta di invio delle offerte.

Per la generazione dei biglietti aerei da inviare all'utente si è scelto di usare le librerie di Thymeleaf, che offre la possibilità ad applicazioni server side di realizzare template in grado di eseguire codice HTML e CSS in maniera semplice, oltre al loro riempimento con le informazioni del biglietto di volo ed alla generazione di file pdf.

Il DBMS che è stato scelto è quello di H2, scritto in Java con tecnologia in-memory, tra l'altro accessibile attraverso le route e le credenziali stabilite nel file application.properties, le cui impostazioni stabiliscono che il DB mantiene il suo stato anche se il server viene spento.

### Struttura del servizio

Il progetto è stato strutturato sulla base della Dependency Injection di Spring boot, quindi vi è il package service contenente i servizi ("FlightOfferService" e "PdfService") che vengono "iniettati" nel "FlightOfferController" presente nel package controller per offrire le feature richiamabili dalle risorse che verranno descritte in seguito. Il "FlightOfferService" si occupa di fornire i metodi e le funzioni richiamabili dalle risorse del controller per garantirne il funzionamento. Vi sono i metodi e le funzioni per la creazione, ed il salvataggio delle offerte di volo nel Database e per l'eventuale invio dei voli nel caso siano last-minute, le funzioni per cercare le offerte di volo compatibili con i voli di interesse degli utenti e l'invio dei rispettivi voli, il metodo per il cambiamento di stato delle offerte di volo da disponibili ad acquistate ed eventualmente il viceversa. Il "PdfService" si occupa di creare file pdf contenenti tutte le informazioni sui biglietti che l'utente vuole acquistare.
Il package model include la classe per la definizione dell'offerta di volo, ovvero "FlightOffer", la classe per la definizione di alcune utility per la generazione e gestione delle offerte, ovvero "FlightUtility". E'stato creato il package per i Data Transfer Object (DTO) per rappresentare le richieste degli utenti ("UserRequest"), per rappresentare i voli che trovano una corrispondenza con gli interessi degli utenti ("Flight"), e il DTO per la richiesta di autenticazione chiamato "AuthRequest", impiegato per richiedere un token jwt per autenticarsi nel caso i servizi lo richiedono per fare richieste HTTP, come ad esempio ACMEsky.
Inoltre è presente un package repository che contiene un interfaccia che estende una repository JPA utilizzata che consente di interfacciarsi con la tabella contenente le offerte di volo per la gestione delle funzionalità che offre il servizio di Airline.
Nella directory resources vi sono le risorse necessarie per realizzare i biglietti aerei, ovvero il template "Ticket_template" e la sottodirectory "pdf-resources" che ospita la cartella css contentente un css impiegato dal template.
|

### URI

Tutti gli URI riferiti ai vari container che ospitano i servizi di AirlineService sono i seguenti:

- http://localhost:8060 per airlineservice_national
- http://localhost:8061 per airlineservice_international

### API:

```sh
http://localhost:8060/swagger-ui.html
http://localhost:8061/swagger-ui.html
```

<iframe title="API"
    width="900"
    height="1100"
    class="hidden"
    src="
    https://vallasc.github.io/ACMEsky/src/SwaggerUI/index.html?src=https://vallasc.github.io/ACMEsky/src/AirlineService/swagger.json
    ">
</iframe>

### Risorse e descrizione

| Risorsa          | Descrizione                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| POST /getFlights | Questa risorsa consente di richiedere i voli che corrispondono ai voli di richiesta degli utenti passati come parametro. Infatti prende in input una lista di oggetti JSON che vengono deserializzati grazie a Jackson Json in oggetti di tipo UserRequest e cerca nella repository le offerte che hanno gli stessi aereoporti di partenza e arrivo e la stessa data di partenza (non si considera l'orario, infatti si cerca tutti i voli disponibili per l'intero giorno di andata). Se queste non sono offerte last-minute e non sono già state acquistate da altri utenti, vengono convertite in oggetti Flight e poi inviate in risposta alla chiamata, altrimenti no. |
| GET /getTickets  | Le chiamate a questa risorsa che hanno come parametro la lista di identificatori delle offerte che l'utente ha intenzion di acquistare consentono di ricevere i biglietti dei voli in formato pdf. Nello specifico si cambia lo stato di acquisto delle offerte corrispondenti ai voli che si vuole acquistare e si restituisce un file che elenca e descrive brevemente le caratteristiche dei voli. Infine si imposta il tipo del contenuto del risultato, ovvero un pdf, e gli header che stabiliscono che vi un file in allegato alla risposta.                                                                                                                         |

### Build fat Jar:

```sh
mvn package
```

### Build e run con Docker compose

```sh
docker-compose up --build
```

## Credenziali database

### DB console service 1

```sh
http://localhost:8060/h2
URL: jdbc:h2:file:./db/db
user: sa
passw:
```

### DB console service 2

```sh
http://localhost:8061/h2
URL: jdbc:h2:file:./db/db
user: sa
passw:
```

\
\
&nbsp;
