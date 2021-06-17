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
http://localhost:8082/swagger-ui.html
http://localhost:8083/swagger-ui.html
```
[API link]( https://vallasc.github.io/ACMEsky/docs/swagger-ui/index.html?src=https://vallasc.github.io/ACMEsky/src/AirlineService/swagger.json)

<iframe title="API"
    width="900"
    height="900"
    src="
     https://vallasc.github.io/ACMEsky/docs/swagger-ui/index.html?src=https://vallasc.github.io/ACMEsky/src/AirlineService/swagger.json
    ">
</iframe>

## DB console service 1
```sh
http://localhost:8082/h2
URL: jdbc:h2:file:./db/db
user: sa
passw: 
```
## DB console service 2
```sh
http://localhost:8083/h2
URL: jdbc:h2:file:./db/db
user: sa
passw:
```

## Documentation
```txt
Airline Service è il servizio che invia ad ACMEsky le offerte di volo last-minute e quelle offerte che hanno una corrispondenza con i voli di interesse degli utenti, in modo da non mandare offerte poco interessanti e che rimarrebbero invendute per molto tempo.
AirlineService elimina le offerte di volo che vengono acquistate e manda i biglietti relativi alle offerte che vengono acquistati dagli utenti tramite ACMEsky.
Gli utenti non interagiscono direttamente con il servizio, ma attraverso ACMEsky che gli proporrà loro le offerte di volo più interessanti.
Ci sono 2 istanze di AirlineService che comunicano con ACMEsky al momento, ovvero airlineservice_national e airlineservice_international. 
La prima istanza offre voli da e verso aereoporti nazionali, mentre la seconda offre voli da e verso aereoporti internazionali. Per il resto i due servizi si comportano allo stesso modo (creazione automatica delle offerte, invio di offerte last-minute, gestione delle offerte scadute ed acquistate, invio dei biglietti, ecc.). Le due istanze sono state create grazie a docker che ospita in ciascuno dei due container una copia del servizio. Le due copie differiscono solo nel nome e nel contenuto del file JSON contenente i biglietti per le offerte di volo che si possono generare e le porte con cui si interfacciano verso l'esterno, ovvero con ACMEsky. La creazione automatica dei biglietti relativi alle offerte di volo avviene grazie alla scelta casuale degli oggetti JSON presenti nei due JSON file, i quali contengono liste di oggetti rappresentanti i biglietti delle offerte. É possibile aggiugere nuove offerte o rimuovere quelle già presenti integrando i file con nuove liste di oggetti che rispettano le caratteristiche delle offerte di volo.
L'eliminazione delle offerte di volo scadute avviene automaticamente, mentre le offerte di volo acquistate vengono eliminate tramite chiamate di ACMEsky. Il servizio invia ad ACMEsky solo offerte di volo non scadute al momento della creazione, per cui se nel file JSON contenente le offerte generabili si inseriscono offerte già scadute al momento dell'inserimento, non verranno mai generate offerte di volo relative.
Al momento antecedente al pagamento, AirlineService invia i biglietti relativi all'offerta che l'utente vuole acquistare.
```

## Panoramica

### Informazioni generali su struttura e tecnologie del servizio
```txt
Il servizio è stato realizzato con il framework Spring boot che fornisce già un minimo di configurazione per sviluppare applicazioni web JAVA e in particolare servizi REST. In particolare è stato utilizzato Apache Maven per la gestione delle dipendenze del progetto, importare attraverso i suoi plugin tutte le librerie necessarie per sviluppo del progetto e i relativi JAR, e per la building automatica del progetto.
Il progetto è stato strutturato sulla base della Dependency Injection di Spring boot, quindi vi è il package service contenente i servizi (FlightOfferService e PdfService) che vengono "iniettati" nel FlightOfferController presente nel package controller per offrire le feature richiamabili dalle route che verranno descritte in seguito. In particolare il pdfService si occupa di creare file pdf contenente tutte le informazioni sui biglietti che vengono acquistati dagli utenti. Si è scelto di usare le librerie e i template di Thymeleaf che offre la possibilità ad applicazioni server side di realizzare template in grado di eseguire codice HTML e CSS in maniera semplice, oltre a librerie che consentono di riempire questi template con le informazioni del biglietto di volo e creare file in linguaggio Java.
Il package model include la classe per la definizione dell'offerta di volo, ovvero FlightOffer, la classe per la definizione di alcune utility per la generazione e gestione delle offerte e la classe per la definizione dell'oggetto Iban. Offerte di volo, biglietti e voli sono sostanzialmente sinonimi. E'stato creato il package per i Data Transfer Object (DTO) per rappresentare le richieste degli utenti (UserRequest) usate come parametro per alcune api. Inoltre è presente un package repository che contiene un interfaccia che estende una repository JPA utilizzata che consente di interfacciarsi con la tabella contenente le offerte di volo per la gestione delle funzionalità che offre il servizio di Airline. Il DBMS che è stato scelto è quello di H2, scritto in Java con tecnologia in-memory, tra l'altro accessibile attraverso le route e le credenziali stabilite nel file application.properties, le cui impostazioni stabiliscono che il DB mantiene il suo stato anche se il server viene spento. Come anticipato si è deciso di usare docker per creare due istanze funzionanti di AirlineService specificando nel dockerFile la versione di Java e i vari jar da copiare ed eseguire, mentre nel docker-compose.yml si è specificata la lista delle immagini con relativo nome, variabili di ambiente tra cui figurano i file JSON grazie a cui i servizi generano le offerte di volo e il db, e infine le porte con cui si interfacciano con l'esterno. 
```

### URI
Tutti gli URI riferiti ai vari container che ospitano i servizi di AirlineService sono i seguenti:
```txt
- http://localhost:8082 per airlineservice_national
- http://localhost:8083 per airlineservice_international
```

### Risorse e descrizione

| Risorsa  | Descrizione |
| ------------- | ------------- |
| POST/ createOffer | La creazione delle offerte di volo, sia nazionali e internazionali, è stata realizzata attraverso lo scheduling di chiamate automatiche alla risorsa /createOffer che sceglie randomicamente tra una lista di offerte disponibili per vari voli presenti in un file JSON, la lista di oggetti da creare. Il servizio poi crea le offerte attraverso un opportuno metodo che traduce oggetti JSON in oggetti Java di tipo FlightOffer, nel caso si tratti di offerte last-minute converte gli oggetti FlightOffer e li manda ad ACMEsky, le offerte sia last-minute sia quelle ordinarie vengono salvate sul DB. Si tratta di una risorsa privata del controller del servizio per cui non è chiamabile all'esterno. Lo scheduling che automatizza la creazione delle offerte avviene grazie all'annotazione @Scheduled, con un fixedRate fissato a 6 secondi. |
| POST/ getFlights  | ACMEsky recupera i voli di interesse degli utenti e fa una chiamata a questa risorsa passando la lista di voli recuperati per richiedere voli che corrispondono alle richieste. Infatti questa risorsa prende in input una lista di oggetti chiamati UserRequest e cerca nella repository le offerte che hanno la stessa data di partenza e arrivo e la stessa partenza e destinazione. Se queste non sono offerte last-minute vengono inviate. |
| DELETE/ purchasedOffer  | Le chiamate a questa risorsa consentono di cancellare le offerte di volo che vengono acquistate. |
| DELETE/ deleteExpiredOffer | La cancellazione delle offerte scadute avviene attraverso lo scheduling di chiamate a questa risorsa ogni 6 secondi. Per ogni offerta presente sul DB si cancellano le offerte che hanno la data di scadenza precedente o uguale a quella in cui si effettua la chiamata. |
| GET/ getTickets  | Le chiamate a questa risorsa che hanno come parametro la lista di identificatori delle offerte che l'utente ha acquistato consentono di ricevere i biglietti salvati in formato pdf. Nello specifico si prepara una chiamata POST che ha al suo interno un body che include un file per ciascun offerta acquistata, si impostano gli header e infine la si invia ad ACMEsky attraverso la route "http://localhost:8080/OfferPdfFile". |
| GET/ getIban | Le chiamate a questa risorsa consentono di conoscere l'iban della compagnia AirlineService, utile per il servizio bancario che dovrà effettuare il pagamento dell'utente.  |

