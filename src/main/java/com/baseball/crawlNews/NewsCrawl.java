package com.baseball.crawlNews;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.baseball.vo.News;

import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

@Component
public class NewsCrawl {

    // Naver 뉴스 크롤링 메서드
    public List<News> crawl(String teamId) {
        List<News> newsList = new ArrayList<>(); // 뉴스 정보를 저장할 리스트

        // 크롬 드라이버 경로 설정
        System.setProperty("webdriver.chrome.driver",
                "C:/work_YGC/sts-4.24.0.RELEASE-workspace/baseball_ygc/chromedriver.exe");

        // WebDriver 객체 생성
        WebDriver driver = new ChromeDriver();

        try {
            // Naver 스포츠 뉴스 페이지로 이동
            driver.get("https://sports.news.naver.com/kbaseball/news/index?isphoto=N");
            Thread.sleep(3000); // 페이지 로딩 대기

            // 팀 선택에 따라 해당 팀 뉴스 크롤링
            if (teamId != null && !teamId.equals("kbo")) {
                // 특정 팀에 대한 뉴스 필터링을 위한 드롭다운 처리
                WebElement teamDropdown = driver.findElement(By.cssSelector("div.news_team a[data-id='" + teamId + "']"));
                teamDropdown.click();
                Thread.sleep(3000); // 팀 변경 대기
            }

            // 최신 뉴스 10개만 선택
            List<WebElement> newsItems = driver.findElements(By.cssSelector("div.news_list ul li")).subList(0, 10);

            // 각 뉴스 아이템에 대해 정보 추출
            for (WebElement item : newsItems) {
                String title = item.findElement(By.cssSelector("div.text a.title span")).getText(); // 제목
                String link = item.findElement(By.cssSelector("div.text a.title")).getAttribute("href"); // 링크
                String imgUrl = item.findElement(By.cssSelector("a.thmb img")).getAttribute("src"); // 이미지 URL
                String desc = item.findElement(By.cssSelector("div.text p.desc")).getText(); // 요약 텍스트
                String press = item.findElement(By.cssSelector("div.source span.press")).getText(); // 언론사
                String time = item.findElement(By.cssSelector("div.source span.time")).getText(); // 시간

                // 뉴스 객체 생성 후 리스트에 추가
                newsList.add(new News(title, link, imgUrl, desc, press, time));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit(); // 브라우저 종료
        }
        return newsList; // 크롤링한 뉴스 리스트 반환
    }
}

