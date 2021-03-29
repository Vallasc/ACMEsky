Write-Host "BUILD RENT SERVICE"
docker build -t rent_service .
Write-Host "RUNNING DOCKER CONTAINER"
docker run --rm -d  -p 8083:8080/tcp rent_service
Write-Host "DONE :)"