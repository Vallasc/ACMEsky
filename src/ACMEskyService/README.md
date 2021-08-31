# ACMEsky

ACMEskyService, il servizio principale del progetto

### comando per fare la build

```sh
mvn package
```

### comando per fare la build del servizio e far partire il container Docker

```sh
docker-compose up --build
```

### API:

```sh
http://localhost:8080/swagger-ui.html
```

<iframe title="API"
    width="900"
    height="900"
    src="
    https://vallasc.github.io/ACMEsky/src/SwaggerUI/index.html?src=https://vallasc.github.io/ACMEsky/src/ACMEskyService/swagger/open-api.json
    ">
</iframe>

## Documentazione

ACMEskyService è il servizio principale di ACMEsky che si relaziona con i vari servizi (ACMEskyWeb, AirlineServices, RentServices, Prontogram, BankService,...) al fine di consentire agli utenti di prenotare ed acquistare le offerte di volo che desiderano.

ACMEskyService comunica con il servizio di ACMEskyDB (il quale consiste nel Database di PostgreSQL e del tool di pgAdmin4) per registrare gli utenti e i vari servizi che comunicano con ACMEsky, in modo da poterli riconoscere quando inviano richieste HTTP, anche per salvare le offerte di volo richieste dagli utenti (e i rispettivi voli), i voli delle compagnie aeree (last-minute e non), tutti gli aereoporti mondiali in codice IATA e le offerte di volo generate dai voli acquisiti dai servizi di volo secondo le offerte di interesse degli utenti. Inoltre interagisce con ACMEskyWeb per interfacciarsi con gli utenti: infatti raccoglie le offerte di volo che ciascun utente desidera, al momento dell'accettazione dell'inserimento del token per acquistare l'offerta verifica dal token se l'offerta è ancora valida e procede con il pagamento e del risultato dell'azione (restituzione del biglietto o cancellazione della prenotazione e rimborso). Infine il servizio di ACMEsky consentirà all'utente di visualizzare i biglietti dei voli precedentemente acquistati dopo aver applicato eventuali servizi aggiuntivi.
ACMEskyService si relaziona con i servizi di AirlineService (compagnie aeree) al fine di cercare, tra i voli che offrono, quelli corrispondenti a voli di interesse degli utenti al fine di proporre loro offerte da acquistare, ricevere voli last-minute inviati dai servizi di volo con una certa frequenza, recuperare i biglietti dei voli che gli utenti vogliono acquistare tramite una richiesta HTTP alla compagnia aerea che offre i voli in questione (se non sono già stati prenotati in precedenza), e nel caso di errori o problemi di pagamento cancellare la prenotazione informando l'AirlineService corrispondente.
Per quanto riguarda il pagamento, il servizio interroga BankService, il servizio bancario, per richiedere il link di pagamento da inviare all'utente tramite il servizio di ACMEskyWeb, il quale poi interagirà con la banca per gestire il pagamento. Infine BankService informerà ACMEsky solo se l'esito è positivo (in caso contrario quest'ultimo dovrà occuparsi della compensazione).
Il servizio interagisce con il servizio di geolocalizzazione "GeolocalizationService" e con quelli dei servizi di noleggio "RentService" per applicare eventuali servizi aggiuntivi all'offerta di volo acquistata dell'utente. Al servizio di geolocalizzazione fa una richiesta HTTP per conoscere le posizioni dell'aereoporto del volo e dell'indirizzo dell'utente per calcolarne la distanza, mentre ai servizi di noleggio chiede se è possibile accompagnare i passeggeri dal loro indirizzo all'aereoporto con un mezzo. Infine ACMEsky aggiunge i dettagli precedentemente descritti.

# Panoramica

## Struttura del servizio e tecnologie utilizzate

tecnologie e struttura

## Risorse necessarie per tutti i servizi

| Risorsa     | Descrizione                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| POST/ auth/ | Questa risorsa è necessaria per tutti i servizi che vogliono fare una chiamata ad una qualsiasi risorsa di ACMEskyService. Si richiede un oggetto AuthRequestDTO come parametro: esso include un attributo username e un attributo password. Il servizio chiamante dovrà inserire nel body un JSON che include i valori dei due attributi e ACMEsky restituirà un token valido per tutte le richieste alle route che richiedono il ruolo del chiamante, a patto che le credenziali siano corrette. |

## Risorse per AirlineServices

| Risorsa                    | Descrizione                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| POST/ airlines/last_minute | Questa risorsa è riservata esclusivamente agli AirlineServices, quindi i servizi dovranno presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. La chiamata a questa risorsa richiede come parametro una lista di oggetti AirlineFlightOfferDTO che verrà passata ad un metodo che avvierà un task di Camunda che si occuperà di convertire la lista di DTO in oggetti Flight da salvare in DB. |

## Risorse per BankServices

| Risorsa                  | Descrizione                                                                                                                                                                                                                                                                                                                                                                                |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| GET/ bank/confirmPayment | Questa risorsa è riservata esclusivamente agli BankServices, quindi i servizi dovranno presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. La chiamata a questa risorsa richiede come parametro il token dell'offerta di volo acquistata dall'utente per informare ACMEskyService del fatto che l'offerta è stata acquistata. |

## Risorse per ACMEskyWeb

| Risorsa              | Descrizione                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| GET/ airports/       | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. Il servizio web di ACMEsky chiama questa risorsa passando la query di ricerca dell'aereoporto per recuperare la lista dei suggerimenti per gli aereoporti di partenza e di arrivo dei voli sulla base dei caratteri inseriti dagli utenti nei rispettivi form della pagina al momento della ricerca. |
| GET/ airports/{code} | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. Il servizio web di ACMEsky chiama questa risorsa passando la query di ricerca dell'aereoporto per recuperare l'aereoporto di partenza e di arrivo dei voli sulla base dei suggerimenti inseriti dagli utenti nei rispettivi form della pagina.                                                       |

| POST/ interests/ | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. Il servizio web di ACMEsky chiama questa risorsa con un oggetto DTO dell'offerta di volo di interesse dell'utente per consentire ad ACMEskyService di registrare l'interesse dell'utente in DB. |
| GET/ interests/ | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. Il servizio web di ACMEsky chiama questa risorsa senza parametri per recuperare la lista di tutte le offerte di interesse dell'utente che si è autenticato su ACMEskyWeb. |
| GET/ interests/{id} | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. ACMEskyWeb chiama questa risorsa per recuperare l'offerta di interesse corrispondente all'identificativo passato come parametro del path della richiesta. |
| DELETE/ interests/{id} | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. ACMEskyWeb chiama questa risorsa per cancellare l'offerta di interesse con lo stesso identificativo di quello passato come parametro del path della richiesta. |

| PUT/ offers/confirm | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. Il servizio web di ACMEsky chiama questa risorsa con un oggetto DTO dell'offerta di volo di interesse dell'utente come parametro per informare ACMEskyService del fatto che l'utente ha confermato l'offerta proposta inserendone il token. |
| PUT/ offers/paymentLink | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. Il servizio web di ACMEsky chiama questa risorsa passando il DTO dell'indirizzo dell'utente come parametro per informare ACMEskyService del fatto che lo stesso vuole acquistare l'offerta di volo per iniziare la procedura di pagamento. |
| PUT/ offers/reset | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. Il servizio web di ACMEsky chiama questa risorsa con un oggetto DTO dell'offerta di volo di interesse dell'utente come parametro per informare ACMEskyService di eventuali errori nella fase di pagamento che portano al reset del processo di conferma e acquisto dell'offerta. |
| GET/ offers/ | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. Il servizio web di ACMEsky chiama questa risorsa per recuperare le offerte generate da ACMEsky sulla base delle preferenze degli utenti, filtrando le offerte che non sono state acquistate. |
| GET/ offers/{token} | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. Il servizio web di ACMEsky chiama questa risorsa passando come parametro il token presente nel path della route per recuperare l'offerta generata con quel token se è già stata acquistata, si ottiene errore. |
| GET/ offers/{token}/ticket | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. Il servizio web di ACMEsky chiama questa risorsa passando come parametro il token presente nel path della route per recuperare il biglietto dell'offerta se acquistata, altrimenti si riceve errore. |

| GET/ users/me | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. Il servizio web di ACMEsky chiama questa risorsa per recuperare le informazioni principali dell'utente che si è autenticato. |
| POST/ users/ | Tutti i nuovi servizi e utenti possono effettuare chiamate a questa route per iscriversi nel DB di ACMEsky e interagire con i vari servizi al fine di raggiungere i propri scopi. Il servizio chiamante può effettuare chiamate a questa route passando come argomento un oggetto di tipo UserSignUpdDTO, contenente email, password, name, surname e prontogramUsername, per registrare un utente |
| PUT/ users/me | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. Il servizio web di ACMEsky chiama questa risorsa passando un parametro di tipo UserUpdateDTO contenente tutti i campi necessari ad ACMEskyService per modificare la password, il nome ed il cognome. |
| DELETE/ users/me | Questa risorsa è riservata esclusivamente al servizio ACMEskyWeb, che dovrà presentare un bearer token valido rilasciato da ACMEskyService con una richiesta alla risorsa di autenticazione. Il servizio web di ACMEsky chiama questa risorsa passando un parametro di tipo UserDeleteDTO contenente tutti i campi necessari ad ACMEskyService (username e password corretti) per cancellare l'utente con codeste credenziali da ACMEsky. |
