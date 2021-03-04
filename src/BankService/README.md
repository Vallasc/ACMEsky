# ACMEbank
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
