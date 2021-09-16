
# Bank service

Bank è il servizio con cui ACMEsky si interfaccia per la gestione dei pagamenti.
ACMEsky richiede a Bank i link di pagamento che poi verrano utilizzati dall'utente per pagare. Inoltre una volta effettuato il pagamento invia un messaggio ad ACMEsky con la relativa conferma.
Tutte le richieste che vengono fatte alla banca devono esere autenticate utilizzando il token JWT che può essere richieste utilizzando la route `/path`.

## Tecnologie utilizzate e scelte progettuali

Il servizio è stato realizzato utilizzando il framework Spring boot che fornisce un ambiente per sviluppare applicazioni web JAVA. Per l'autenticazione degli utenti e l'autorizzazione delle richieste è stato utilizzata la libreria *Spring-Security* in accoppiata con *jsonwebtoken*.
Per la gestione dei dati è stato utlizzato *H2*, un DBMS leggero che permette di salvare il database in un unico file.

### Schermata di pagamento

![Ricevuta](doc/pagamento.png)

## API:
Il file OpenAPI è disponibile al seguente [link](https://vallasc.github.io/ACMEsky/src/BankService/openapi.json)


<iframe title="API"
    width="900"
    height="1400"
    class="hidden"
    src="
    https://vallasc.github.io/ACMEsky/src/SwaggerUI/index.html?src=https://vallasc.github.io/ACMEsky/src/BankService/openapi.json&token=eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiYW5rSldUIiwic3ViIjoiOTI1NDYxIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9VU0VSIl0sImlhdCI6MTYyNDI5MTI5MywiZXhwIjoxNjI1Mzg1Mjk4fQ.xklR5LsgPF0cuI9Ico57g5QuvOJUH9DQyPt7H_RQoDHTk6XqR1Je7-T5wOiQY4CmMI9TR-UffZl_4254pg42wA
    ">
</iframe>

## Risorse

| Risorsa | Descrizione |
| - | - |
| POST `/users` | Risorsa che permette di creare un nuovo utente. |
| GET `/users/me` | Risorsa che restituisce le informazioni dell'utente loggato. |
| POST `/payments` | Risorsa che permette di generare un link di pagamento. |
| GET `/payments` | Risorsa che restituisce la lista dei link di pagamento associati all'utente. |
| POST `/auth` | Risorsa per autenticarsi nel sistema, restituisce un JWT che dovrà essere inserito in tutte le richieste. |


## Esecuzione

### Build fat Jar:
```sh
mvn package
```

### Come eseguire
```sh
mvnw spring-boot:run
```

### Come eseguire con Docker Compose
```sh
docker-compose up --build
```

## Credenziali database
```sh
http://localhost:8070/h2
URL: jdbc:h2:./db/bankdb
user: sa
passw:
```

\
\
&nbsp;
