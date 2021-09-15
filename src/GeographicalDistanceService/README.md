
# Geographical Distance Service
Servizio che si occupa di calcolare la distanza tra due punti specificati tramite indirizzo o coordinate geografiche.
Internamente utilizza le api di distancematrix.ai per il calcolo delle distanze.

### Run:
```sh
npm install
node index.js -p 8080
```

### Run con Docker compose
```sh
docker-compose up
```

### API:
| Metodo | Path | Parametri |
| - | - | -|
| GET | /distance | from: Luogo di partenza; to:Luogo di arrivo. |

### Esempio
```sh
http://localhost:8080/distance?from=Mura+Anteo+Zamboni+7+40126+Bologna+%28BO%29%0D%0A&to=Ferrara
```
