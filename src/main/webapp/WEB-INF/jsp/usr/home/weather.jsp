<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="WEATHER"></c:set>
<link rel="stylesheet" href="/resource/weather.css" />
<link rel="stylesheet" href="/resource/common.css" />

<%@ include file="../common/head.jspf"%>

<div id="weather-container"></div>

<script>
const stadiums = [
    { name: '잠실', lat: 37.5122579, lon: 127.0719011 },
    { name: '수원', lat: 37.2997553, lon: 127.0096685 },
    { name: '고척', lat: 37.498, lon: 126.867 },
    { name: '인천', lat: 37.4370423, lon: 126.6932617 },
    { name: '대전', lat: 36.3170789, lon: 127.4291345 },
    { name: '사직', lat: 35.1940316, lon: 129.0615183 },
    { name: '창원', lat: 35.2225335, lon: 128.5823895 },
    { name: '대구', lat: 35.8411705, lon: 128.6815273 },
    { name: '광주', lat: 35.1681242, lon: 126.8891056 },
];

const apiKey = 'YOUR_API_KEY'; 

$(document).ready(function() {
    let weatherResults = new Array(stadiums.length); // 날씨 정보를 저장할 배열

    $.each(stadiums, function(index, stadium) {
        $.ajax({
            url: `https://api.openweathermap.org/data/2.5/weather`,
            type: 'GET',
            data: {
                lat: stadium.lat, // 위도 값
                lon: stadium.lon, // 경도 값
                appid: apiKey,    // API 키
                units: 'metric',  // 섭씨 온도
                lang: 'kr'        // 한국어 응답
            },
            success: function(data) {
                const weatherInfo = {
                    name: stadium.name,
                    temp: data.main.temp,
                    description: data.weather.length > 0 ? data.weather[0].description : '정보 없음',
                    humidity: data.main.humidity,
                    windSpeed: data.wind.speed
                };
                // 인덱스를 사용해 결과를 저장
                // -> 날씨가 나오는 지역의 순서를 고정시키기 위해
                weatherResults[index] = weatherInfo; 

                // 모든 요청이 끝났을 때 결과를 출력
                if (weatherResults.every(result => result !== undefined)) {
                    displayWeather(weatherResults);
                }
            },
            error: function() {
                console.log('날씨 데이터를 불러오는 중 오류가 발생했습니다.');
            }
        });
    });

    function displayWeather(results) {
        // 날씨 정보를 화면에 출력
        $('#weather-container').empty(); // 기존 내용 비우기
        results.forEach(result => {
            const weatherHtml = `
                <div class="stadium-weather">
                    <h3>` + result.name + `</h3>
                    <p>온도: ` + result.temp + ` °C</p>
                    <p>날씨: ` + result.description + `</p>
                    <p>습도: ` + result.humidity + `%</p>
                    <p>풍속: ` + result.windSpeed + ` m/s</p>
                </div>
            `;
            $('#weather-container').append(weatherHtml); // 결과를 DOM에 추가
        });
    }
});

</script>

<%@ include file="../common/foot.jspf"%>