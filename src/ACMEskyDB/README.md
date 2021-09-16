
# ACMEsky Database

ACMEsky si interfaccia ad un database PostgreSQL.
Il file docker-compose, attraverso il file init.sql, contiene tuto il necessario per eseguire un'istanza del database con le tabelle e i record necessari ad ACMEsky.

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

La tabella ***airports*** contiene i record che rappresentano gli aereoporti nazionali e internazionali codificati secondo il codice IATA. Essa contiene il campo ***id*** (chiave primaria), ***code***  (codice dell'aereoporto in codifica IATA), ***name*** (nome dell'aereoporto), ***city_name*** (nome della città), ***country_code*** (codice del paese), ***timezone***(fuso orario), ***latitude*** e ***longitude*** (la posizione dell'aereoporto).

|  | domain_entities |
| - | - |
| PK | id |
|  | username |
|  | password |
|  | salt |
|  | role |

La tabella ***domain_entities*** contiene i record che descrivono le entità del dominio, ossia gli attori che interagiscono con ACMEsky al fine di raggiungere i propri scopi. Così è possibile riconoscere il ruolo di ciascun servizio/utente in base alle proprie credenziali, evitando relazioni con parti sconosciute. Ogni tupla contiene il valore corrispondente al campo ***id*** (chiave primaria), ai campi ***username*** e ***password*** (le credenziali), ***salt*** (dato random addizionato all'input della funzione one-way), e  ***role*** (il ruolo dell'entità nella SOA).

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

La relazione ***flights_interest*** descrive un volo di interesse, ossia un volo che un utente richiede attraverso il servizio di ACMEskyWeb per acquistarlo. La relazione ha un campo ***id*** (chiave primaria), ***user_id*** (chiave esterna della tabella ***users***), ***departure_airport_id*** e ***arrival_airport_id*** (indicano l'identificatore dell'aereoporto di partenza e arrivo), ***departure_date_time*** (data di partenza) e ***used*** (indica se ACMEsky ha già proposto all'utente il volo in un'offerta).  

|  | users_interests |
| - | - |
| PK | id |
| FK | user_id |
| FK | outbound_flight_interest_id |
| FK | flight_back_interest_id |
|  | price_limit |  
|  | expire_date |
|  | used |

La tabella ***users_interest*** descrive le i voli di interesse degli utenti A/R. Comprende i campi: ***id*** (chiave primaria), ***user_id*** (chiave esterna dell'utente nella tabella ***users***), ***outbound_flight_interest_id*** (chiave esterna del volo di interesse di andata in ***flights_interest***),***flight_back_interest_id*** (chave esterna del volo di interesse di ritorno in ***flights_interest***), ***price_limit*** (limite di prezzo che l'offerta non può superare), ***expire_date*** (data di scadenza entro cui l'offerta è prenotabile) e ***used*** (valore booleano che segnala se l'interesse è stata già gestita da ACMEsky). 

|  | airlines |
| - | - |
| PK | id |
| FK | entity_id |
|   | ws_address |

La tabella ***airlines*** fa riferimento ai servizi delle compagnie aeree (AirlineService). Comprende i seguenti campi: ***id*** (chiave primaria), ***entity_id*** (chaive esterna dell'entità in ***domain_entities***) e  ***ws_address*** (l'indirizzo del server del servizio a cui si possono fare richieste).

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

La tabella ***flights*** descrive i voli che vengono recuperati interrogando la compagnia aerea sulla base dei voli di interesse degli utenti. Sono presenti i seguenti campi: ***id*** (chiave primaria), ***departure_airport_id*** (chiave esterna dell'aereoporto di partenza nella tabella ***airports***), ***arrival_airport_id*** (chiave esterna dell'aereoporto di arrivo nella tabella ***airports***), ***airline_id*** (chiave esterna della compagnia aerea nella tabella ***airlines***), ***flight_code*** (codice con il quale il volo viene registrato dalla compagnia), ***departure_date_time*** (data e ora di partenza del volo), ***arrival_date_time*** (data e ora di arrivo), ***price*** (prezzo del volo), ***expire_date*** (data di scadenza del volo, ossia quando non è più prenotabile), ***booked*** (indica se il volo è stato prenotato) e ***available*** (stabilisce se il volo è già stato inserito in un offerta, quindi non più inutilizzabile).  

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

La tabella ***generated_offers*** rappresenta le offerte di volo generabili da ACMEsky sulla base degli interessi degli utenti. E' composta dai seguenti campi: ***id*** (chiave primaria), ***user_id*** (chiave esterna dell'utente nella tabella ***users***), ***outbound_flight_id*** (chiave esterna del volo di andata nella tabella ***flights***), ***flight_backt_id*** (chiave esterna del volo di ritorno nella tabella ***flights***), ***total_price*** (prezzo dell'offerta A/R), ***expire_date*** (data di scadenza dell'offerta, ossia quando non è più prenotabile), ***booked*** (indica se l'offerta è stata prenotata o meno), ***token*** (codice dell'offerta).

|  | banks |
| - | - |
| PK | id |
| FK | entity_id |
|  | ws_address |

La tabella ***banks*** fa riferimento ai servizi bancari. E' composta dai seguenti campi: ***id*** (chiave primaria), ***entity_id*** (chiave esterna dell'entità della banca nella tabella ***domain_entities***) e ***ws_address*** (indirizzo del server del servizio).

|  | rent_services |
| - | - |
| PK | id |
| FK | entity_id |
|  | address |
|  | ws_address |

La tabella ***rent_services*** fa riferimento ai servizi di noleggio per accompagnare l'utente all'aereoporto. E' composta dai seguenti campi: ***id*** (chiave primaria), ***entity_id*** (chiave esterna riferita alla entità nella tabella ***domain_entities***) e  ***ws_address*** (indirizzo del server del servizio).

&nbsp;
<div class="page-break"></div>
