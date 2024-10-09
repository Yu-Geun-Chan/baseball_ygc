package com.baseball.crawlNews;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.baseball.vo.News;

import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.StaleElementReferenceException;

@Component
public class NewsCrawl {

    public List<News> crawl(String teamId) {
        List<News> newsList = new ArrayList<>(); // 뉴스 정보를 저장할 리스트

        System.setProperty("webdriver.chrome.driver",
                "C:/work_YGC/sts-4.24.0.RELEASE-workspace/baseball_ygc/chromedriver.exe");

        WebDriver driver = new ChromeDriver();
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10)); // WebDriverWait 객체 생성

        try {
            driver.get("https://sports.news.naver.com/kbaseball/news/index?isphoto=N");
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("ul#_sortTypeList li.toggle a")));

            // "KBO" 항목 선택
            WebElement kboOption = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("ul#_sectionList li[data-id='kbo']")));
            kboOption.click();
            
            // "구단별" 항목 클릭
            WebElement teamSortToggle = driver.findElement(By.cssSelector("ul#_sortTypeList li.toggle a"));
            teamSortToggle.click();
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("_kboTeamList"))); // 드롭다운이 보일 때까지 대기

            // 드롭다운 보이게 만들기
            ((JavascriptExecutor) driver).executeScript("arguments[0].style.display='block';", driver.findElement(By.id("_kboTeamList")));

            // 선택할 팀의 요소를 찾기
            WebElement teamToSelect = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("div.news_team>ul li[data-id='" + teamId + "'] a")));
            teamToSelect.click();

            // 팀 선택 후 뉴스 항목이 로드될 때까지 대기
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("div#_newsList ul")));

            // 최신 뉴스 항목을 가져오는 부분
            List<WebElement> newsItems;
            do {
                // 현재 뉴스 항목을 가져오기
                newsItems = driver.findElements(By.cssSelector("div#_newsList ul li"));

                // 뉴스 항목이 존재하는지 확인
                for (WebElement item : newsItems) {
                    try {
                        String title = item.findElement(By.cssSelector("div.text a.title span")).getText(); // 제목
                        String link = item.findElement(By.cssSelector("div.text a.title")).getAttribute("href"); // 링크
                        
                        // 이미지 URL 가져오기 (없을 경우 빈 문자열로 처리)
                        String imgUrl = "";
                        try {
                            imgUrl = item.findElement(By.cssSelector("a.thmb img")).getAttribute("src"); // 이미지 URL
                        } catch (NoSuchElementException e) {
                            // 이미지가 없을 경우 예외 발생, imgUrl은 빈 문자열로 설정됨
                        }
                        
                        String desc = item.findElement(By.cssSelector("div.text p.desc")).getText(); // 요약 텍스트
                        String press = item.findElement(By.cssSelector("div.source span.press")).getText(); // 언론사
                        String time = ""; // 시간 요소가 없으면 빈 문자열로 처리
                        try {
                        	time = item.findElement(By.cssSelector("div.source span.time")).getText(); // 시간
                        } catch (NoSuchElementException e) {
                        	// 시간이 없을 경우 예외 발생, time은 빈 문자열로 설정됨
                        }
                        // 뉴스 객체 생성 후 리스트에 추가
                        newsList.add(new News(title, link, imgUrl, desc, press, time));

                        // 10개가 모이면 더 이상 크롤링하지 않음
                        if (newsList.size() >= 10) {
                            break; // 반복문을 빠져나가서 더 이상 뉴스 수집하지 않도록 함
                        }
                    } catch (StaleElementReferenceException e) {
                        // 요소를 다시 가져오기
                        newsItems = driver.findElements(By.cssSelector("div#_newsList ul li"));
                    }
                }

                // 뉴스 항목이 업데이트되기까지 대기
                wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("div#_newsList ul li")));

            } while (!newsItems.isEmpty() && newsList.size() < 10); // 뉴스 항목이 비어있지 않고, 수집된 뉴스가 10개 미만인 경우 계속

        } catch (Exception e) {
            e.printStackTrace(); // 오류 발생 시 스택 트레이스 출력
        } finally {
            driver.quit(); // 브라우저 종료
        }
        return newsList; // 크롤링한 뉴스 리스트 반환
    }
}