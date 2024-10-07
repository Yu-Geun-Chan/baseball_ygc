package com.baseball.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baseball.crawlNews.NewsCrawl;
import com.baseball.vo.GameRank;
import com.baseball.vo.News;

@Controller
public class UsrNewsController {

	@Autowired
	private NewsCrawl newsCrawl;

	// 뉴스 페이지 요청 처리
	@GetMapping("usr/home/news")
	public String getNews(Model model) {
		return "usr/home/news"; // JSP 파일 경로
	}
    @GetMapping("/getNews")
    @ResponseBody
    public List<News> getNews(@RequestParam(required = false, defaultValue = "kbo") String teamId) {
        return newsCrawl.crawl(teamId); // 뉴스 크롤링
    }
}
