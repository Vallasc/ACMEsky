
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
