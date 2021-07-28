# ACMEsky

Progetto Ingegneria del Software Orientata ai Servizi
A.A. 2020/2021
Descrizione del dominio e del problema
ACMESky offre un servizio di che permette ai clienti di specificare, attraverso un portale web, il proprio interesse a trasferimenti aerei di andata e ritorno che si tengano in un periodo definito e ad un costo inferiore ad un certo limite impostato.

ACMESky quotidianamente interroga le compagnie aeree per ottenere le quotazioni dei voli di interesse per i propri clienti.

ACMESky riceve anche offerte last-minute dalle compagnie che le inviano al momento dell’attivazione senza cadenza prefissata.

Quando ACMESky trova un volo compatibile con una richieste di un cliente prepara un’offerta.

L’offerta viene inviata al cliente tramite l’APP di messaggistica Prontogram. Il cliente, se interessato, ha quindi 24 ore di tempo per connettersi al portale web di ACMESky per confermare l’offerta, specificandone il codice ricevuto via Prontogram.

In fase di conferma il cliente deve anche procedere al pagamento, per la gestione del quale ACMESky si appoggia ad un fornitore di servizi bancari: ACMESky reindirizza il cliente verso il sito del fornitore e quindi attende dal fornitore il messaggio che conferma l’avvenuto pagamento.

Nel caso in cui il costo del volo risulti essere superiore ai 1000 euro ACMESky offre al cliente un servizio gratuito di trasferimento da/verso l'aeroporto se questo si trova entro i 30 chilometri dal suo domicilio.

In questo caso ACMESky fa uso di diverse compagnie di noleggio con autista con cui ha degli accordi commerciali. La compagnia scelta è quelle che risulta avere una sede più vicina al domicilio del cliente. A tale compagnia ACMESky invia una richiesta per prenotare un trasferimento che parta due ore prima dell’orario previsto per il decollo del volo.


Si progetti e si realizzi una SOA che supporti le attività di ACMESky.

Workflow e artefatti
Si modellino le comunicazioni dello scenario sopra esposto usando una coreografia, si discutano le sue proprietà di connectedness ed eventualmente si raffini la coreografia per migliorare tali proprietà. Si proietti la coreografia in un sistema di ruoli.


Utilizzando uno o più diagrammi di collaborazione BPMN si modelli l’intera realtà descritta compresi i dettagli di ogni partecipante riferibile ad ACMESky. Tale modellazione ha scopo documentativo quindi il livello di dettaglio deve essere consistente con tale scopo. I partecipanti “esterni” (compagnie aeree, sistema bancario, ecc…) possono apparire come collapsed pools.


Si progetti una SOA per la realizzazione del sistema e la si documenti utilizzando UML (eventualmente con opportuni profili, ad esempio TinySOA).

Le interfacce esposte dei servizi descritti nella modellazione (dove possono apparire in forma semplificata) dovranno poi essere effettivamente realizzate nell’implementazione.


Si realizzi il sistema usando come tecnologie un BPMS (si consiglia di utilizzare Camunda), Jolie e API Rest.

Il BPMS deve essere utilizzato per supportare i processi di ACMESky.

Si assume che il sistema integri sotto forma di servizi (almeno) le seguenti capability esterne:

Calcolo distanze geografiche (preferibilmente con API Rest)
Sistema bancario
Compagnie di noleggio con autista (Jolie)
Compagnie aeree
Prontogram (preferibilmente API Rest)
Tali servizi vanno implementati (con logica elementare) come parte del progetto.


I modelli di processo BPMN da utilizzare per il BPMS devono essere consistenti con la modellazione a scopo documentativo precedentemente realizzata; volendo si può anche scegliere di dettagliare compiutamente già dal primo modello le pool eseguibili.

Il dialogo fra Jolie e BPMS deve avvenire via SOAP, si veda il sito del corso alla pagina delle risorse per informazioni ulteriori.

Consegna e discussione
Gruppi: il progetto va realizzato in gruppi di 2/3 persone.


Tempi: Il progetto va consegnato prima che inizino le lezioni dell’A.A. 2021-22.

Materiale da consegnare: relazione che descrive il lavoro fatto nelle varie fasi di modellazione e sviluppo, inclusi i vari diagrammi prodotti: coreografia e sistema proiettato, diagramma/i UML, diagramma/i di processo BPMN, export del progetto del BPMS, sorgenti dei servizi Jolie ed eventuali sorgenti aggiuntivi.

Modalità  di consegna: via email con allegati. Se la dimensione degli allegati fosse eccessiva si consiglia di utilizzare servizi quali wetransfer, dropbox o similari.

Discussione del progetto: la discussione avviene su richiesta. Alla discussione devono presenziare tutti i membri del gruppo. La valutazione è personale, il che vuol dire che i partecipanti di uno stesso gruppo possono ottenere voti differenti fra loro. Queste specifiche non possono considerarsi definitive e verranno corrette e/o integrate quando necessario.

Opzioni
Fermo restando che la corretta realizzazione del progetto proposto senza la parte opzionale permette di ottenere comunque il massimo punteggio, viene proposta una consegna aggiuntiva da considerarsi opzionale:

Modellazione della coreografia anche attraverso un diagramma di coreografia BPMN.
Revisioni
Queste specifiche possono essere soggette a revisioni per chiarire eventuali ambiguità e integrare possibili mancanze.


V0.9 - versione interna RFC


| Service | Port |
| - | - |
| ACMEsky | - |
| web | 80 |
| api | 8080 |
| Postgres | 5050 |
| BankService | 8070 |
| AirlineNationalService | 8060 |
| AirlineService | 8061 |
| ProntogramService | 8050 |
| ProntogramFrontEnd | 8051 |
| GeocraphicalService | 8040 |
| RentService1 | 8030 |
| RentService2 | 8032 |
| RentService3 | 8034 |

Vincoli al problema (Assunzioni):
- Le offerte generate provengono dalla stessa compagnia aerea
- I dati del viaggiatore vengono presi dall'account
- Non viene gestito lo scambio di denaro dalla banca alla compagnia aerea 


TODO
Cancellazione logica del volo 
Rigenerare db
Modificare CascadeType in model
