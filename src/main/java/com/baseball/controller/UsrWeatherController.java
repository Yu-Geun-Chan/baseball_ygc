package com.baseball.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrWeatherController {

	@RequestMapping("/usr/home/weather")
	public String showWeather() {
	
		
		return "/usr/home/weather";
	}

}
