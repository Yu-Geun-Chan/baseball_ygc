package com.baseball.crawlGameSchedule;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.Select;
import org.springframework.stereotype.Component;

import com.baseball.vo.GameSchedule;

import java.util.ArrayList;
import java.util.List;

@Component
public class GameScheduleCrawl {

	private static final String URL = "https://www.koreabaseball.com/Schedule/Schedule.aspx";

	// 크롤링 메서드
	public List<GameSchedule> crawl(String month) {
		// ChromeDriver 경로 설정 (경로를 본인의 환경에 맞게 수정해야 함)
		System.setProperty("webdriver.chrome.driver",
				"C:/work_YGC/sts-4.24.0.RELEASE-workspace/baseball_ygc/chromedriver.exe");

		// ChromeOptions 객체 생성 및 설정
		ChromeOptions options = new ChromeOptions();

		// WebDriver 객체 생성
		WebDriver driver = new ChromeDriver(options);

		// 지정한 URL로 이동
		driver.get(URL);

		// 월 선택 드롭다운에서 선택
		Select select = new Select(driver.findElement(By.id("ddlMonth")));
		select.selectByValue(month);

		// 경기 일정 테이블 찾기
		WebElement tbody = driver.findElement(By.cssSelector("#tblScheduleList tbody"));
		List<WebElement> rows = tbody.findElements(By.tagName("tr"));

		// 데이터가 없는 경우 처리
		if (rows.size() <= 1) {
			driver.quit();
			return null;
		}

		List<GameSchedule> scheduleList = new ArrayList<>(); // 데이터를 저장할 리스트
		String lastGameDay = ""; // 마지막 날짜 저장

		for (WebElement row : rows) {
			List<WebElement> cells = row.findElements(By.tagName("td"));

			// 셀의 개수가 9개인 경우에만 처리
			if (cells.size() == 9) {
				// 날짜가 있는 경우
				if (cells.get(0).getAttribute("class").contains("day")) {
					lastGameDay = cells.get(0).getText(); // 날짜 저장
				}

				String time = cells.get(1).getText(); // 시간
				String game = cells.get(2).getText(); // 팀 정보
				String location = cells.get(7).getText(); // 장소
				String etc = cells.get(8).getText(); // 비고

				// GameSchedule VO 생성
				GameSchedule schedule = new GameSchedule(lastGameDay, time, game, location, etc);
				scheduleList.add(schedule);
			}
			// 셀의 개수가 8개인 경우에만 처리(날짜가 없는 경우)
			if (cells.size() == 8) {
				String time = cells.get(0).getText(); // 시간
				String game = cells.get(1).getText(); // 팀 정보
				String location = cells.get(6).getText(); // 장소
				String etc = cells.get(7).getText(); // 비고

				// GameSchedule VO 생성
				GameSchedule schedule = new GameSchedule(lastGameDay, time, game, location, etc);
				scheduleList.add(schedule);
			}
		}

		driver.quit(); // 브라우저 종료
		return scheduleList; // 성공적으로 완료
	}
}
