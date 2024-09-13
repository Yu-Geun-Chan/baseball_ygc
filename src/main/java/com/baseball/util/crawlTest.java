package com.baseball.util;

import java.io.FileWriter;
import java.io.IOException;
import java.time.Duration;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class crawlTest {
	public static void crawl() {
		// Set the path to your WebDriver executable
		System.setProperty("webdriver.chrome.driver",
				"C:/work_YGC/sts-4.24.0.RELEASE-workspace/baseball_ygc/chromedriver.exe");

		// Initialize WebDriver
		WebDriver driver = new ChromeDriver();
		WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20)); // Increase timeout if needed

		try {
			// Navigate to the player search page
			driver.get("https://www.koreabaseball.com/Player/Search.aspx");

			// Select the team "삼성"
			WebElement teamDropdown = wait.until(
					ExpectedConditions.elementToBeClickable(By.id("cphContents_cphContents_cphContents_ddlTeam")));
			teamDropdown.click();
			WebElement samsungOption = wait
					.until(ExpectedConditions.elementToBeClickable(By.xpath("//option[text()='삼성']")));
			samsungOption.click();

			// Click the search button
			WebElement searchButton = driver.findElement(By.id("cphContents_cphContents_cphContents_btnSearch"));
			searchButton.click();

			// Function to extract player data from the table
			extractPlayerData(driver, wait);

			// Handle pagination
			while (true) {
				WebElement nextPageButton = driver.findElement(By.cssSelector(".paging a[title='다음 페이지로 이동']"));
				if (nextPageButton.isEnabled()) {
					nextPageButton.click();
					wait.until(ExpectedConditions.stalenessOf(driver.findElement(By.cssSelector(".tEx"))));
					extractPlayerData(driver, wait);
				} else {
					break; // Exit loop if no more pages
				}
			}

		} finally {
			// Close the WebDriver
			driver.quit();
		}
	}

	private static void extractPlayerData(WebDriver driver, WebDriverWait wait) {
		// Wait for the table to be visible
		WebElement table = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("table.tEx")));

		// Extract rows
		List<WebElement> rows = table.findElements(By.cssSelector("tbody > tr"));
		for (WebElement row : rows) {
			List<WebElement> cells = row.findElements(By.tagName("td"));
			for (WebElement cell : cells) {
				System.out.print(cell.getText() + "\t"); // Print cell text
			}
			System.out.println();
		}
	}
}
