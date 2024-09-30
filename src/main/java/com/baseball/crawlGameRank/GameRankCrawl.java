package com.baseball.crawlGameRank;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.stereotype.Component;

import com.baseball.vo.GameRank;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Component
public class GameRankCrawl {
	public List<GameRank> crawl() {
		List<GameRank> rankings = new ArrayList<>();

		// 크롬 드라이버 경로 설정
		System.setProperty("webdriver.chrome.driver", "C:/path/to/chromedriver.exe");

		// 크롬 옵션 설정 (headless 모드)
		ChromeOptions options = new ChromeOptions();
		options.addArguments("--headless");

		// 크롬 드라이버 생성
		WebDriver driver = new ChromeDriver(options);

		try {
			// 하루 전날 날짜 가져오기 (형식: yyyy.MM.dd)
			LocalDate yesterday = LocalDate.now().minusDays(1);
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
			String yesterdayFormatted = yesterday.format(formatter);

			// KBO 구단순위 페이지 접속
			driver.get("https://www.koreabaseball.com/Record/TeamRank/TeamRankDaily.aspx");

			// 페이지에 표시된 날짜가 하루 전날과 일치하는지 확인
			WebElement dateElement = driver
					.findElement(By.id("cphContents_cphContents_cphContents_lblSearchDateTitle"));
			String displayedDate = dateElement.getText();

			if (!displayedDate.equals(yesterdayFormatted)) {
				driver.navigate().refresh();
			}

			// 하루 전날 기준으로 구단 순위 데이터 크롤링
			List<WebElement> rows = driver.findElements(By.cssSelector("table.tData > tbody > tr"));
			for (WebElement row : rows) {
				String rank = row.findElement(By.cssSelector("td:first-child")).getText();
				String teamName = row.findElement(By.cssSelector("td:nth-child(2)")).getText();
				String games = row.findElement(By.cssSelector("td:nth-child(3)")).getText();
				String wins = row.findElement(By.cssSelector("td:nth-child(4)")).getText();
				String losses = row.findElement(By.cssSelector("td:nth-child(5)")).getText();
				String gamesBehind = row.findElement(By.cssSelector("td:nth-child(6)")).getText(); // 게임차 요소 추가

				rankings.add(new GameRank(rank, teamName, games, wins, losses, gamesBehind));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			driver.quit();
		}

		return rankings;
	}

}
