# AirlineService
Servizi AirlineService per generare voli da file json, 

### Build fat Jar:
```sh
mvn package
```

### Create and run on Docker container using docker-compose(the only way to run the project)
```sh
docker-compose build
docker-compose up
```

### API:
http://localhost:8080/swagger-ui.html

## DB console
http://localhost:8080/h2
URL: jdbc:h2:file:./db/db
user: sa
passw:


