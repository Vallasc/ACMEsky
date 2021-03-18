package it.soseng.unibo.airlineService;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;


/**
 * La classe principale che avvia il servizio della compagnia aerea
 * @author Andrea Di Ubaldo
 * andrea.diubaldo@studio.unibo.it
 */
@SpringBootApplication
@EnableScheduling
public class AirlineServiceApplication {

	@Value("${server.file}") 
    public String FILE;
	public static void main(String[] args) { 

		SpringApplication.run(AirlineServiceApplication.class, args);
		// ApplicationContext context = new SpringApplication(AirlineServiceApplication.class).run(args);
		// AirlineServiceApplication app = context.getBean(AirlineServiceApplication.class);
		// app.start();
	}

	// private void start() {
	// 	System.out.println(connector.connect());
	// }

	

}
