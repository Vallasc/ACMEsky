# Geographical Distance Service

### Run:
```sh
npm install
node index.js -p 8080
```

### Create and run on Docker container
```sh
docker build -t distance_service:0.0.1 .
docker run --rm -d -p 8082:8080/tcp distance_service:0.0.1
```

### API:
GET /distance?from=bologna&to=ferrara
