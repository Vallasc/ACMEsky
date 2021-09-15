
# Diagramma BPMN
In questa sezione della documentazione viene descritto il diagramma BPMN che rappresenta il comportamento dei processi
per ciò che concerne il flusso di controllo.

## Diagramma completo
![total](bpmn/img/Total.png)

 Per una migliore specificità e gestione della documentazione il diagramma verrà diviso in parti relative alle varie azioni degli attori, come ad esempio: la registrazione dell'interesse utente, la ricerca dei voli, salvataggio dei voli last-minute, gestione delle offerte, pagamento, ecc.

## Ricerca dei voli

![search_flights](bpmn/img/SearchFlights.png)

La ricerca dei voli alle Airline Services viene ripetuta ad un certo intervallo di tempo, per evitare sovraccaricare i sistemi. Per questo, i voli delle offerte di interesse degli utenti vengono salvati sul DB e, in seguito, vengono utilizzati per cercare i voli delle compagnie aeree. L'intervallo di tempo è variabile da 1 ora a pochi minuti poichè si cerca un compromesso tra un sistema efficiente e un sistema che non faccia aspettare troppo l'utente.

Quindi, ad un certo intervallo e per ciascun __Airline Service__, __ACMEsky__ recupera i voli di interesse degli utenti dal suo database ed effettua una ricerca mirata dei voli compatibili con essi. 
I voli presenti nella risposta vengono salvati all'interno del database (tabella _available_flights_). 
Se il timer della richiesta scade, per eventuali errori dovuti ad __Airline Service__, il sottoprocesso termina e si passa ad un'altra compagnia aerea.


## Registrazione delle offerte last-minute

![registrazione_voli_last-minute](bpmn/img/SaveLast-minute.png)

In questa parte si descrive il processo di ricezione e salvataggio dei voli last-minute. I servizi di __Airline Service__ mandano voli last-minute appena generati ad __ACMEsky__, la quale salva ciascuno di essi nel database, nello specifico nella tabella _available_flights_.


## Match voli con interesse utente

![matching tra voli e voli di interesse](bpmn/img/Flights-InterestMatching.png)

La generazione delle offerte di volo viene fatta ad un certo intervallo di tempo, ciò consente di non sovraccaricare il sistema e di evitare problemi di concorrenza con altri processi che generano le offerte. Per questo motivo, i voli delle offerte di interesse degli utenti vengono salvati sul database finchè non vengono processati per generare le offerte corrispondenti. L'intervallo di tempo è variabile da un'ora a pochi minuti poichè si cerca un compromesso tra un sistema efficiente e un sistema che non faccia aspettare l'utente.

Ogni ora, per ciascun offerta di interesse, __ACMEsky__ cerca tra i voli disponibili presenti nel database (tabella _available_flights_), se c'è una corrispondenza con i voli di interesse degli utenti (tabella _flights_interest_), allora prepara l'offerta, la salva nel database e la invia all'utente attraverso l'app di messaggistica __Prontogram__. In caso negativo semplicemente il sotto-processo termina passando all'interesse successivo.


## Registrazione dell'interesse dell'utente

![register_user_interest](bpmn/img/RegisterUserInterest.png)

Il seguente diagramma descrive il processo di raccolta e registrazione degli interessi degli utenti. L'utente descrive i suoi voli di interesse specificando: città/aereoporto di partenza, città/aereoporto di arrivo, data di partenza, data ritorno e quota massima di spesa.
__ACMEsky__ salva i voli di interesse nel suo database, in particolare, nella tabella _flights_interest_ e in _users_interests_, quest'ultima contiene i voli di interesse per uno specifico viaggio. 
Infine, __ACMEsky__ invia la conferma di avvenuta creazione.


## Conferma di acquisto, applicazione servizi premium e preparazione biglietti

![user_purchase_offer](bpmn/img/UserPurchaseOffer.png)

In questa parte del diagramma viene illustrata la conferma di acquisto dell'offerta da parte dell'utente, l'acquisto dell'offerta e l'applicazione dei servizi premium se l'offerta rispetta le caratteristiche necessarie. 
Infine, viene preparato il biglietto che poi l'utente potrà scaricare. 

Per una magiore comprensione il diagramma è stato diviso in blocchi più piccoli.

### Conferma dell'offerta da parte dell'utente

![confirm_user_offer](bpmn/img/ConfirmOffer.png)

L'app di __Prontogram__ notifica l'utente del fatto che c'è un'offerta disponibile.

L'utente riceve l'offerta e può decidere se confermarla o meno attraverso l'invio di un token legato all'offerta stessa. 

__ACMEsky__ recupera l'offerta corrispondente al token e si occupa di verificarne la validità, ovvero, di controllare che il tempo di accettazione dell'offerta non sia terminato. In caso positivo si verifica se l'offerta non sia scaduta e anche in questo caso se l'esito è positivo si invia all'utente la conferma di accettazione dell'offerta.
In caso contrario lo si informa dell'esito negativo dovuto alla scadenza dell'offerta o del token non valido ed il processo termina con un errore.

### Pagamento dell'offerta

![book_payment](bpmn/img/BookPayment.png)

Il sottoprocesso inizia con la richiesta, da parte dell'utente, di pagamento del biglietto relativo all'offerta accettata. __ACMEsky__ a questo punto si prende l'onere di prenotare i biglietti facendone richiesta all'__Airline Service__ che fornisce i voli dell'offerta. Se c'è un errore relativo all'impossibilità di prenotare l'offerta, poichè al servizio di airline risulta che l'offerta sia già stata acquistata o per qualsiasi altro problema, si invia un messaggio di errore all'utente ed il processo termina. 

Se la prenotazione va a buon fine, __ACMEsky__ chiederà il link di pagamento a __Bank Service__, la quale glielo invierà in risposta a meno di errori nel processo di pagamento. Successivamente, il link viene inoltrato all'utente che procederà al pagamento sulla piattaforma di __Bank Service__. Infine, __Bank Service__ comunica l'esito ad __ACMEsky__ che proseguirà nel sottoprocesso dei servizi premium.
Se il servizio della banca non risponde entro 5 minuti dalla generazione del link si procede, in via preventiva, alla compensazione dei biglietti e del pagamento. In questo caso il processo termina con errore.

### Servizi premium

![premium_service](bpmn/img/PremiumService.png)

In questa fase del processo di conferma, a condizioni rispettate, vengono applicati all'offerta i servizi premium. Inizialmente __ACMEsky__ controlla il prezzo dell'offerta, se questo supera i 1000€ invia una richiesta al servizio di __GeoDistance__ per calcolare la distanza dell'utente dall'areoporto. Nel caso in cui la distanza sia superiore ai 30 km si richiede al __Rent Service__ più vicino se c'è la possibilità di offrire all'utente un trasferimento dal suo domicilio all'aereoporto. Questa operazione viene ripetuta sia all'andata che al ritorno, e in tal caso verranno modificati i biglietti includendo le informazioni dei trasferimenti. Nel caso in cui distanza sia inferiore ai 30Km o il prezzo dell'offerta sia inferiore a 1000€ non verrà applicato nessun servizio.


## Preparazione dei biglietti

![prepare_tickets](bpmn/img/PrepareTickets.png)

Arrivati a questo punto viene cambiato lo stato dell'offerta e viene preparato il pdf contenente i biglietti che l'utente potrà scaricare. L'utente può in qualunque momento richiedere i biglietti che ha acquistato.


## Rimozione dei voli scaduti

![removing_expired_flights](bpmn/img/RemovingExpiredFlights.png)

Il processo di cancellazione dei voli scaduti presenti nel database avviene ogni 12 ore. I voli scaduti sono quei voli la cui data di scadenza è antecedente a quella in cui si effettua l'operazione di cancellazione. La cancellazione non comporta l'eliminazione effettiva del record che rappresenta quel volo, bensì un cambiamento di stato che porta ACMEsky a non considerare più quel volo come disponibile.


## Rimozione delle offerte scadute

![removing_expired_offers](bpmn/img/RemovingExpiredOffers.png)

Il processo di cancellazione delle offerte scadute presenti nel Database avviene ogni 12 ore. Le offerte di volo scadute comprendono i voli di andata e ritorno. Le offerte scadute sono quelle la cui data di scadenza del volo di partenza è antecedente a quella in cui si effettua l'operazione di cancellazione. La cancellazione non comporta l'eliminazione effettiva del record, bensì, un cambiamento di stato che porta ACMEsky a non considerare più i voli dell'offerta (e l'offerta in sè) come disponibili.


&nbsp;
<div class="page-break"></div>
