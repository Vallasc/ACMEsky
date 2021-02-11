Run:
mvnw spring-boot:run

Buid fat Jar:
mvn package

docker build -t bank_service:0.0.1 .
docker run --rm -d  -p 8080:8080/tcp bank_service:0.0.1

API:
http://localhost:8080/swagger-ui