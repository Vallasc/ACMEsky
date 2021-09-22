
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
