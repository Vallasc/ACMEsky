# AirlineService
A very simple AirlineService
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
docker build -t airline-service .
docker run --rm -d  -p 8080:8080/tcp airline-service
```

### API:
http://localhost:8080/swagger-ui.html

## DB console
http://localhost:8080/h2
URL: jdbc:h2:file:./db/db
user: sa
passw: 
