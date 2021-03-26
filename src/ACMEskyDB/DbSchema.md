
|  | airports |
| - | - |
| PK | airport_code |
|  | address |
|  | name |

|  | user_requests |
| - | - |
| PK | id |
| FK | user_id |
| FK | outbound_flight_interest_id |
| FK | flight_back_interest_id |
|  | expire_date |

|  | flights_interest |
| - | - |
| PK | id |
| FK | user_id |
| FK | departure_airport_code |
| FK | arrival_airport_code |
|  | departure_date_time |
|  | arrival_date_time |


|  | flights |
| - | - |
| PK | id |
| FK | departure_airport_code |
| FK | arrival_airport_code |
| FK | airline_id |
|  | departure_date_time |
|  | arrival_date_time |
|  | price |
|  | expire_date |
|  | booked |


|  | generated_offers |
| - | - |
| PK | id |
| FK | outbound_flight_id |
| FK | flight_back_id |
|  | expire_date |
|  | total_price |
|  | booked |
|  |  |

|  | users |
| - | - |
| PK | id |
|  | name |
|  | surname |
|  | email |
|  | password |
|  | prontogram_token |
|  | address |

|  | airlines |
| - | - |
| PK | id |
|  | username |
|  | password |
|  | ws_address |

|  | banks |
| - | - |
| PK | id |
|  | username |
|  | password |
|  | ws_address |

|  | rent_services |
| - | - |
| PK | id |
|  | username |
|  | password |
|  | address |
|  | ws_address |
