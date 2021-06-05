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
```sh
Airline Service è il servizio che consente agli utenti del servizio ACMEsky di acquistare i biglietti per i voli che esso offre.
Invia ad ACMEsky offerte last-minute, invia su richiesta di ACMEsky le offerte di volo relative ai voli di interesse degli utenti.
Gestisce le prenotazioni delle offerte e le offerte di volo scadute, elimina le offerte di volo che vengono acquistate e manda i biglietti relativi ai voti che vengono acquistati dagli utenti ad ACMEsky.
Infatti gli utenti non interagiscono direttamente con AirlineService, ma attraverso ACMEsky.

Ci sono 2 istanze di AirlineService accessibili da ACMEsky al momento, ovvero airlineservice_national e airlineservice_international. 
La prima istanza offre voli verso e da aereoporti nazionali, mentre la seconda offre voli da e verso aereoporti internazionali. Per il resto i due servizi si comportano allo stesso modo (creazione automatica delle offerte, invio di offerte last-minute, gestione delle prenotazioni e delle offerte scadute e invio biglietti, ecc.).
```

## Panoramica

### URI
Tutti gli URI riferiti ai vari container che ospitano i servizi di AirlineService sono i seguenti:
```sh
- http://localhost:8082 per airlineservice_national
- http://localhost:8083 per airlineservice_international
```

### Risorse e descrizione
| Risorsa  | Descrizione |
| ------------- | ------------- |
| POST/ createOffer | La creazione delle offerte di volo, sia nazionali e internazionali, è stata realizzata attraverso lo scheduling di chiamate automatiche alla risorsa /createOffer che sceglie tra una lista di offerte disponibili per vari voli presenti in un file JSON, le offerte relative ad un volo specifico espresse in forma di lista di oggetti, le crea attraverso un opportuno metodo che traduce oggetti JSON in oggetti Java di tipo FlightOffer, nel caso si tratti di offerte last-minute converte gli oggetti FlightOffer in FlightDTO e li manda ad ACMEsky, infine le salva sul DB. Si tratta di una risorsa privata del controller del servizio per cui non è chiamabile all'esterno. Lo scheduling che automatizza la creazione delle offerte avviene grazie all'annotazione @Scheduled, con un fixedRate fissato a 6 secondi. |
| POST/ searchFlights  | ACMEsky recupera i voli di interesse degli utenti e fa una chiamata a questa risorsa passando la lista di voli richiesti dagli utenti per fare una ricerca di offerte specifica. Infatti questa api prende in input una lista di oggetti chiamati UserRequest e cerca nella repository le offerte che hanno la stessa data di partenza e arrivo e la stessa partenza e destinazione. Se queste non sono offerte last-minute e non sono già state prenotate da altri utenti (in entrambi casi stiamo parlando di offerte che ACMEsky ha già ricevuto) vengono "convertite" in oggetti FlightDTO e vengono inviati. |
| DELETE/ PurchasedOffer  | Le chiamate a questa risorsa consentono di cancellare le offerte che vengono acquistate  |
| GET/ bookOfferById  | Content Cell  |
| POST/ deleteBooking | Content Cell  |
| POST/ deleteExpiredOffer | Content Cell  |
| GET/ getTickets  | Content Cell  |
| GET/ getIban | Le chiamate a questa risorsa servono per ottenere l'iban della compagnia AirlineService, utile per il servizio bancario che dovrà effettuare il pagamento dell'utente.  |



La gestione delle prenotazioni e dell'eliminazione delle offerte scadute è stata realizzata attraverso lo scheduling di due chiamate automatiche ad un api che si occupa di cancellare la prenotazione di un offerta di volo se un utente si è prenotato, ma il pagamento non va a buon fine per un motivo o l'altro entro 10 minuti dalla prenotazione, mentre l'altra api si occupa di cancellare le offerte di volo che semplicemente sono scadute. Entrambe vanno ad interagire con le offerte oggetto di interesse che si trovano sul DB.
La cancellazione delle offerte di volo che vengono acquistate dal DB avviene attraverso 

