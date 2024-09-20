package com.baseball.util;

import org.openqa.selenium.By;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.util.List;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import com.opencsv.CSVWriter;

@Component
public class crawlTest {

	public void crawl() {
		System.setProperty("webdriver.chrome.driver",
				"C:/work_YGC/sts-4.24.0.RELEASE-workspace/baseball_ygc/chromedriver.exe");

		WebDriver driver = new ChromeDriver();
		WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20));

		try {
			driver.get("https://www.koreabaseball.com/Player/Search.aspx");

			WebElement teamDropdown = wait.until(
					ExpectedConditions.elementToBeClickable(By.id("cphContents_cphContents_cphContents_ddlTeam")));
			teamDropdown.click();

			WebElement samsungOption = wait
					.until(ExpectedConditions.elementToBeClickable(By.xpath("//option[text()='삼성']")));
			samsungOption.click();

			WebElement searchButton = driver.findElement(By.id("cphContents_cphContents_cphContents_btnSearch"));
			searchButton.click();

			extractPlayerDataToCSV(driver, wait);

			int currentPage = 1;
			while (true) {
				try {
					WebElement nextPageButton = wait.until(ExpectedConditions.elementToBeClickable(By
							.cssSelector(".paging a#cphContents_cphContents_cphContents_ucPager_btnNo" + currentPage)));

					if (nextPageButton.isEnabled()) {
						nextPageButton.click();
						wait.until(ExpectedConditions.stalenessOf(driver.findElement(By.cssSelector("table.tEx"))));
						extractPlayerDataToCSV(driver, wait);
					} else {
						break; // 더 이상 페이지가 없는 경우 루프 종료
					}
					currentPage++;
				} catch (StaleElementReferenceException e) {
					// 새로 찾기
					continue;
				}
			}
		} finally {
			driver.quit(); // 드라이버 종료
		}
	}

	private void extractPlayerDataToCSV(WebDriver driver, WebDriverWait wait) {
		// CSV 파일을 작성할 준비 - 파일명을 "players.csv"로 지정
		String filePath = "C:/work_YGC/sts-4.24.0.RELEASE-workspace/baseball_ygc/players.csv";
		File file = new File(filePath);
		try (CSVWriter writer = new CSVWriter(new FileWriter(file))) {
			System.out.println("CSV 파일이 생성된 경로: " + file.getAbsolutePath());
			// CSV 헤더 작성
			String[] header = { "Number", "Name", "Team", "Position", "BirthDate", "Height", "Weight", "Career" };
			writer.writeNext(header); // 헤더를 첫 번째 줄에 삽입

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