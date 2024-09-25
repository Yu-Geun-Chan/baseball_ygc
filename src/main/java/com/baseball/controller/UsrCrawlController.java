package com.baseball.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.baseball.crawlGameSchedule.GameSchedule;
import com.baseball.crawlPlayer.Doosan;
import com.baseball.crawlPlayer.Hanwha;
import com.baseball.crawlPlayer.Kia;
import com.baseball.crawlPlayer.Kiwoom;
import com.baseball.crawlPlayer.Kt;
import com.baseball.crawlPlayer.Lg;
import com.baseball.crawlPlayer.Lotte;
import com.baseball.crawlPlayer.Nc;
import com.baseball.crawlPlayer.Samsung;
import com.baseball.crawlPlayer.Ssg;

@Controller
public class UsrCrawlController {

	// 구단별 선수 정보
	@Autowired
	private Samsung samsung;
	@Autowired
	private Doosan doosan;
	@Autowired
	private Kia kia;
	@Autowired
	private Hanwha hanwha;
	@Autowired
	private Kiwoom kiwoom;
	@Autowired
	private Kt kt;
	@Autowired
	private Lg lg;
	@Autowired
	private Lotte lotte;
	@Autowired
	private Nc nc;
	@Autowired
	private Ssg ssg;
	
	// 경기 일정
	@Autowired
	private GameSchedule gameSchedule;

	@RequestMapping("/usr/crawlPlayer")
	public String doCrawlPlayer() {

		kia.crawl();
		samsung.crawl();
		lg.crawl();
		kt.crawl();
		doosan.crawl();
		ssg.crawl();
		lotte.crawl();
		hanwha.crawl();
		nc.crawl();
		kiwoom.crawl();

		return "/usr/home/main";

	}
	
	// 크롤링 할때 localhost:8083/usr/crawlGameSchedule?month='01~12' 해당 월을 넣어서 url에 직접 입력해야 크롤링됨..
	@GetMapping("/usr/crawlGameSchedule")
	public ResponseEntity<String> doCrawlGameSchedule(@RequestParam String month) {
	    if (month.matches("^(0[1-9]|1[0-2])$")) {
	        String result = gameSchedule.crawl(month);
	        return ResponseEntity.ok(result); // 200
	    } else {
	        return ResponseEntity.badRequest().body("유효하지 않은 월입니다. (01~12 사이의 값)"); // 400
	    }
	}
} 
