package com.baseball.controller;

import java.util.List;

import org.apache.hc.core5.annotation.Contract;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.baseball.crawlNews.NewsCrawl;
import com.baseball.vo.News;

@Controller
public class UsrNewsController {

	@Autowired
	private NewsCrawl newsCrawl; // NaverNewsService 주입

	// 뉴스 페이지 요청 처리
	@GetMapping("/news")
	public String getNews(Model model) {
		List<News> newsList = newsCrawl.crawl(); // 크롤링 메서드 호출
		model.addAttribute("newsList", newsList); // 모델에 뉴스 리스트 추가
		return "news"; // JSP 파일 이름 (news.jsp)
	}
}
