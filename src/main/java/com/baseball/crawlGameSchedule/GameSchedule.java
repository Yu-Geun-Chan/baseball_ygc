package com.baseball.crawlGameSchedule;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.Select;
import org.springframework.stereotype.Component;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Component
public class GameSchedule {

	private static final String URL = "https://www.koreabaseball.com/Schedule/Schedule.aspx";

	// 크롤링 메서드
	public String crawl(String month) {
		// ChromeDriver 경로 설정 (경로를 본인의 환경에 맞게 수정해야 함)
		System.setProperty("webdriver.chrome.driver",
				"C:/work_YGC/sts-4.24.0.RELEASE-workspace/baseball_ygc/chromedriver.exe");

		// ChromeOptions 객체 생성 및 설정
		ChromeOptions options = new ChromeOptions();
		options.addArguments("--headless"); // 브라우저를 헤드리스 모드로 실행 -> 백그라운드 모드
		options.addArguments("--no-sandbox"); // 샌드박스 모드 사용 안 함

		// WebDriver 객체 생성
		WebDriver driver = new ChromeDriver(options);
		// 지정한 URL로 이동
		driver.get(URL);

		// 월 선택 드롭다운에서 선택
		Select select = new Select(driver.findElement(By.id("ddlMonth")));
		select.selectByValue(month);

		// 경기 일정 테이블 찾기
		WebElement table = driver.findElement(By.className("tbl-type06"));
		List<WebElement> rows = table.findElements(By.tagName("tr")); // 테이블의 모든 행 추출
		if (rows.size() == 1) {
			driver.quit(); // 데이터가 없는 경우 브라우저 종료
			return "0"; // 데이터가 없는 경우
		}

		List<List<String>> data = new ArrayList<>(); // 데이터를 저장할 리스트
		String gameDay = null; // 날짜를 저장할 변수

		// 각 행을 반복하며 데이터 추출
		for (WebElement row : rows) {
			List<WebElement> cells = row.findElements(By.tagName("td")); // 각 행의 셀 추출
			List<String> scheduleList = new ArrayList<>(); // 셀 데이터를 저장할 리스트

			// 각 셀의 텍스트를 리스트에 추가
			for (WebElement cell : cells) {
				scheduleList.add(cell.getText());
			}

			// 날짜 데이터 처리
			if (!scheduleList.isEmpty() && scheduleList.get(0).endsWith(")")) {
				gameDay = scheduleList.get(0); // 날짜가 있는 경우 저장
				data.add(scheduleList); // 데이터에 추가
			} else {
				scheduleList.add(0, gameDay); // 날짜가 없으면 이전 날짜 추가
				data.add(scheduleList); // 데이터에 추가
			}
		}

		// Gson 객체 생성하여 JSON으로 저장
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		// JSON 파일을 저장할 디렉토리 설정
		String directoryPath = "C:/work_YGC/sts-4.24.0.RELEASE-workspace/baseball_ygc/gameSchedule/";

		// JSON 파일 저장 경로 설정
		String filePath = String.format("%s%sm_calender.json", directoryPath, month);

		try (FileWriter writer = new FileWriter(filePath)) {
			gson.toJson(data, writer); // JSON 파일로 저장
		} catch (IOException e) {
			e.printStackTrace(); // 예외 처리
		}

		driver.quit(); // 브라우저 종료
		return "1"; // 성공적으로 완료
	}

	// 메인 메서드
	public static void main(String[] args) {
		GameSchedule crawler = new GameSchedule(); // 크롤러 객체 생성

		// 1월부터 12월까지 반복
		for (int month = 1; month <= 12; month++) {
			// 월을 두 자리 문자열로 포맷
			String monthStr = String.format("%02d", month);
			String result = crawler.crawl(monthStr); // 각 월에 대해 크롤링
			System.out.println("월: " + monthStr + ", 결과: " + result); // 결과 출력
		}
	}
}
