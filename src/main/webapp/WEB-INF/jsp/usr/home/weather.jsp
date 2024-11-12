<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="WEATHER"></c:set>
<link rel="stylesheet" href="/resource/weather.css" />
<link rel="stylesheet" href="/resource/common.css" />

<%@ include file="../common/head.jspf"%>

<div class="main-content">
    <div id="weather-container"></div>
</div>

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

// 경기장별 구단 로고
const teamLogos = {
    '잠실': ['/images/teamLogos/lg.png', '/images/teamLogos/doosan.png'],
    '수원': ['/images/teamLogos/kt.png'],
    '고척': ['/images/teamLogos/kiwoom.png'],
    '인천': ['/images/teamLogos/ssg.png'],
    '대전': ['/images/teamLogos/hanhwa.png'],
    '사직': ['/images/teamLogos/lotte.png'],
    '창원': ['/images/teamLogos/nc.png'],
    '대구': ['/images/teamLogos/samsung.png'],
    '광주': ['/images/teamLogos/kia.png']
};

// 날씨 상태에 대한 한글 변환 매핑
const weatherDescriptions = {
    'Clear': '맑음',
    'Clouds': '흐림',
    'Rain': '비',
    'Drizzle': '이슬비',
    'Thunderstorm': '뇌우',
    'Snow': '눈',
    'Mist': '옅은 안개',
    'Smoke': '연기',
    'Haze': '실안개',
    'Dust': '먼지',
    'Fog': '짙은 안개',
    'Sand': '모래 바람',
    'Ash': '화산재',
    'Squall': '돌풍',
    'Tornado': '토네이도'
};

$(document).ready(function() {
    let weatherResults = new Array(stadiums.length);

    $.each(stadiums, function(index, stadium) {
        $.ajax({
            url: `https://api.openweathermap.org/data/2.5/weather`,
            type: 'GET',
            data: {
                lat: stadium.lat,
                lon: stadium.lon,
                appid: apiKey,
                units: 'metric',
                lang: 'kr'
            },
            success: function(data) {
                const weatherInfo = {
                    name: stadium.name,
                    temp: data.main.temp,
                    description: data.weather.length > 0 ? data.weather[0].description : '정보 없음',
                    main: data.weather.length > 0 ? data.weather[0].main : '정보 없음',
                    humidity: data.main.humidity,
                    windSpeed: data.wind.speed
                };
                weatherResults[index] = weatherInfo;

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
        $('#weather-container').empty();
        results.forEach(result => {
            let logos = '';
            if (teamLogos[result.name]) {
                teamLogos[result.name].forEach(logoSrc => {
                    logos += `<img class="image" src="` + logoSrc + `" alt="` + result.name + ` 로고" width="70"> `;
                });
            }

            // 날씨 상태를 한글로 변환
            const weatherStatus = weatherDescriptions[result.main] || '정보 없음';

            const weatherHtml = `
                <div class="stadium-weather">
                    <div class="team-logos">` + logos + `</div>
                    <h3>` + result.name + `</h3>
                    <p>온도: ` + result.temp + ` °C</p>
                    <p>날씨: ` + weatherStatus + `</p> <!-- 한글 날씨 상태 표시 -->
                    <p>습도: ` + result.humidity + `%</p>
                    <p>풍속: ` + result.windSpeed + ` m/s</p>
                </div>
            `;
            $('#weather-container').append(weatherHtml);
        });
    }
});
</script>

<%@ include file="../common/foot.jspf"%>