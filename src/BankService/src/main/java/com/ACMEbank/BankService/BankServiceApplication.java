package com.ACMEbank.BankService;

import com.ACMEbank.BankService.security.JWTAuthorizationFilter;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Entry point dell'applicazione 
 * Giacomo Vallorani 
 * giacomo.vallorani4@studio.unibo.it
 */
@SpringBootApplication
@RestController
public class BankServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(BankServiceApplication.class, args);
	}

	@EnableWebSecurity
	@Configuration
	class WebSecurityConfig extends WebSecurityConfigurerAdapter {
		@Override
		protected void configure(HttpSecurity http) throws Exception {
			http.csrf().disable()
				.addFilterAfter(new JWTAuthorizationFilter(), UsernamePasswordAuthenticationFilter.class)
				.authorizeRequests()
				.antMatchers(HttpMethod.POST, "/users").permitAll()
				.antMatchers(HttpMethod.POST, "/auth").permitAll()
				.antMatchers(HttpMethod.GET, "/payments/*").permitAll()
				.antMatchers(HttpMethod.PUT, "/payments/*").permitAll()
				.antMatchers("/").permitAll()
				.antMatchers("/link/**").permitAll()
				.antMatchers("/h2/**").permitAll()
				.antMatchers("/v3/api-docs/**", "/swagger-ui.html", "/swagger-ui/**").permitAll()
				.anyRequest().authenticated();
			http.headers().frameOptions().disable();
		}
	}

	@Configuration
	public class WebAppConfig implements WebMvcConfigurer {
		@Override
		public void addViewControllers(ViewControllerRegistry registry) {
			registry.addViewController("/link").setViewName("forward:/link/index.html");
		}
	}

	@GetMapping("/")
	public String index() {
		return "Welcome ACMEbank";
	}
}