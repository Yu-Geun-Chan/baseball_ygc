package com.baseball.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baseball.crawlGameSchedule.GameScheduleCrawl;
import com.baseball.vo.GameSchedule;

@Controller
public class UsrScheduleController {

	@Autowired
    private GameScheduleCrawl gameScheduleCrawl;
    
    @GetMapping("/usr/game/schedule")
    public String showSchedulePage(Model model) {
        return "usr/game/schedule"; // JSP 파일의 경로
    }

    @GetMapping("/getSchedule")
    @ResponseBody
    public List<GameSchedule> getSchedule(@RequestParam String month) {
        return gameScheduleCrawl.crawl(month); // 크롤링된 일정 반환
    }
	
}
