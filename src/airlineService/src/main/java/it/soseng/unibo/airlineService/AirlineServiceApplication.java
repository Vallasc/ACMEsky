package it.soseng.unibo.airlineService;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class AirlineServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(AirlineServiceApplication.class);
	}

}
