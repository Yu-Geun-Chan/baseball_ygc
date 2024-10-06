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
		System.setProperty("webdriver.chrome.driver",
				"C:/work_YGC/sts-4.24.0.RELEASE-workspace/baseball_ygc/chromedriver.exe");

		// 크롬 옵션 설정
		ChromeOptions options = new ChromeOptions();

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
			// tData라는 클래스명을 가진 테이블 중에서 처음으로 등장하는 테이블 선택
			WebElement firstTable = driver.findElement(By.cssSelector("table.tData:first-of-type"));
			List<WebElement> rows = firstTable.findElements(By.cssSelector("table.tData > tbody > tr"));
			for (WebElement row : rows) {
				String rank = row.findElement(By.cssSelector("td:first-child")).getText(); // 순위(ex : 1, 2, 3 ...)
				String teamName = row.findElement(By.cssSelector("td:nth-child(2)")).getText(); // 구단명
				String games = row.findElement(By.cssSelector("td:nth-child(3)")).getText(); // 총 진행한 게임 수
				String wins = row.findElement(By.cssSelector("td:nth-child(4)")).getText();	// 승리한 횟수
				String losses = row.findElement(By.cssSelector("td:nth-child(5)")).getText(); // 패배한 횟수
				String draws = row.findElement(By.cssSelector("td:nth-child(6)")).getText(); // 무승부한 횟수
				String winningPercentage = row.findElement(By.cssSelector("td:nth-child(7)")).getText(); // 승률
				String gamesBehind = row.findElement(By.cssSelector("td:nth-child(8)")).getText(); // 1위와의 게임차

				rankings.add(new GameRank(rank, teamName, games, wins, losses, draws, winningPercentage, gamesBehind));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			driver.quit();
		}

		return rankings;
	}

}
