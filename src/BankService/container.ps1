Write-Host "BUILD BANK SERVICE"
Write-Host "CREATING JAR"
mvn clean package
Write-Host "RUNNING DOCKER CONTAINER"
docker-compose up --build
Write-Host "DONE :)"