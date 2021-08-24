# AirlineService
A demo version of AirlineService

### Build fat Jar:
```sh
mvn package
```

### Create and run on Docker-compose container
```sh
docker-compose build
docker-compose up
```

### API:
```sh
http://localhost:8060/swagger-ui.html
http://localhost:8061/swagger-ui.html
```
<iframe title="API"
    width="900"
    height="900"
    src="
    https://vallasc.github.io/ACMEsky/src/SwaggerUI/index.html?src=https://vallasc.github.io/ACMEsky/src/AirlineService/swagger.json
    ">
</iframe>

## DB console service 1
```sh
http://localhost:8060/h2
URL: jdbc:h2:file:./db/db
user: sa
passw: 
```
## DB console service 2
```sh
http://localhost:8061/h2
URL: jdbc:h2:file:./db/db
user: sa
passw:
```

## Documentation

Airline Service è il servizio che invia ad ACMEsky i voli last-minute e i voli che hanno una corrispondenza con i voli di interesse degli utenti raccolti da ACMEsky stessa, se e non appena quei voli saranno disponibili dal servizio.
Il servizio manda i biglietti relativi ai voli che gli utenti vogliono acquistare tramite ACMEsky e il portale ACMEskyWeb cambiandone lo stato da disponibili ad acquistati, ma in caso di mancato acquisto ACMEsky chiamerà l'opportuna risorsa per comunicare il problema e cambiare lo stato dei voli relativi per renderli nuovamente disponibili.
Al momento sono attive 2 istanze di AirlineService che comunicano con ACMEsky, ovvero airlineservice_national e airlineservice_international. 
La prima istanza offre voli da e verso aereoporti nazionali, mentre la seconda offre voli da e verso aereoporti internazionali. Per il resto i due servizi si comportano allo stesso modo (creazione delle offerte di volo e l'invio automatico nel caso siano last-minute, gestione dei voli acquistati dagli utenti, invio dei biglietti, ecc.). Le due istanze vengono create grazie a Docker, in particolare al docker-compose. I due servizi differiscono solo nel nome e ovviamente nel tipo di voli che creano (il primo crea voli nazionali, il secondo internazionali).



## Panoramica

### Informazioni generali su tecnologie e scelte progettuali del servizio

Il servizio è stato realizzato con il framework Spring boot che fornisce fin da subito un minimo di configurazione per sviluppare applicazioni web JAVA e in particolare servizi REST. In particolare è stato utilizzato Apache Maven per la gestione delle dipendenze del progetto, l'importazione di tutte le librerie necessarie per sviluppo del progetto e i relativi JAR, l'esecuzione dei vari goal per svolgere tutte le fasi del build lifecycle, ossia compile, test, package per generare file jar e l'esecuzione di un web server grazie ai plugin che mette a disposizione.
Si è deciso di usare docker per creare due istanze funzionanti di AirlineService specificando nel dockerFile la versione di Java e i vari jar da copiare ed eseguire, mentre nel docker-compose.yml si è specificata la lista delle immagini con relativo nome, variabili di ambiente tra cui figurano i file JSON grazie a cui i servizi generano le offerte di volo e il db, e infine le porte con cui si interfacciano con l'esterno.
I file JSON contengono i biglietti per ciascun volo che il servizio stesso mette a disposizione e le porte con cui si interfacciano verso l'esterno. La creazione dei biglietti dei voli avviene grazie alla scelta casuale degli oggetti JSON presenti nei due file. Questi oggetti rappresentano i voli, ed in sostanza sono liste di oggetti JSON che descrivono i biglietti veri e propri. Quindi in sostanza si creano offerte di volo che vengono salvate nel DB a partire dagli oggetti JSON presenti nella lista del volo, ovvero i biglietti che verranno inviati in caso di acquisto, mentre i voli sono degli oggetti DTO che vengono inviati ad ACMEsky in modo che possa controllare se c'è corrispondenza con i voli di interesse degli utenti. Questo perchè le offerte contengono informazioni non interessanti per l'utente come il flag per cambiare lo stato di acquisto dell'offerta o la data di scadenza dell'offerta stessa. É possibile aggiungere nuovi biglietti o rimuovere quelli già presenti integrando i file con nuove liste di oggetti JSON che rispettano le caratteristiche di biglietti che si riferiscono allo stesso volo. Le offerte di volo vengono create automaticamente attraverso lo scheduling di chiamate ad una risorse del servizio ogni 60 secondi.
Le offerte corrispondenti ai voli che sono in procinto di essere acquistati dagli utenti vengono recuperate dal DB per cambiarne lo stato in offerte acquistate, in modo da non riproporre quelle stesse offerte ad ACMEsky in future chiamate alla risorsa di ricerca offerte. Il servizio invia ad ACMEsky solo voli non scaduti al momento della creazione, per cui se nel file JSON tra le voli generabili si inseriscono offerte già scadute al momento dell'inserimento, non verranno mai generate offerte di volo relative. Per la generazione dei biglietti aerei si è scelto di usare le librerie di Thymeleaf, che offre la possibilità ad applicazioni server side di realizzare template in grado di eseguire codice HTML e CSS in maniera semplice, oltre al loro riempimento con le informazioni del biglietto di volo ed alla generazione di file pdf.
Il DBMS che è stato scelto è quello di H2, scritto in Java con tecnologia in-memory, tra l'altro accessibile attraverso le route e le credenziali stabilite nel file application.properties, le cui impostazioni stabiliscono che il DB mantiene il suo stato anche se il server viene spento.


### Struttura del servizio

Il progetto è stato strutturato sulla base della Dependency Injection di Spring boot, quindi vi è il package service contenente i servizi (FlightOfferService e PdfService) che vengono "iniettati" nel FlightOfferController presente nel package controller per offrire le feature richiamabili dalle risorse che verranno descritte in seguito. Il FlightOfferService si occupa di fornire i metodi e le funzioni richiamabili dalle risorse del controller per garantirne il funzionamento. Vi sono i metodi e le funzioni per la creazione, ed il salvataggio delle offerte di volo nel Database e per l'eventuale invio dei voli nel caso siano last-minute, le funzioni per cercare le offerte di volo compatibili con i voli di interesse degli utenti e l'invio dei rispettivi voli, il metodo per il cambiamento di stato delle offerte di volo da disponibili ad acquistate ed eventualmente il viceversa. Il PdfService si occupa di creare file pdf contenenti tutte le informazioni sui biglietti che l'utente vuole acquistare.
Il package model include la classe per la definizione dell'offerta di volo, ovvero FlightOffer, la classe per la definizione di alcune utility per la generazione e gestione delle offerte, ovvero FlightUtility. E'stato creato il package per i Data Transfer Object (DTO) per rappresentare le richieste degli utenti (UserRequest), per rappresentare i voli che trovano una corrispondenza con gli interessi degli utenti (Flight), e il DTO per la richiesta di autenticazione chiamato AuthRequest, impiegato per richiedere un token jwt per autenticarsi nel caso i servizi lo richiedono per fare richieste HTTP, come ad esempio ACMEsky.
Inoltre è presente un package repository che contiene un interfaccia che estende una repository JPA utilizzata che consente di interfacciarsi con la tabella contenente le offerte di volo per la gestione delle funzionalità che offre il servizio di Airline.
Nella directory resources vi sono le risorse necessarie per realizzare i biglietti aerei, ovvero il template Ticket_template e la sottodirectory pdf-resources che ospita la cartella css contentente un css impiegato dal template.  

### URI
Tutti gli URI riferiti ai vari container che ospitano i servizi di AirlineService sono i seguenti:
```txt
- http://localhost:8082 per airlineservice_national
- http://localhost:8083 per airlineservice_international
```

### Risorse e descrizione

| Risorsa  | Descrizione |
| ------------- | ------------- |
| POST/ createOffer | La creazione delle offerte di volo, sia nazionali e internazionali, è stata realizzata attraverso lo scheduling di chiamate automatiche alla risorsa /createOffer che sceglie randomicamente tra una lista di offerte disponibili per vari voli presenti in un file JSON, la lista di offerte da creare. Il servizio poi crea le offerte attraverso un opportuno metodo che traduce oggetti JSON in oggetti Java di tipo FlightOffer, nel caso si tratti di offerte last-minute converte gli oggetti FlightOffer in oggetti Flight e li manda ad ACMEsky tramite una chiamata REST POST, non prima di aver acquisito un token jwt necessario al servizio per autenticarsi come Airline Service. Le offerte sia last-minute sia quelle ordinarie vengono salvate sul DB. Si tratta di una risorsa privata del controller del servizio per cui non è chiamabile all'esterno. Lo scheduling che automatizza la creazione delle offerte avviene grazie all'annotazione @Scheduled, con un fixedRate fissato a 60 secondi. |
| POST/ getFlights  | Questa risorsa consente di richiedere i voli che corrispondono alle richieste degli utenti che vengono passate come parametro. Infatti prende in input una lista di oggetti di tipo UserRequest e cerca nella repository le offerte che hanno la stessa data di partenza e arrivo (non si considera l'orario, infatti si cerca tutti i voli disponibili per il giorno di andata e ritorno) e la stessa partenza e destinazione. Se queste non sono offerte last-minute vengono convertite in oggetti Flight e poi inviate in risposta alla chiamata, altrimenti non verranno inviate visto che ACMEsky ha già ricevuto questi voli. |
| POST/ notPurchasedOffer  | Le chiamate a questa risorsa consentono di cambiare lo stato delle offerte di volo che non vengono acquistate in seguito ad eventuali errori da parte di ACMEsky, in modo da renderle nuovamente disponibili. |
| GET/ getTickets  | Le chiamate a questa risorsa che hanno come parametro la lista di identificatori delle offerte che l'utente ha acquistato consentono di ricevere i biglietti salvati in formato pdf. Nello specifico si cambia lo stato di acquisto delle offerte corrispondenti ai voli che si vuole acquistare e si prepara una chiamata POST che ha al suo interno un body al cui interno vi è un file per ciascun offerta acquistata, si impostano gli header e infine la si invia ad ACMEsky attraverso la route "http://acmesky:8080/airline/OfferFiles". |