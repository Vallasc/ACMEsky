
# Diagrammi UML

In questa sezione vengono mostrati i diagrammi UML, il cui scopo principale è quello di descrivere le interazioni che vi sono tra i vari servizi che fanno parte della *SOA* (Service Oriented Architecture), attraverso l'utilizzo di ***capability*** e ***interface***. I diagrammi sono stati implementati utilizzando il profilo TinySOA.

Nei diagrammi UML sono riportate tre diverse tipologie di servizi:
* __Task__: espone le ***capability*** facenti parte dei processi interni all'organizzazione;
* __Entity__: fa riferimento ad una singola attività, possibilmente automatizzata;
* __Utility__: sono simili ai task, però non appartengono al dominio del problema.

## Ricerca voli
![Ricerca voli](UML/img/diagram1.png)
Nel diagramma riportato qui sopra vengono descritte le ***capabilty*** inerenti alla ricerca voli. In particolare, per il ruolo di ACMESky sono definite le seguenti ***capability***: ***FlightsManagement*** e ***DatabaseManagement***; Le quali vengono esposte da due interfacce ***Flights*** e ***Database***.
La capability ***FlightsManagement*** ha lo scopo di interrogare e ricevere le offerte di voli dalle compagnie aeree. Mentre, la capability ***DatabaseManagement*** si occupa di salvare le offerte ricevute dalle compagnie aeree nella base dati.

## Ricezione offerte last-minute
![Ricezione offerte last-minute](UML/img/diagram2.png)
Nel diagramma riportato qui sopra vengono descritte le capabilty inerenti alla ricezione delle offerte last-minute. In particolare per il ruolo di ACMESky sono definite le seguenti ***capability***: ***LastminuteFlightsManagement*** e ***DatabaseManagement***; Le quali vengono esposte da due interfacce ***LastMinuteFlights*** e ***DataBase***.
La capability ***FlightsManagement*** ha lo scopo di ricevere le offerte dei voli last-minute dalle compagnie aeree. Quest'ultime verranno poi memorizzate nella base dati  attraverso la capability ***DatabaseManagement***.

## Controllo periodico dei voli compatibili con gli interessi degli utenti 
![Controllo periodico dei voli compatibili con gli interessi degli utenti](UML/img/diagram3.png)
Nel diagramma riportato qui sopra vengono descritte le capabilty inerenti alla ricezione delle offerte last-minute. In particolare per il ruolo di ACMESky sono definite le seguenti ***capability***: ***MatchingFlightsManagement*** e ***DatabaseManagement***; Le quali vengono esposte da due interfacce ***HourlyMatchFlights*** e ***DataBase***.
La capability ***MatchingFlightsManagement***, dopo avere reperito i voli dalla base dati attraverso ***DatabaseManagement***, ha lo scopo di trovare l'offerta compatibile con quella di interesse per l'utente. Inoltre la capability ***MatchingFlightsManagement*** dipende dalla capability di invio messaggi di Prontogram, ***MessageManagement*** esposta dalla relativa interfaccia: ***Message***.
Per contattare l'utente la capability di Prontogram (***MessageManagement***) dipende da un'altra capability ***NotifyMessage*** la quale ha lo scopo di segnalare all'utente la presenza di nuovi voli attraverso un messaggio di notifica.

## Invio richiesta del volo da parte dell'utente
![Utente invia la richiesta di volo](UML/img/diagram4.png)
Nel diagramma riportato qui sopra vengono descritte le capabilty inerenti all'invio da parte di un utente della richiesta di un volo.
In particolare per il ruolo di ACMESky sono definite le seguenti ***capability***: ***UserInterestManagement*** e ***DatabaseManagement***; Le quali vengono esposte da due interfacce rispettivamente ***UserInterest*** e ***DataBase***.
In particolare la capability ***UserInterestManagement*** si occupa di ricevere la richiesta di un volo da parte di un utente esponendo quindi una dipendenza per la capability ***UserRequestManagment***, la quale ha lo scopo di inviare la richiesta dell'utente.
Invece, la capability ***DatabaseManagement*** si occupa di salvare la richiesta nella base dati di ACMESky.


## Controllo dell'offerta con token
![Controllo offerta con token](UML/img/diagram5.png)
Nel diagramma riportato qui sopra vengono descritte le capabilty inerenti al controllo dell'offerta di interesse attraverso l'utilizzo del token inviato dall'utente.
In particolare per il ruolo di ACMESky sono definite le seguenti ***capability***: ***TokenManagement*** e ***DatabaseManagement***; Le quali vengono esposte da due interfacce rispettivamente ***ReceiveToken*** e ***DataBase***.
Queste capability permettono al sistema di ricevere il token da parte di un utente, verificare la correttezza del token ricevuto e reperire la relativa
offerta dalla base dati di ACMESky.
 La capability ***TokenManagement*** dipende dalle interfacce che espongono la capability ***TokenManagement*** dell'utente per poter verificare la validità del codice inserito.

## Gestione dei pagamenti
![Gestione dei pagamenti](UML/img/diagram6.png)
Nel diagramma riportato qui sopra vengono descritte le capabilty inerenti alla gestione dei pagamenti effettuati dall'utente indirizzati ai vari servizi.
In particolare per il ruolo di ACMESky sono definite le seguenti ***capability***: ***BankManagement*** e ***TicketsManagement***; Le quali vengono esposte da un'unica interfaccia ***Bank*** e ***Tickets***.
La capability ***BankManagement*** di ACMESky si occupa di ricevere il link di pagamento dalla banca e di inviarlo all'utente. Quest'ultima riceve anche tutte le informazioni relative ad un avvenuto pagamento.
La capability ***TicketsManagement*** si occupa di prenotare il volo o di eliminare la prenotazione in caso di errori.

## Servizi accessori e ricezione tickets 
![Servizi accessori e ricezione tickets ](UML/img/diagram7.png)
Nel diagramma riportato qui sopra vengono descritte le capabilty inerenti ai servizi accessori e ricezione dei tickets di interesse.
In particolare per il ruolo di ACMESky sono definite le seguenti ***capability***: ***PremiumServiceManagement*** e ***OrderManagement***; Le quali vengono esposte da un'unica interfaccia ***PremiumService*** e ***Order***.
La capability ***PremiumServiceManagement*** si occupa di controllare tutte le condizioni per poter attivare il servizio premium, ossia controlla il prezzo dell'offerta, la distanza dall'aeroporto e l'eventuale prenotazione di un servizio di trasporto.
Infine la capability ***OrderManagement*** ha il compito di inviare i tickets richiesti dall'utente.

&nbsp;
<div class="page-break"></div>
