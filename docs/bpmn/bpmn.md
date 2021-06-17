# Documentazione bpmn

```txt
In questa sezione della documentazione si descrive il diagramma BPMN, in cui si rappresentano le coreografie già costruite e descritte in precedenza. Per una migliore specificità e gestione della documentazione il diagramma verrà diviso in parti relative ad una determinata funzionalità del progetto (es. registrazione interesse utente, ricezione offerte last-minute, ecc.) e per ciascuna parte si parlerà di come è stata pensata prima dell'implementazione nella versione pre-implementazione, e poi dei cambiamenti che l'hanno trasformata nella versione post-implementazione. 
```

## Registrazione interesse utente


![registrazione_interesse_utente](registrazioneInteresseUtente.png)

```txt
Il seguente diagramma descrive il processo di raccolta e registrazione dei voli di interesse degli utenti. Un utente si registra sulla piattaforma ACMEsky e descrive il suo interesse specificando città/aereoporto di partenza, città/aereoporto di arrivo, data e ora di partenza e arrivo del volo, eventualmente specificando anche le informazioni del volo di ritorno. ACMEsky salva volo/i di interesse nel suo Database come specificato dal simbolo di DB descritto come Flights of users interest.
```


## Registrazione offerte last-minute


![registrazione_voli_last-minute](ricezioneLast-minute.png)

```txt
Il seguente diagramma descrive il processo di ricezione e salvataggio di voli last-minute. Le due istanze di servizi di AirlineService creano offerte di voli ogni 6 secondi e se queste sono offerte last-minute ne invia i rispettivi voli.
```


## Registrazione voli


![registrazione_voli](ricezioneVoli.png)

```txt
Il seguente diagramma descrive il processo di ricezione e salvataggio di voli last-minute. Le due istanze di servizi di AirlineService creano offerte di voli ogni 6 secondi e se queste sono offerte last-minute ne invia i rispettivi voli.
```


## Match voli con interesse utente


![registrazione_voli](Flights-InterestMatching.png)

```txt
Ogni ora e per ciascun volo di interesse ACMEsky cerca tra i voli disponibili che sono stati proposti dalle Airline Company se c'è un matching con il volo di interesse in esame. In caso negativo semplicemente il flusso termina, altrimenti si procede alla preparazione dell'offerta eseguendo il sub-process "Prepare offer". Viene inviata l'offerta all'utente attraverso l'app di Prontogram e questo flusso termina.
```

## Invio offerta all'utente


![registrazione_voli](ConfermaVoloDaUtente.png)

```txt
L'App di Prontogram notifica l'utente del fatto che c'è un volo che corrisponde al volo di interesse che aveva richiesto e termina il suo flusso. L'utente riceve l'offerta e può decidere se confermare l'offerta o meno attraverso l'invio di un token entro una certa scadenza, che in questo caso è di 24 ore. Nel caso positivo il token viene inviato ad ACMEsky che recupererà il volo corrispondente al token e in seguito genererà l'offerta.
```

## Prenotazione voli


![prenotazioni_voli](ConfermaPrenotazioneUtente.png)

```txt
ACMEsky controlla che il token sia stato inviato entro la scadenza. Nel caso negativo verrà inviato un errore all'utente e il flusso dell'utente termina, mentre quello di ACMEsky termina con un errore. Nel caso positivo viene inviato un messaggio di successo e il flusso dell'utente prosegue mentre quello del subprocess del controllo dell'offerta termina. Il flusso di ACMEsky continuerà poi verso il sotto processo del pagamento. Il processo di pagamento inizia con un sotto processo che, per ogni volo che compone l'offerta, informa la Airline Company che ha proposto quel volo della prenotazione dell'utente, poichè quest'ultima confermerà se il volo non è scaduto o già confermato da un altro utente. In caso negativo il flusso termina con un errore che il sotto processo manderà all'utente attraverso un messaggio d'errore. In caso positivo il flusso del sotto processo termina e viene inviato un messaggio di conferma della prenotazione.
```

## Pagamento voli


![pagamento_voli](pagamentoVoli.png)

```txt
In questo diagramma si descrive il pagamento dei voli che compongono l'offerta voli dell'utente. Una volta che i voli dell'offerta sono stati confermati 
```

## Servizi Premium voli


![serviziPremium_voli](ServiziPremiumVoli.png)

```txt

```

## Invio Biglietti


![invioBiglietti_voli](invioBiglietti.png)

```txt

```