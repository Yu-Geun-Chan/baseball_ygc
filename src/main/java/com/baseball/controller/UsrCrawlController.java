package com.baseball.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

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

	@RequestMapping("/usr/crawlPlayer")
	public String doCrawl() {

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
}
