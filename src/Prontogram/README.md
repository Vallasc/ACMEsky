
# Prontogram

Prontogram è una applicazione web che permette di inviare notifiche agli utenti che vi sono iscritti.
I messaggi inviati possono essere formattati utilizzado HTML, questo permette di rappresentare i dati in modo complesso, come ad esempio in una tabella.

L'applicazione di Prontogram si divide in due parti: front-end e back-end.
La parte back-end si occupa di gestire tutte le chiamate delle API da e verso il client web. Mentre la parte fornt-end si occupa di creare l'interfaccia grafica e gestire le interazioni da parte dell'utente.


## Tecnologie e scelte progettuali del servizio
La parte front-end e la parte back-end sono state sviluppate utilizzando tecnologie e pattern strutturali differenti. 

### Front-end
La parte front-end è stata realizzata utilizzando il framework Angular, il quale consente di scomporre l'interfaccia utente in blocchi gestibili e di separare l'interfaccia utente dall'implementazione rendendo la generazione di pagine lato server molto più semplice. L'architettura modulare di Angular consente di strutturare al meglio un'applicazione e permette di semplificare il processo di creazione della SPA (Single page application).

La parte front-end di Prontogram è formata da 3 micro-componenti:
- **AccountComponent** : componente che gestisce la parte di login e registrazione dell'utente;
- **NotificationComponent** : componente che gestisce le notifiche delle offerte ricevute da ACMEsky;
- **UserComponent** : componente che gestisce le informazioni relative all'utente, permettendo di modificare le informazioni inserite da quest'ultimo durante la fase di registrazione alla web application.

Per implementare il sistema di notifiche, è stato utilizzato il servizio "service worker" fornito da Angular. La comunicazione tra applicazione web e server viene stabilita utilizzando una coppia di chiavi VAPID. VAPID è l'acronimo di "Voluntary Application Server Identification" per il protocollo Web Push. Una coppia di chiavi VAPID è una coppia di chiavi crittografiche pubbliche/private che viene utilizzata nel seguente modo:
- *Chiave pubblica*: viene utilizzata come identificatore univoco del server per iscrivere l'utente alle notifiche inviate da quest'ultimo;
- *Chiave privata*: deve essere tenuta segreta (a differenza della chiave pubblica) e viene utilizzata dall'application server per firmare i messaggi, prima di inviarli al servizio Push per la consegna del messaggio.

### Back-end
La parte back-end è stata realizzata utilizzando Node.js, un runtime system open source multipiattaforma orientato agli eventi per l'esecuzione di codice JavaScript. Più nello specifico è stato utilizzato Express.js un web framework per Node.js, il quale offre strumenti di base per creare più velocemente applicazioni web.
Il package *models* include la classe per la definizione della notifica (*notification*), la classe per la definizione dell'utente (*user*) e la classe per la definizione della sottoscrizione al server(*subscription*).
Inoltre, è presente il package *routes*, il quale contiene tutti i percorsi per gestire le chiamate alle API del server.
Per salvare i dati ricevuti e inviati dal server è stato utilizzato MongoDB, un DBMS non relazionale orientato ai documenti. 

## API
Il file OpenAPI è disponibile al seguente [link](https://vallasc.github.io/ACMEsky/src/SwaggerUI/index.html?src=https://vallasc.github.io/ACMEsky/src/Prontogram/api.json)

<iframe title="API"
    width="900"
    height="1850"
    class="hidden"
    src="
    https://vallasc.github.io/ACMEsky/src/SwaggerUI/index.html?src=https://vallasc.github.io/ACMEsky/src/Prontogram/api.json
    ">
</iframe>

## Risorse

| Risorsa  | Descrizione |
| - | - |
| POST `/notification/posts` | Esegue la creazione della notifica e il salvataggio della notifica nel database per poi inviarla a Prontogram attraverso il metodo sendNotification(). L'invio dell'offerta avviene in seguito ad una ricerca nel database dell'utente al quale è indirizzata. Gli utenti prima di ricevere le notifiche delle offerte dei voli devono aver eseguito la sottoscrizione al server, la quale avviene in automatico dopo aver effettuato il login all'applicazione web Prontogram. |
| DELETE `/notification/posts/{notificationId}` | Esegue la cancellazione di una notifica di un'offerta attraverso il passaggio come parametro dell'Id della notifica. |
| GET `/notification/gets/all/{username}` | Esegue il caricamento di tutte le notifiche delle offerte, attraverso il passaggio come parametro dell'username dell'utente corrispondente. |
| POST `/subscription/post/new` | Esegue la creazione e il salvataggio in database della sottoscrizione di un'utente al servizio di notifiche. Quest'ultima avviene in automatico dopo aver effettuato il login all'applicazione web Prontogram. |
| DELETE `/subscription/posts/{subendpoint}` | Esegue l'annullamento della sottoscrizione e la cancellazione di quest'ultima dal database. La chiamata a questa route avviene in automatico dopo aver effettuato il logout dall'applicazione web Prontogram. |
| GET `/subscription/gets/all` |  La chiamata a questa route permette di reperire tutte le sottoscrizioni effettuate dagli utente al server. |
| POST `/user/posts/` | Esegue la creazione di un nuovo utente e il suo salvataggio nel database. |
| DELETE `/user/posts/{userId}` | Esegue l'eliminazione di un utente dal database, attraverso il passaggio come parametro dell'Id dell'utente corrispondente. |
| PUT `/user/posts/{userId}` | Esegue l'update delle informazioni relative ad un'utente, attraverso il passaggio come parametro dell'Id dell'utente corrispondente. |
| GET `/user/gets/{id}` | La chiamata a questa route permette di reperire le informazioni relative ad un'utente, attraverso il passaggio come parametro dell'Id dell'utente corrispondente.|
| GET `/user/gets/all` |  La chiamata a questa route permette di reperire tutte le informazioni relative a tutti gli utenti presenti in database. |
| POST `/auth/register` | Esegue la registrazione di un utente a Prontogram andando a creare e salvare in database tutte le informazioni relative ad un'utente inserite durante la fase di registrazione. |
| POST `/auth/login` | Esegue il login da parte di un utente a Prontogram. |

## URI
```sh
- http://localhost:8050 per Prontogram back-end
- http://localhost:8051 per Prontogram front-end
- http://localhost:8052 per MongoDB 
```
## Esecuzione

### Come fare la build
```sh
cd front-end
npm install
ng build --prod  
```

### Come eseguire
```sh
cd static 
http-server 
```

### Eseguire con Docker Compose
```sh
docker-compose up --build
```

\
\
&nbsp;
