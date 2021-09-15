
# Prontogram

Prontogram è una applicazione web che riceve le offerte dei voli da ACMEsky, attraverso un sistema di notifiche web.
Le offerte ricevute vengono generate da ACMEsky, dopo che l'utente ha inserito su ACMEsky le preferenze su dei voli di proprio interesse.
L'offerta comprende sia il volo di andata si il volo di ritorno.
L'istanza dell'offerta ricevuta è in formato JSON, più precisamente è un array che contiene l'username dell'utente al quale è indirizzata la notifica dell'offerta e un messaggio scritto in HTML,  il quale verrà utilizzato per rappresentare graficamente il messaggio all'interno della sezione notifiche di Prontogram.
L'applicazione web di Prontogram si divide in due parti: front-end e back-end. Entrambe vengono istanziate grazie a Docker, in particolare al docker-compose.
La parte back-end rappresenta il server di Prontogram e si occupa di gestire tutte le chiamate delle API da e verso la parte client di Prontogram. Mentre la parte fornt-end si occupa di creare l'interfaccia grafica e gestire le iterazioni da parte dell'utente.


## Informazioni generali su tecnologie e scelte progettuali del servizio
Come precedentemente enunciato, Prontogram si divide in due parti rispettivamente, parte front-end e parte back-end. Ognuna di queste è stata implementata utilizzando tecnologie e pattern strutturali diversi. 

## Front-end
La parte front-end è stata realizzata con il framework Angular, il quale consente di scomporre l'interfaccia utente in blocchi gestibili e di separare l'interfaccia utente dall'implementazione rendendo la generazione di pagine lato server molto più semplice. L'architettura modulare di Angular consente di strutturare al meglio un'applicazione e permette di semplificare il processo di creazione di SPA (Single page application).
La parte front-end di Prontogram è stata implementata in tre macro componenti:
- AccountComponent : componente che gestisce la parte di login e registrazione dell'utente;
- NotificationComponent : componente che gestisce le notifiche delle offerte ricevute da ACMEsky;
- UserComponent : componente che gestisce le informazioni relative all'utente, permettendo di modificare le informazioni inserite da quest'ultimo durante la fase di registrazione alla web application.
Per quanto riguarda le tecnologie usate per implementare il sistema di notifiche, è stato utilizzato il servizio "service worker" fornito da Angular. La comunicazione tra applicazione web e server viene stabilita utilizzando una coppia di chiavi VAPID. VAPID è l'acronimo di "Voluntary Application Server Identification" per il protocollo Web Push. Una coppia di chiavi VAPID è una coppia di chiavi crittografiche pubbliche/private che viene utilizzata nel seguente modo:
- Chiave pubblica: viene utilizzata come identificatore univoco del server per iscrivere l'utente alle notifiche inviate da quest'ultimo;
- Chiave privata : deve essere tenuta segreta (a differenza della chiave pubblica) e viene utilizzata dall'application server per firmare i messaggi, prima di inviarli al servizio Push per la consegna del messaggio.

### Back-end
La parte back-end di Prontogram è stata realizzata utilizzando Node.js, un runtime system open source multipiattaforma orientato agli eventi per l'esecuzione di codice JavaScript. Più nello specifico è stato utilizzato Express.js un web framework per Node.js, il quale offre strumenti di base per creare più velocemente applicazioni in Node. Express.js ha permesso di realizzare un server abbastanza facilmente andando a generare le route (URL) utilizzate da ACMEsky e Prontogram durante le chiamate REST.
Il package models include la classe per la definizione della notifica di un'offerta, ovvero notification, la classe per la definizione dell'utente, ovvero user, e la classe per la definizione della sottoscrizione al server, ovvero subscription.
Inoltre è presente un package routes il quale contiene tutti i path/percorsi per gestire le chiamate alle API del server.
Per salvare i dati ricevuti e inviati dal server è stato utilizzato MongoDB un DBMS non relazionale, orientato ai documenti. 

### API
[API link](https://vallasc.github.io/ACMEsky/src/SwaggerUI/index.html?src=https://vallasc.github.io/ACMEsky/src/Prontogram/api.json)

<iframe title="API"
    width="900"
    height="1850"
    class="hidden"
    src="
    https://vallasc.github.io/ACMEsky/src/SwaggerUI/index.html?src=https://vallasc.github.io/ACMEsky/src/Prontogram/api.json
    ">
</iframe>

### Risorse e descrizione

| Risorsa  | Descrizione |
| ------------- | ------------- |
| POST/ notification/posts/ | Esegue la creazione della notifica e il salvataggio della notifica nel database poi inviarla a Prontogram attraverso il metodo sendNotification(). L'invio dell'offerta avviene in seguito ad una ricerca nel database dell'utente al quale è indirizzata. Gli utenti prima di ricevere le notifiche delle offerte dei voli devono aver eseguito la sottoscrizione al server, la quale avviene in automatico dopo aver effettuato il login all'applicazione web Prontogram. |
| DELETE/ notification/posts/:notificationId | Esegue la cancellazione di una notifica di un'offerta attraverso il passaggio come parametro dell'Id della notifica. |
| GET/ notification/gets/all/:username | Esegue il caricamento di tutte le notifiche delle offerte, attraverso il passaggio come parametro dell'username dell'utente corrispondente. |
| POST/ subscription/post/new | Esegue la creazione e il salvataggio in database della sottoscrizione di un'utente al servizio di notifiche. Quest'ultima avviene in automatico dopo aver effettuato il login all'applicazione web Prontogram. |
| DELETE/ subscription/posts/:subendpoint | Esegue l'annullamento della sottoscrizione e la cancellazione di quest'ultima dal database. La chiamata a questa route avviene in automatico dopo aver effettuato il logout dall'applicazione web Prontogram. |
| GET/ subscription/gets/all |  La chiamata a questa route permette di reperire tutte le sottoscrizioni effettuate dagli utente al server. |
| POST/ user/posts/ | Esegue la creazione di un nuovo utente e il suo salvataggio nel database. |
| DELETE/ user/posts/:userId | Esegue l'eliminazione di un utente dal database, attraverso il passaggio come parametro dell'Id dell'utente corrispondente. |
| PUT/ user/posts/:userId | Esegue l'update delle informazioni relative ad un'utente, attraverso il passaggio come parametro dell'Id dell'utente corrispondente. |
| GET/ user/gets/:id | La chiamata a questa route permette di reperire le informazioni relative ad un'utente, attraverso il passaggio come parametro dell'Id dell'utente corrispondente.|
| GET/ user/gets/all |  La chiamata a questa route permette di reperire tutte le informazioni relative a tutti gli utenti presenti in database. |
| POST/auth/register | Esegue la registrazione di un utente a Prontogram andando a creare e salvare in database tutte le informazioni relative ad un'utente inserite durante la fase di registrazione. |
| POST/auth/login | Esegue il login da parte di un utente a Prontogram. |

### URI
Tutti gli URI riferiti ai vari container che ospitano i servizi di Prontogram sono i seguenti:
```sh
- http://localhost:8050 per Prontogram back-end
- http://localhost:8051 per Prontogram front-end
- http://localhost:8052 per MongoDB 
```
### How to build
```sh
cd front-end
npm install
ng build --prod  
```

### How to run
```sh
cd static 
http-server 
```

### Run on Docker Compose
```sh
docker-compose up --build
```

\
\
&nbsp;
