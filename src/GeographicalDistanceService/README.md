
# Geographical distance service
Servizio che si occupa di calcolare la distanza tra due punti specificati tramite indirizzo o coordinate geografiche. E' stato sviluppato utilizzando la libreria express.js, internamente utilizza le api di distancematrix.ai per il calcolo delle distanze.

### API:
| Risorsa | Parametri |
| - | -|
| GET `/distance` | **from**: indirizzo di partenza. |
| | **to**: indirizzo di arrivo. |

### Esempio 
```sh
http://localhost:8080/distance?from=Mura+Anteo+Zamboni+7+40126+Bologna+%28BO%29%0D%0A&to=Ferrara
```

## Come eseguire
```sh
npm install
node index.js -p 8080
```

## Eseguire con Docker Compose
```sh
docker-compose up
```
&nbsp;
<div class="page-break"></div>
