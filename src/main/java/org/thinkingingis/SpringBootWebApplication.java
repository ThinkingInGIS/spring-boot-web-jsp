package org.thinkingingis;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;

@SpringBootApplication(scanBasePackages={"org.thinkingingis"})
public class SpringBootWebApplication extends SpringBootServletInitializer{
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application){
		
		return application.sources(SpringBootWebApplication.class);
	}
	
	public static void main(String[] args){
		SpringApplication.run(SpringBootWebApplication.class, args);
	}

}
