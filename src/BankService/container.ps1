Write-Host "CREATING JAR"
mvn package
Write-Host "CREATING DOCKER IMAGE"
docker build -t bank_service:0.0.1 .
Write-Host "RUNNING DOCKER CONTAINER"
docker run --rm -d  -p 8080:8080/tcp bank_service:0.0.1
Write-Host "DONE :)"