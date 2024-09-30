package com.baseball.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baseball.vo.GameRank;
import com.baseball.crawlGameRank.GameRankCrawl;

import java.util.List;

@Controller
public class UsrGameRankController {

	@Autowired
	private GameRankCrawl GameRankCrawl;

	@GetMapping("/usr/game/rank")
	public String showGameRanks(Model model) {
		 return "usr/game/rank"; // JSP 파일의 경로
	}
	
    @GetMapping("/getRank")
    @ResponseBody
    public List<GameRank> getGameRank() {
        return GameRankCrawl.crawl(); // 크롤링된 일정 반환
    }
}
