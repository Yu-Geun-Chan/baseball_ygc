package com.baseball.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrAskController {

	@RequestMapping("/usr/home/ask")
	public String showWeather() {
	
		return "/usr/home/ask";
	}

}
