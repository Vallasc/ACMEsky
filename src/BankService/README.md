# ACMEbank
Drescrizione

### How to build

### How to run
#### docker

### How tobuild

### API

<div>
  <iframe id="inlineFrameExample"
      title="Inline Frame Example"
      width="900"
      height="900"
      src="https://www.openstreetmap.org/export/embed.html?bbox=-0.004017949104309083%2C51.47612752641776%2C0.00030577182769775396%2C51.478569861898606&layer=mapnik">
  </iframe>
</div>







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
