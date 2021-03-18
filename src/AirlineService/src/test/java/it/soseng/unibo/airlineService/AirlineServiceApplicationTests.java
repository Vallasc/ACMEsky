package it.soseng.unibo.airlineService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import org.springframework.web.client.RestTemplate;


@SpringBootTest(classes = {RestTemplate.class})
class AirlineServiceApplicationTests {

    @Autowired
	RestTemplate template = new RestTemplate();


	// @Test
    // public void testAddEmployeeSuccess() throws URISyntaxException 
    // {
    //     final String baseUrl = "https://jsonplaceholder.typicode.com";
    //     URI uri = new URI(baseUrl);
		
		
    //     FlightOffer offer = new FlightOffer();
	// 	String dep = new String("2021-08-27T18:00:00");
	// 	String  dest= new String("2021-08-27T19:00:00");
	// 	offer.setDepartureTime(LocalDateTime.parse(dep));
	// 	offer.setDestinationTime(LocalDateTime.parse(dest));
    //     offer.setDeparture("Roma");
	// 	offer.setDestination("Palermo");
	// 	offer.setPrice("130");

    //     HttpHeaders headers = new HttpHeaders();
    //     // set `content-type` header
    //     headers.setContentType(MediaType.APPLICATION_JSON);
    //     // set `accept` header
    //     headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));      
 
    //     HttpEntity<FlightOffer> entity = new HttpEntity<>(offer, headers);         
    //     ResponseEntity<String> result = this.template.postForEntity(uri, entity, String.class);
         
    //     //Verify request succeed
    // }

}
