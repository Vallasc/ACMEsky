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
Airline Service è il servizio che consente agli utenti del servizio ACMEsky di acquistare i biglietti per i voli che esso offre.
Invia ad ACMEsky offerte last-minute, invia su richiesta di ACMEsky le offerte di volo relative ai voli di interesse degli utenti.
Gestisce le prenotazioni delle offerte e le offerte di volo scadute, elimina le offerte di volo che vengono acquistate e manda i biglietti relativi ai voli che vengono acquistati dagli utenti ad ACMEsky.
Infatti gli utenti non interagiscono direttamente con AirlineService, ma attraverso ACMEsky.

Ci sono 2 istanze di AirlineService accessibili da ACMEsky al momento, ovvero airlineservice_national e airlineservice_international. 
La prima istanza offre voli verso e da aereoporti nazionali, mentre la seconda offre voli da e verso aereoporti internazionali. Per il resto i due servizi si comportano allo stesso modo (creazione automatica delle offerte, invio di offerte last-minute, gestione delle prenotazioni e delle offerte scadute e invio biglietti, ecc.). Le due istanze sono state create grazie a docker che ospita nei due container le copie del servizio. La creazione delle offerte di volo avviene grazie alla scelta casuale di offerte presenti nei due JSON file che contengono liste di oggetti rappresentanti le offerte per uno stesso volo, per cui è necessario aggiugere le offerte che si possono generare integrando i file con nuove liste di oggetti che rispettano le caratteristiche delle offerte di volo. 
Le prenotazioni riguardanti le offerte di volo scadono dopo 3 minuti dalla chiamata REST che avvisa della prenotazione e le eliminazioni vengono gestite in maniera automatica, così come l'eliminazione delle offerte di volo scadute. Il servizio invia solo offerte di volo non scadute al momento dell'invio, per cui se nel file JSON contenente le offerte generabili si inseriscono offerte già scadute al momento dell'inserimento, queste non verranno mai generate.
```

## Panoramica

### Informazioni generali su struttura e tecnologie del servizio
```txt
Il servizio è stato realizzato con il framework Spring boot che fornisce già un minimo di configurazione per sviluppare applicazioni web JAVA e in particolare servizi REST. In particolare è stato utilizzato Apache Maven per la gestione delle dipendenze del progetto, importare attraverso i suoi plugin tutte le librerie necessarie per sviluppo del progetto e i relativi JAR e per la building automatica.
Il progetto è stato strutturato sulla base della Dependency Injection, quindi vi è il package service contenente i servizi che vengono "iniettati" nel FlightOfferController presente nel package controller per offrire le feature richiamabili dalle route che verranno descritte in seguito. In particolare vi è il pdfService che si occupa di creare file pdf contenente tutte le informazioni sui voli che vengono acquistati dagli utenti. Si è scelto di usare le librerie e i template di Thymeleaf che offre la possibilità ad applicazioni server side di realizzare template che sono in grado di eseguire codice HTML e CSS in maniera semplice, oltre ad un sistema che consente di creare file a partire da questi template in linguaggio Java.
Il package model include la classe per la definizione dell'offerta di volo, ovvero FlightOffer, la classe per la definizione di alcune utility per la generazione e gestione delle offerte e la classe per la definizione dell'oggetto Iban. E'stato creato il package per i Data Transfer Object (DTO) per rappresentare le richieste degli utenti (UserRequest) usate come parametro per alcune api e Flight che rappresenta la proposta di volo che verrà inviato ad ACMEsky sulla base delle richieste. Infatti bisogna fare differenza tra gli oggetti di tipo FlightOffer che rappresentano le offerte di volo che la compagnia crea con tutti i campi e le funzioni necessarie per gestire i voli veri propri che vengono inviate ad ACMEsky, ovvero gli oggetti di tipo Flight, che contengono tutte le informazioni necessarie ad essere presentate all'utente, astraendo da tutti i dettagli riguardanti ad esempio le prenotazioni e la loro scadenza. Inoltre è presente un package repository che contiene un interfaccia che estende una repository JPA utilizzata che consente di interfacciarsi con la tabella contenente le offerte di volo per la gestione delle funzionalità che offre il servizio di Airline. Il DBMS che è stato scelto è quello di H2, scritto in Java con tecnologia in-memory, tra l'altro accessibile attraverso le route e le credenziali specificate in precedenza. Infine si è deciso di usare docker per creare due istanze funzionanti di AirlineService specificando nel dockerFile la versione di Java e i vari jar da copiare ed eseguire, mentre nel docker-compose.yml si è specificata la lista delle immagini con relativo nome, variabili di ambiente tra cui figurano i file JSON grazie a cui i servizi generano le offerte di volo e il db, e infine le porte con cui si interfacciano con l'esterno. 
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
| POST/ createOffer | La creazione delle offerte di volo, sia nazionali e internazionali, è stata realizzata attraverso lo scheduling di chiamate automatiche alla risorsa /createOffer che sceglie tra una lista di offerte disponibili per vari voli presenti in un file JSON, le offerte relative ad un volo specifico espresse in forma di lista di oggetti, le crea attraverso un opportuno metodo che traduce oggetti JSON in oggetti Java di tipo FlightOffer, nel caso si tratti di offerte last-minute converte gli oggetti FlightOffer in Flight e li manda ad ACMEsky, infine le salva sul DB. Si tratta di una risorsa privata del controller del servizio per cui non è chiamabile all'esterno. Lo scheduling che automatizza la creazione delle offerte avviene grazie all'annotazione @Scheduled, con un fixedRate fissato a 6 secondi. |
| POST/ getFlights  | ACMEsky recupera i voli di interesse degli utenti e fa una chiamata a questa risorsa passando la lista di voli richiesti dagli utenti per fare una ricerca di offerte specifica. Infatti questa api prende in input una lista di oggetti chiamati UserRequest e cerca nella repository le offerte che hanno la stessa data di partenza e arrivo e la stessa partenza e destinazione. Se queste non sono offerte last-minute e non sono già state prenotate da altri utenti (in entrambi casi stiamo parlando di offerte che ACMEsky ha già ricevuto) vengono "convertite" in oggetti Flight e vengono inviati. |
| DELETE/ purchasedOffer  | Le chiamate a questa risorsa consentono di cancellare le offerte di volo che vengono acquistate.  |
| GET/ bookOfferById  | La chiamata a questa risorsa consente di prenotare l'offerta che ha l'identificatore passato come parametro, se questa non è già stata prenotata ovviamente. Inoltre viene assegnata la data del momento in cui si riceve la prenotazione al campo expiryBooking per poter verificare che l'utente acquisti l'offerta prenotata entro pochi minuti dalla prenotazione, altrimenti l'offerta tornerà disponibile alla prenotazione di altri utenti.  |
| DELETE/ deleteBooking | La cancellazione delle prenotazioni avviene attraverso lo scheduling di chiamate a questa api ogni 6 secondi. Per ogni offerta presente sul DB si verifica che questa sia già stata prenotata e, nel caso si controlla che non siano passati i minuti di scadenza della prenotazione. Se la prenotazione è effettivamente scaduta, il bookedFlag viene reimpostato a false e la data di scadenza relativa all'offerta viene cancellata. |
| DELETE/ deleteExpiredOffer | La cancellazione delle offerte scadute avviene attraverso lo scheduling di chiamate a questa risorsa ogni 6 secondi. Per ogni offerta presente sul DB si cancellano le offerte che hanno la data di scadenza precedente o uguale a quella in cui si effettua la chiamata. |
| GET/ getTickets  | Le chiamate a questa risorsa che hanno come parametro la lista di identificatori delle offerte che l'utente ha acquistato consentono di ricevere i biglietti salvati in formato pdf. Nello specifico si prepara una chiamata POST che ha al suo interno un body che include un file per ciascun offerta acquistata, si impostano gli header e infine la si invia ad ACMEsky attraverso la route "http://localhost:8080/OfferPdfFile". |
| GET/ getIban | Le chiamate a questa risorsa consentono di conoscere l'iban della compagnia AirlineService, utile per il servizio bancario che dovrà effettuare il pagamento dell'utente.  |

