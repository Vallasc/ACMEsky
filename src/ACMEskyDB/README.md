
# ACMEsky Database

ACMEsky si interfaccia ad un database PostgreSQL.
Il file docker-compose contiene tuto il necessario per far partire un'istanza del database con le tabelle e i dati inizializzati.
Nello specifico, alla prima esecuzione, viene eseguito il file init.sql che contiene lo schema del database e i record iniziali per far partire ACMEsky da zero.

## Database schema

|  | airports |
| - | - |
| PK | id |
|  | code |
|  | name |
|  | city_name |
|  | country_code |
|  | timezone |
|  | latitude |
|  | longitude |

La tabella ***airports*** contiene i record che rappresentano gli aereoporti nazionali e internazionali codificati secondo il codice IATA. Essa contiene il campo ***id*** (Chiave primaria), ***code***, ossia il codice dell'aereoporto in codifica IATA, ***name***, il nome dell'aereoporto, ***city_name***, il nome della città dove si trova, ***country_code***, iniziali del paese dove si trova, ***timezone***, ossia il fuso orario, ***latitude*** e ***longitude*** che rappresentano la posizione dell'aereoporto.

|  | domain_entities |
| - | - |
| PK | id |
|  | username |
|  | password |
|  | salt |
|  | role |

La tabella ***domain_entities*** contiene i record che descrivono le entità del dominio, ossia gli attori che interagiscono con ACMEsky al fine di raggiungere i propri scopi. Così è possibile riconoscere il ruolo di ciascun servizio/utente in base alle proprie credenziali, evitando relazioni con parti sconosciute. Ogni tupla contiene il valore corrispondente al campo ***id*** (Chiave primaria), ai campi ***username*** e ***password*** (le credenziali), ***salt*** rappresenta un dato random addizionato all'input della funzione one-way (password) in modo da proteggere il DB da attacchi per violare password,
ed al campo ***role***, il ruolo dell'entità.

|  | users |
| - | - |
| PK | id |
| FK | entity_id |
|  | name |
|  | surname |
|  | email |
|  | prontogram_username |

La tabella ***users*** rappresenta gli utenti che interagiscono con il sistema. Il campo ***id*** è l'identificatore dell'utente nella tabella (Chiave primaria), ***entity_id*** è l'id con il quale è stato salvato l'utente sulla tabella ***domain_entities*** (Chiave esterna), ***name*** e ***surname*** sono il nome e cognome dell'utente, ***email*** è il campo contenente l'email con la quale l'utente si è registrato, mentre ***prontogram_username*** è il nome utente con il quale l'utente si è registrato sull'app di Prontogram. 

|  | flights_interest |
| - | - |
| PK | id |
| FK | user_id |
| FK | departure_airport_id |
| FK | arrival_airport_id |
|  | departure_date_time |
|  | used |

La relazione ***flights_interest*** descrive un volo di interesse, ossia un volo che un utente richiede attraverso il servizio di ACMEskyWeb per acquistarlo. La relazione ha un campo ***id*** che rappresenta il codice identificativo con il quale viene salvato sul DB (Chiave primaria), ***user_id*** si riferisce al campo ***id*** della relazione ***users*** (Chiave esterna), ***departure_airport_id*** e ***arrival_airport_id*** indicano l'identificatore dell'aereoporto di partenza e arrivo, ***departure_date_time*** descrive la data di partenza senza specificare l'ora e il campo used assume valori booleani: se assume il valore ***true*** indica che ACMEsky ha già proposto all'utente il volo corrispondente all'interesse.  

|  | users_interests |
| - | - |
| PK | id |
| FK | user_id |
| FK | outbound_flight_interest_id |
| FK | flight_back_interest_id |
|  | price_limit |  
|  | expire_date |
|  | used |

La tabella ***users_interest*** descrive le offerte di volo di interesse degli utenti. Visto che gli utenti devono sempre prenotare un volo di interesse di andata e uno di ritorno entro un certo limite di prezzo, si è deciso di rappresentare questa scelta progettuale con il nome di offerta di volo. Il campo ***id*** è l'identificatore dell'offerta di interesse nella tabella (Chiave primaria), ***user_id*** è l'identificativo dell'utente nella tabella ***users*** (Chiave esterna), ***outbound_flight_interest_id*** è l'identificativo del volo di andata nella tabella ***flights_interest*** (Chiave esterna), ***flight_back_interest_id*** è l'identificativo del volo di ritorno nella tabella ***flights_interest*** (Chiave esterna), il campo ***price_limit*** si riferisce al limite di prezzo che l'offerta non può superare, ***expire_date*** sta per la data di scadenza entro cui l'offerta è prenotabile, mentre ***used*** rappresenta con valore booleano se l'offerta di interesse è stata già gestita da ACMEsky. 

|  | airlines |
| - | - |
| PK | id |
| FK | entity_id |
|   | ws_address |

La tabella ***airlines*** fa riferimento ai servizi delle compagnie aeree (AirlineService). Il campo ***id*** è l'identificativo della compagnia nella relazione (Chiave primaria), ***entity_id*** si riferisce all'identificativo della compagnia nella tabella ***domain_entities*** (Chiave esterna), e il campo ***ws_address*** rappresenta l'indirizzo del servizio con cui si possono fare richieste attraverso chiamate alle varie route messe a disposizione dal servizio stesso.

|  | flights |
| - | - |
| PK | id |
| FK | departure_airport_id |
| FK | arrival_airport_id |
| FK | airline_id |
|  | flight_code |
|  | departure_date_time |
|  | arrival_date_time |
|  | price |
|  | expire_date |
|  | booked |
|  | available |

La relazione ***flights*** descrive i voli che vengono recuperati interrogando la compagnia aerea sulla base dei voli di interesse degli utenti. Il campo ***id*** è l'identificativo del volo nella tabella (Chiave primaria), ***departure_airport_id*** è l'identificativo dell'aereoporto di partenza del volo con il quale è registrato nella tabella ***airports*** (chiave esterna), ***arrival_airport_id*** è l'identificativo dell'aereoporto del volo di ritorno con il quale è registrato nella tabella ***airports*** (chiave esterna), il campo ***airline_id*** è l'identificativo con il quale la compagnia aerea viene registrata nella tabella ***airlines***, ***flight_code*** è il codice con il quale il volo viene registrato dalla compagnia, ***departure_date_time*** sta per la data e l'orario di partenza del volo, ***arrival_date_time*** sta per la data e l'orario di arrivo, ***price*** è il prezzo, ***expire_date*** rappresenta la data di scadenza del volo, ossia quando non è più prenotabile, ***booked*** è il flag utilizzato per indicare se il volo è stato prenotato o meno, invece il flage del campo ***available*** stabilisce se il volo è già stato inserito in un offerta (è quindi inutilizzabile), oppure no (quindi disponibile).  

|  | generated_offers |
| - | - |
| PK | id |
| FK | user_id |
| FK | outbound_flight_id |
| FK | flight_back_id |
|  | expire_date |
|  | total_price |
|  | booked |
|  | token |

La relazione ***generated_offers*** rappresenta le offerte di volo generabili da ACMEsky sulla base delle offerte di volo di interesse degli utenti. Il campo ***id*** indica l'identificativo dell'offerta (chiave primaria), ***user_id*** è l'identificativo dell'utente nella tabella ***users*** (chiave esterna), ***outbound_flight_id*** è l'identificativo del volo di andata nella tabella ***flights*** (Chiave esterna), ***flight_back_interest_id*** è l'identificativo del volo di ritorno nella tabella ***flights*** (Chiave esterna), il campo ***total_price*** si riferisce al prezzo dell'offerta, il campo ***expire_date*** rappresenta la data di scadenza dell'offerta, ossia quando non è più prenotabile, ***booked*** è il flag utilizzato per indicare se l'offerta è stata prenotata o meno, ***token*** è il campo che si riferisce al token che l'utente utilizza per riscattare l'offerta.

|  | banks |
| - | - |
| PK | id |
| FK | entity_id |
|  | ws_address |

La relazione ***banks*** fa riferimento ai servizi bancari. Il campo ***id*** è l'identificativo della banca nella tabella (Chiave primaria), ***entity_id*** si riferisce all'identificativo della banca nella tabella ***domain_entities*** (Chiave esterna), e il campo ***ws_address*** rappresenta l'indirizzo del servizio con cui si possono fare richieste attraverso chiamate alle varie route messe a disposizione dal servizio stesso.

|  | rent_services |
| - | - |
| PK | id |
| FK | entity_id |
|  | address |
|  | ws_address |

La tabella ***rent_services*** fa riferimento ai servizi di noleggio per accompagnare l'utente, eventualmente, all'aereoporto. Il campo ***id*** è l'identificativo del servizio nella relazione (Chiave primaria), ***entity_id*** si riferisce all'identificativo del noleggio nella tabella ***domain_entities*** (Chiave esterna), e il campo ***ws_address*** rappresenta l'indirizzo del servizio con cui si possono fare richieste attraverso chiamate alle varie route messe a disposizione dal servizio stesso.

\
\
&nbsp;
