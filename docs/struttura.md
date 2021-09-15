
# Struttura del sistema

In questa sezione si presenta la struttura interna di ACMEsky.

![struttura acmesky](struttura/structure1.png)

ACMEsky è stato sviluppato utilizzando *Java Enterprise Edition*. Per il deployment si è scelto *WildFly*, un application server open source multipiattaforma.
Come BPMS si è optato per *Camunda* che fornisce un deployment già configurato per *WildFly*.
I dati vengono gestiti da un database esterno al sistema.


ACMEsky, internamente, è stato suddiviso in più moduli, che rispecchiano la struttura del codice, ognuno dei quali svolge un ruolo specifico nel sistema complessivo. Essi sono:

- **Camunda Delegate**: Sono le classi Java che implementano le funzionalità dei task nei processi BPMN.

- **Model**: Contiene le classi che rappresentano i dati utilizzati da ACMEsky. Attraverso l'utilizzo del framework JPA (Java Persistence API) le classi del *Model* vengono mappate nelle tabelle del database in maniera automatica.

- **Business logic**: In essa sono contenute tutte le classi Java che, utilizzando il *Model*, si occupano di gestire la logica business dei servizi di ACMEsky. Inoltre, si interfaccia con il DBMS per manipolare e archiviare i dati che vengono elaborati.

- **Gateway**: Raggruppa tutte le classi che implementano le API RESTful e SOAP di ACMEsky. La Business logic comunica con il *Gateway* per inviare e ricevere i messaggi dall'esterno. Inoltre, attraverso il filtro *JWT* il *Gateway* autentica l'entità che effettua la richiesta e successivamente la autorizza a compiere operazioni su specifiche risorse. 

- **ACMEsky Web**: E' l'applicazione web di ACMEsky, essa permette all'utente di eseguire le richieste alle API di ACMEsky Sevice in maniera intuitiva per l'utente. ACMEsky Web non è strettamente necessario per effettuare le richieste ai servizi esposti da ACMEsky, in quanto quest'ultimo potrebbe essere interrogato attraverso un semplice client REST.

&nbsp;

## Diagramma dei servizi

![struttura totale](struttura/structure2.png)
Per simulare un ambiente reale, ogni servizio, o parti de esso, è stato "incapsulato" in un container docker. Il diagramma mostra i container che vengono creati utilizzando il file `docker-compose.yml` che si trova nella root del progetto.
Di seguito vengono spiegati brevemente i servizi e la loro counicazione con ACMEsky.

- **ACMEsky**
    - **ACMEsky Service**: Il server WildFly, che comprende il deplyment di ACMEsky e Camunda BPMS, è stato "incapsulato" in un container. Esso si interfaccia con un altro container che contiene il database.
    - **ACMEsky Web**: L'applicazione web gira su un server NGNIX e si interfaccia ad ACMEsky attraverso le sue API RESTful.
- **Airline Service**: E' il servizio che simula una compagnia aerea. I servizi di Airline Service sono due: uno che offre voli nazionali e uno che offre voli internazionali, modificando il file `docker-compose.yml` è possibile aggiungerne di nuovi o rimuovere quelli già presenti. Essi si interfacciano ad ACMEsky utilizzando le API RESTful.
- **Bank Service**: E' il servizio con cui ACMEsky si interfaccia per la gestione dei pagamenti. Comunica con ACMEsky attraverso API RESTful.
- **GeographicalDistanceService**
Geographical Distance Service è il servizio di geolocalizzazione che calcola la distanza tra due indirizzi. Comunica con ACMEsky attraverso API RESTful.
- **Prontogram**: Web-application che permette all'utente di ricevere le notifiche delle offerte dei voli dai servizi di ACMEsky. L'applicativo è stato sviluppato in Angular per quanto riguarda la parte front-end e in node.js per quanto riguarda la parte back-end. Comunica con ACMEsky attraverso API RESTful.
- **Rent Service**: E' il servizio noleggio con autista. E' stato scritto in Jolie. Comunica con ACMEsky attraverso SOAP. Nel deployment sono 

&nbsp;

## Porte assegnate ai servizi in Docker

| Service | Port |
| - | - |
| ACMEsky Service | 8080 |
| ACMEsky Web | 80 |
| Postgres | 5050 |
| BankService | 8070 |
| AirlineNationalService | 8060 |
| AirlineService | 8061 |
| ProntogramService | 8050 |
| ProntogramFrontEnd | 8051 |
| GeocraphicalService | 8040 |
| RentService1 | 8030 |
| RentService2 | 8032 |

&nbsp;
<div class="page-break"></div>
