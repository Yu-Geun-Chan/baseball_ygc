package com.baseball.crawlGameSchedule;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Component;

import com.baseball.vo.GameSchedule;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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

		// 첫 번째 tr에서 날짜와 경기 정보를 가져오기
		WebElement firstRow = rows.get(0);
		List<WebElement> firstRowCells = firstRow.findElements(By.tagName("td"));

		if (firstRowCells.size() >= 6) {
			String gameDay = firstRow.findElement(By.className("day")).getText(); // 날짜
			String time = firstRowCells.get(1).getText(); // 시간
			String teams = firstRowCells.get(2).getText(); // 팀 정보
			String[] teamInfo = teams.split("vs"); // 팀 분리
			System.out.println(Arrays.toString(teamInfo));
			String team1 = teamInfo[0].trim(); // 팀 1
			String team2 = teamInfo[0].trim(); // 팀 2
			String location = firstRowCells.get(7).getText(); // 장소

			// 첫 번째 tr에서 정보를 가지고 GameSchedule VO 생성
			GameSchedule schedule = new GameSchedule(gameDay, time, team1, "vs", team2, location);
			scheduleList.add(schedule);
		}

		// 나머지 tr들에서 경기 정보 가져오기
		for (int i = 1; i < rows.size(); i++) {
			List<WebElement> cells = rows.get(i).findElements(By.tagName("td")); // 각 행의 셀 추출

			if (cells.size() >= 5) { // 필요한 셀 수 체크
				String time = cells.get(0).getText(); // 시간
				String teams = cells.get(1).getText(); // 팀 정보
				String[] teamInfo = teams.split("vs"); // 팀 분리
				String team1 = teamInfo[0].trim(); // 팀 1
				String team2 = teamInfo[0].trim(); // 팀 2
				String location = cells.get(6).getText(); // 장소

				// GameSchedule VO 생성 및 추가, 날짜는 첫 번째 tr의 날짜를 사용
				GameSchedule schedule = new GameSchedule(scheduleList.get(0).getGameDay(), time, team1, "vs", team2,
						location);
				scheduleList.add(schedule);
			}
		}

		driver.quit(); // 브라우저 종료
		return scheduleList; // 성공적으로 완료
	}

}
