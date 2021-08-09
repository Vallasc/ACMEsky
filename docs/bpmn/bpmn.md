# Documentazione bpmn


In questa sezione della documentazione si descrive il diagramma BPMN del progetto, in cui si mostra come i servizi ed ACMEsky interagiscono tra loro al fine di realizzare le funzionalità richieste dalla consegna. Per una migliore specificità e gestione della documentazione il diagramma verrà diviso in parti relative alle varie azioni degli attori, come ad esempio la registrazione dell'interesse utente, la ricerca offerte di volo, salvataggio di quelle last-minute, gestione delle offerte e pagamento, ecc.


## Registrazione dell'interesse dell'utente
![register_user_interest](RegisterUserInterest.png)

Il seguente diagramma descrive il processo di raccolta e registrazione dei voli di interesse degli utenti. Un utente si registra sulla piattaforma ACMEskyWeb e descrive i suoi voli di interesse, specificando città/aereoporto di partenza, città/aereoporto di arrivo, data di partenza e ritorno del volo, e quota massima di spesa. Infatti le offerte di volo sono sempre formate dal volo di andata ed dal volo di ritorno.
ACMEsky salva i voli di interesse nel suo Database, in particolare nella tabella "flights_interest" vengono salvati i voli che formano l'offerta di interesse e in "users_interests" l'offerta vera e propria. Infine invia la conferma di avvenuta creazione dei voli di interesse.



## Registrazione delle offerte last-minute
![registrazione_voli_last-minute](SaveLast-minute.png)

In questa parte si descrive il processo di ricezione e salvataggio dei voli last-minute. I servizi di Airline Service mandano voli last-minute appena creati ad ACMEsky, la quale salva ciascuno di essi nel suo Database, nello specifico nella tabella available_flights.



## Rimozione dei voli scaduti
![removing_expired_flights](RemovingExpiredFlights.png)

Il processo di cancellazione dei voli scaduti presenti nel Database avviene ogni 12 ore. I voli scaduti sono quei voli che hanno la data di scadenza è antecedente a quella in cui si effettua l'operazione di cancellazione. La cancellazione non comporta l'eliminazione effettiva del record che rappresenta quel volo, bensì un cambiamento di stato che porta ACMEsky a non considerare più quel volo come disponibile.



## Rimozione delle offerte scadute
![removing_expired_offers](RemovingExpiredOffers.png)

Il processo di cancellazione delle offerte di volo scadute presenti nel Database avviene ogni 12 ore. Le offerte di volo scadute comprendono i due voli di partenza e ritorno che corrispondono ai voli di andata e ritorno di interesse degli utenti. Le offerte scadute sono quelle la cui data di scadenza del volo di partenza è antecedente a quella in cui si effettua l'operazione di cancellazione. La cancellazione non comporta l'eliminazione effettiva del record che rappresenta quell'offerta, bensì un cambiamento di stato che porta ACMEsky a non considerare più i voli dell'offerta, e l'offerta in sè, come disponibili.



## Registrazione voli

![search_flights](SearchFlights.png)

Ogni 12 ore e per ciascun Airline Service, ACMEsky recupera i voli di interesse degli utenti dal suo Database ed effettua una ricerca mirata dei voli compatibili con essi attraverso una chiamata ad una risorsa dei servizi di volo. I voli presenti nella risposta vengono salvati all'interno del DB. Se passa una certa quantità di tempo dovuto a ritardi o mancate risposte da parte dei Airline Service, per evitare che il flusso di esecuzione del sistema si fermi e non vada più avanti si è deciso di farlo terminare.



## Match voli con interesse utente
![matching tra voli e voli di interesse](Flights-InterestMatching.png)

Ogni ora e per ciascun volo di interesse ACMEsky cerca tra i voli disponibili presenti nel DB se c'è una corrispondenza con il volo di interesse in esame. In caso negativo semplicemente il flusso termina, altrimenti si procede alla preparazione ed al salvataggio in DB dell'offerta comprensiva di tutti i voli che l'utente cercava. Infine l'offerta di volo viene inviata all'utente attraverso l'app di Prontogram e il flusso termina.


## Conferma di acquisto, applicazione servizi premium e preparazione biglietti
![user_purchase_offer](UserPurchaseOffer.png)

In questa parte del diagramma si illustra la conferma di acquisto dell'offerta di volo da parte dell'utente, l'acquisto dell'offerta e l'applicazione di servizi premium se l'offerta rispetta le caratteristiche del servizio premium. Infine vi è il controllo per verificare che non ci siano errori e si prepara il biglietto che poi il cliente avrà disponibile. Queste feature verranno suddivise in sotto parti del diagramma in modo da facilitarne l'esposizione.


### Conferma dell'offerta da parte dell'utente
![confirm_user_offer](ConfirmOffer.png)

L'App di Prontogram notifica l'utente del fatto che c'è un'offerta i cui voli di partenza e ritorno corrispondono ai voli di interesse da lui richiesti e termina il suo flusso. L'utente riceve l'offerta e può decidere se confermarla o meno attraverso l'invio di un token legato all'offerta stessa. ACMEsky recupera l'offerta corrispondente al token e si occupa di verificarne la validità, ovvero di controllare che il tempo di accettazione dell'offerta non sia terminato. In caso positivo si verifica se l'offerta di volo non è ancora scaduta e se anche in questo caso l'esito è positivo si invia all'utente la conferma di accettazione dell'offerta, altrimenti lo si informa dell'esito negativo dovuto alla scadenza dell'offerta o del token ed il flusso termina con un errore.


## Pagamento dei voli
![book_payment](BookPayment.png)

 Il processo di pagamento inizia con una richiesta di pagamento del biglietto relativo all'offerta accettata. ACMEsky a questo punto si prende l'onere di prenotare i biglietti facendone richiesta all'Airline Service che offre i voli dell'offerta, la quale invierà in risposta i biglietti. Se c'è un errore relativo all'impossibilità di prenotare l'offerta poichè al servizio di Airline risulta che l'offerta sia già stata acquistata o per qualsiasi altro problema, si invia un messaggio di errore all'utente ed il flusso termina. Se invece la prenotazione va a buon fine e ACMEsky dispone dei biglietti chiederà il link di pagamento a Bank Service, la quale glielo invierà in risposta appena possibile, ovvero la cancellazione della prenotazione. Il link viene sottoposto all'utente a meno di eventuali problemi che se presenti porterebbero alla compensazione dei biglietti precedentemente prenotati. L'utente sceglierà se pagare o meno. Se è intenzionato a pagare effettua il pagamento e riceverà risposta da Bank Service per comunicargli l'esito del pagamento. Bank Service comunica l'esito anche ad ACMEsky la quale potrà decidere in base ad esso di chiudere il flusso di pagamento oppure occuparsi delle compensazioni. Se il pagamento è avvenuto con successo il flusso termina, se il pagamento non è avvenuto con successo si effettua la compensazione del biglietto. Se il servizio della banca non risponde entro 5 minuti dal pagamento si procede alla compensazione dei biglietti, alla compensazione del pagamento, ovvero all'emissione di un coupon spendibile dall'utente per acquistare nuove offerte di volo. In tal caso il flusso termina con un errore. Un errore nel pagamento comporta il termine del flusso dell'utente.


## Servizi Premium voli
![premium_service](PremiumService.png)

In questa fase ci si occupa di un eventuale applicazione del servizio premium all'offerta di volo dell'utente. All'inizio ACMEsky controlla il prezzo dell'offerta del cliente, poichè se questo supera i mille euro si invia una richiesta al servizio di geolocalizzazione per conoscere la posizione dell'utente. In seguito alla risposta del servizio, ACMEsky sarà in grado di calcolare la distanza tra il domicilio dell'utente e l'aereoporto di partenza. Nel caso in cui la distanza sia superiore ai 30 km si richiede al Rent Service più vicino se c'è la possibilità di offrire all'utente un trasferimento gratuito dal suo domicilio all'aereoporto sia all'andata che al ritorno, e in tal caso modificherà i biglietti includendo tutte le informazioni necessarie dei due trasferimenti. Chiaramente in caso la distanza sia inferiore il servizio di trasferimento gratuito non è disponibile. In caso il prezzo dell'offerta sia inferiore alla soglia chiaramente non verrà offerto nessun servizio premium. Infine il flusso termina.


## Invio Biglietti
![prepare_tickets](PrepareTickets.png)

Nel caso in cui ci siano stati errori in precedenza legati al mancato acquisto e/o pagamento dei biglietti piuttosto che all'applicazione dei servizi premium, il flusso termina. In caso di mancanza di errori si cambierà lo stato dell'offerta riguardante l'acquisto e si prepareranno i biglietti che l'utente potrà scaricare. Il flusso termina sia per ACMEsky, che per l'utente.