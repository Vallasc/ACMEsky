# Bank service
Drescrizione

### How to build

### How to run
#### docker

### How tobuild

### API
[API link](https://vallasc.github.io/ACMEsky/docs/swagger-ui/index.html?src=https://vallasc.github.io/ACMEsky/src/BankService/openapi.json&token=eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiYW5rSldUIiwic3ViIjoiOTI1NDYxIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9VU0VSIl0sImlhdCI6MTYyNDI5MTI5MywiZXhwIjoxNjI1Mzg1Mjk4fQ.xklR5LsgPF0cuI9Ico57g5QuvOJUH9DQyPt7H_RQoDHTk6XqR1Je7-T5wOiQY4CmMI9TR-UffZl_4254pg42wA)

<iframe title="API"
    width="900"
    height="900"
    src="
    https://vallasc.github.io/ACMEsky/docs/swagger-ui/index.html?src=https://vallasc.github.io/ACMEsky/src/BankService/openapi.json&token=eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiYW5rSldUIiwic3ViIjoiOTI1NDYxIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9VU0VSIl0sImlhdCI6MTYyNDI5MTI5MywiZXhwIjoxNjI1Mzg1Mjk4fQ.xklR5LsgPF0cuI9Ico57g5QuvOJUH9DQyPt7H_RQoDHTk6XqR1Je7-T5wOiQY4CmMI9TR-UffZl_4254pg42wA
    ">
</iframe>



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
