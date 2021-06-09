# ACMEbank
Drescrizione

### How to build

### How to run
#### docker

### How tobuild

### API
<a src="https://vallasc.github.io/ACMEsky/docs/swagger-ui/index.html?src=https://vallasc.github.io/ACMEsky/src/BankService/swagger.json">Link to API</a>
<!--
<div position="center">
  <iframe title="API"
      width="900"
      height="900"
      allowfullscreen="allowfullscreen" 
      frameborder="1"
      src="https://vallasc.github.io/ACMEsky/docs/swagger-ui/index.html?src=https://vallasc.github.io/ACMEsky/src/BankService/swagger.json">
  </iframe>
</div>
-->

A useless bank service
### Run:
```sh
mvnw spring-boot:run
```

### Build fat Jar:
```sh
mvn package
```

### Create and run on Docker container
```sh
docker build -t bank_service .
docker run --rm -d  -p 8080:8080/tcp bank_service
```

### API:
http://localhost:8080/swagger-ui.html

## DB console
http://localhost:8080/h2
URL: jdbc:h2:./db/bankdb
user: sa
passw: 
