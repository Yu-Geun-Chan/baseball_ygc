package com.baseball.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baseball.util.crawlTest;

@Controller
public class UsrHomeController {

	@RequestMapping("/usr/home/main")
	public String showMain() {
		// prefix와 suffix를 설정해놨기 때문에 /WEB-INF/jsp/home/main.jsp 를 /usr/home/main으로 입력해도
		// 된다.
		return "/usr/home/main";
	}

	@RequestMapping("/")
	public String showRoot() {

		return "redirect:/usr/home/main";
	}

	@RequestMapping("/usr/crawl")
	public String doCrawl() {

		crawlTest.crawl();

		return "redirect:/usr/home/main";

	}
}
