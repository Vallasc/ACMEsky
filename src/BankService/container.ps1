Write-Host "BUILD BANK SERVICE"
Write-Host "CREATING JAR"
mvn clean package
Write-Host "CREATING DOCKER IMAGE"
docker build -t bank_service .
Write-Host "RUNNING DOCKER CONTAINER"
docker run --name=[bank_service] --rm -d  -p 8080:8080/tcp bank_service
Write-Host "DONE :)"