
# Bank service
Bank è il servizio con cui ACMEsky si interfaccia per la gestione dei pagamenti.
ACMEsky richiede a Bank i link di pagamento che poi verrano utilizzati dall'utente per pagare. Inoltre una volta effettuato il pagamento invia un messaggio ad ACMEsky con la relativa conferma.
Tutte le richieste che vengono fatte alla banca devono esere autenticate utilizzando il token JWT che può essere richieste utilizzando la route /path.

### API:
```sh
http://localhost:8070/swagger-ui.html
```

<iframe title="API"
    width="900"
    height="1400"
    src="
    https://vallasc.github.io/ACMEsky/src/SwaggerUI/index.html?src=https://vallasc.github.io/ACMEsky/src/BankService/openapi.json&token=eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiYW5rSldUIiwic3ViIjoiOTI1NDYxIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9VU0VSIl0sImlhdCI6MTYyNDI5MTI5MywiZXhwIjoxNjI1Mzg1Mjk4fQ.xklR5LsgPF0cuI9Ico57g5QuvOJUH9DQyPt7H_RQoDHTk6XqR1Je7-T5wOiQY4CmMI9TR-UffZl_4254pg42wA
    ">
</iframe>

### Build fat Jar:
```sh
mvn package
```

### Come eseguire
```sh
mvnw spring-boot:run
```

### Build e run con Docker compose
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

<div class="page-break"></div>
