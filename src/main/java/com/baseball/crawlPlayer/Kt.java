package com.baseball.crawlPlayer;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.Duration;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.baseball.service.PlayerService;
import com.baseball.vo.Player;
import com.opencsv.CSVWriter;

@Component
public class Kt {

	public void crawl() {
		// 웹드라이버 실행 파일 경로 설정
		System.setProperty("webdriver.chrome.driver",
				"C:/work_YGC/sts-4.24.0.RELEASE-workspace/baseball_ygc/chromedriver.exe");

		// 웹 드라이버 초기화
		WebDriver driver = new ChromeDriver();
		WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20)); // 20초 대기

		try {
			// 크롤링할 웹 페이지 URL
			driver.get("https://www.koreabaseball.com/Player/Search.aspx");

			// 팀 드롭다운 메뉴 선택
			WebElement teamDropdown = wait.until(
					ExpectedConditions.elementToBeClickable(By.id("cphContents_cphContents_cphContents_ddlTeam")));
			teamDropdown.click();
			// 해당 구단 선택
			// '' 부분에 구단명을 넣어주면 된다.
			WebElement samsungOption = wait
					.until(ExpectedConditions.elementToBeClickable(By.xpath("//option[text()='KT']")));
			samsungOption.click();

			// 검색 버튼 클릭
			WebElement searchButton = driver.findElement(By.id("cphContents_cphContents_cphContents_btnSearch"));
			searchButton.click();

			extractPlayerDataToCSV(driver, wait);

			// 페이징
			// 최초 페이지 1부터 시작
			int currentPage = 1;
			final int MAX_PAGES = 5; // 최대 페이지 수
			while (currentPage <= MAX_PAGES) {
				// 1 ~ 5번까지 각각 해당하는 페이지번호를 선택
				WebElement nextPageButton = driver.findElement(
						By.cssSelector(".paging a#cphContents_cphContents_cphContents_ucPager_btnNo" + currentPage));

				// nextPageButton이 존재하는 경우에 해당하는 다음 페이지 번호를 누르면
				// table의 클래스명이 tEx인 요소가 사라질때까지 기다린 후에 extractPlayerData(driver, wait); 실행
				if (nextPageButton.isEnabled()) {
					nextPageButton.click();
					wait.until(ExpectedConditions.stalenessOf(driver.findElement(By.cssSelector("table.tEx"))));
					extractPlayerDataToCSV(driver, wait);
				} else {
					break; // 더 이상 페이지가 없는 경우 루프 종료
				}
				// 순차적으로 1 ~ 5번까지 nextPageButton의 id값을 설정하기 위해 +1씩 해줘야한다.
				currentPage++;
			}
		} finally {
			// 웹 드라이버 종료
			driver.quit();
		}
	}

	private void extractPlayerDataToCSV(WebDriver driver, WebDriverWait wait) {
		// CSV 파일을 작성할 준비 - 파일명을 "players.csv"로 지정
		String filePath = "C:/work_YGC/sts-4.24.0.RELEASE-workspace/baseball_ygc/playersKT.csv";
		File file = new File(filePath);
		try (CSVWriter writer = new CSVWriter(new FileWriter(file, true))) { // append 모드로 열기
			System.out.println("CSV 파일이 생성된 경로: " + file.getAbsolutePath());
			// 테이블이 화면에 보일 때까지 대기
			WebElement table = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("table.tEx")));

			// 테이블의 모든 행을 가져옴
			List<WebElement> rows = table.findElements(By.cssSelector("tbody > tr"));

			// 각 행에 대해 처리
			for (WebElement row : rows) {
				// 각 행의 셀 데이터를 가져옴
				List<WebElement> cells = row.findElements(By.tagName("td"));

				// 셀이 7개 이상일 때만 처리
				if (cells.size() >= 7) {
					String numberStr = cells.get(0).getText().trim(); // 등번호 추출

					// 등번호가 비어있으면 다음 행으로 넘어감
					if (numberStr.isEmpty()) {
						continue;
					}

					int number;
					try {
						// 등번호를 정수로 변환
						number = Integer.parseInt(numberStr);
					} catch (NumberFormatException e) {
						// 변환할 수 없으면 다음 행으로 넘어감
						continue;
					}

					// 나머지 셀 데이터 추출
					String name = cells.get(1).getText().trim(); // 이름
					String teamName = cells.get(2).getText().trim(); // 소속 구단
					String position = cells.get(3).getText().trim(); // 포지션
					String birthDate = cells.get(4).getText().trim(); // 생년월일

					// 키, 몸무게는 "185cm, 100kg" 형식이므로 쉼표로 분리
					String[] heightWeight = cells.get(5).getText().split(", ");
					int height = Integer.parseInt(heightWeight[0].replace("cm", "").trim()); // 키
					int weight = Integer.parseInt(heightWeight[1].replace("kg", "").trim()); // 몸무게

					String career = cells.get(6).getText().trim(); // 경력

					// 플레이어 데이터를 CSV 파일에 추가
					String[] playerData = { String.valueOf(number), name, teamName, position, birthDate,
							String.valueOf(height), String.valueOf(weight), career };
					writer.writeNext(playerData); // CSV 파일에 한 줄 추가
				}
			}
		} catch (IOException e) {
			// 파일 작성 중 에러 발생 시 출력
			e.printStackTrace();
		}
	}
}