Write-Host "BUILD GEOGRAPHICAL DISTANCE SERVICE"
Write-Host "CREATING DOCKER IMAGE"
docker build -t distance_service .
Write-Host "RUNNING DOCKER CONTAINER"
docker run --rm -d -p 8082:8080/tcp distance_service
Write-Host "DONE :)"