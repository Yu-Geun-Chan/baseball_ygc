package com.baseball.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UsrTeamInfoController {

	@RequestMapping("/usr/home/teamInfo")
	public String showteamInfo() {
		return "/usr/home/teamInfo";
	}

}
