package com.baseball.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class Test {
	@RequestMapping("/usr/home/map")
	public String showMap() {
		// prefix와 suffix를 설정해놨기 때문에 /WEB-INF/jsp/home/main.jsp 를 /usr/home/main으로 입력해도
		// 된다.
		return "/usr/home/map";
	}
}
