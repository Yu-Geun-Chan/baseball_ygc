package com.baseball.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Test {

	@RequestMapping("/usr/home/test")
	public String showTest() {
		return "/usr/home/test";
	}
}

