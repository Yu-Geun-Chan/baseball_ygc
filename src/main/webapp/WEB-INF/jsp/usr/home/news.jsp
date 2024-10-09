<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="NEWS"></c:set>
<link rel="stylesheet" href="/resource/common.css" />
<link rel="stylesheet" href="/resource/news.css" />

<%@ include file="../common/head.jspf"%>

<div class="main-content">
    <div class="main-title">
        <h1 class="main-title-content">오늘자 KBO 뉴스</h1>
    </div>

    <!-- 팀 선택 목록 -->
    <div id="team_list" class="news_team">
        <ul>
            <li data-id="kbo" class="selected"><a href="#"><img class="name" src="/images/teamLogos/kbo.png" style="width: 80px; height: 61px; object-fit: cover;"/></a></li>
            <li style="color:#C30037" data-id="LG"><a href="#"><img class="name" src="/images/teamLogos/lg.png"/></a></li>
            <li style="color:#000000" data-id="KT"><a href="#"><img class="name" src="/images/teamLogos/kt.png"/></a></li>
            <li style="color:#CD142C" data-id="SK"><a href="#"><img class="name" src="/images/teamLogos/ssg.png" /></a></li>
            <li style="color:#1F468F" data-id="NC"><a href="#"><img class="name" src="/images/teamLogos/nc.png" /></a></li>
            <li style="color:#0E0E2A" data-id="OB"><a href="#"><img class="name" src="/images/teamLogos/doosan.png"/></a></li>
            <li style="color:#E20D28" data-id="HT"><a href="#"><img class="name" src="/images/teamLogos/kia.png"/></a></li>
            <li style="color:#D31F40" data-id="LT"><a href="#"><img class="name" src="/images/teamLogos/lotte.png" /></a></li>
            <li style="color:#0064B2" data-id="SS"><a href="#"><img class="name" src="/images/teamLogos/samsung.png"/></a></li>
            <li style="color:#EF8A2F" data-id="HH"><a href="#"><img class="name" src="/images/teamLogos/hanhwa.png" /></a></li>
            <li style="color:#85001F" data-id="WO"><a href="#"><img class="name" src="/images/teamLogos/kiwoom.png" /></a></li>
        </ul>
    </div>
    <!-- 네이버 야구 뉴스 링크 -->
    <div class="total-news">
		<a class="total-news-btn" target="_blank" href="https://sports.news.naver.com/kbaseball/news/index?isphoto=N">전체 뉴스 보기</a>
    </div>
    
    <!-- 뉴스 리스트를 표시할 요소 -->
    <div class="news-list-container">
        <ul id="news-list"></ul>
    </div>
    
    <div class="loading-spinner" id="loadingSpinner" style="display: none;">
        <div class="spinner"></div>
    </div>
</div>

<!-- 네이버 뉴스 Ajax 요청 -->
<script>
$(document).ready(function() {
    // 스피너 표시
    $("#loadingSpinner").show();

    // 초기 뉴스 로딩 (전체 뉴스)
    fetchNews('kbo'); // 기본값으로 전체 뉴스 로딩

    // 팀 선택 이벤트 처리
    $('#team_list ul li a').click(function(event) {
        event.preventDefault(); // 기본 링크 동작 방지
        $('#team_list ul li').removeClass('selected'); // 선택된 클래스 제거
        $(this).parent().addClass('selected'); // 선택된 팀 클래스 추가
        
        // 선택된 팀의 뉴스 로딩
        const selectedTeam = $('#team_list ul li.selected').data('id'); // 선택된 팀의 data-id 가져오기
        fetchNews(selectedTeam); // 선택된 팀의 뉴스 로딩
        console.log("selectedTeam : " + selectedTeam);
    });

 	// 뉴스 가져오는 함수
    function fetchNews(teamId) {
        // 스피너 표시
        $("#loadingSpinner").show();
        
        // 뉴스 리스트 초기화
        $('#news-list').empty(); // 기존 뉴스 리스트를 초기화

        // 서버로부터 뉴스 데이터를 불러와서 동적으로 페이지에 삽입
        $.ajax({
            url: "${pageContext.request.contextPath}/getNews",  // 서버의 API 엔드포인트
            method: "GET",  // GET 메서드로 요청
            data: { teamId: teamId }, // 선택된 팀을 파라미터로 전송
            success: function(data) {
                // 뉴스 데이터를 리스트로 변환해서 출력
                let newsHtml = '';
                $.each(data, function(index, news) {
                    newsHtml += '<li style="display: flex; align-items: flex-start; margin-bottom: 10px;">'; // 리스트 항목에 flex 스타일 추가
                    
                    // 이미지가 빈 문자열이 아닐 경우에만 이미지 추가
                    if (news.imgUrl) {
                        newsHtml += '<img src="' + news.imgUrl + '" alt="' + news.title + '" style="width: 140px; height: auto; margin-right: 10px; object-fit: cover; object-position: center;" />'; // 이미지 너비 140px로 고정, 높이는 자동
                    }
                    
                    newsHtml += '<div style="flex-grow: 1;">'; // 이미지와 설명을 감싸는 div 추가
                    newsHtml += '<h2 style="margin: 0; font-size: 1.2em;"><a href="' + news.link + '" target="_blank">' + news.title + '</a></h2>'; // 제목 스타일 조정
                    newsHtml += '<p style="margin: 5px 0;">' + news.desc + '</p>'; // 설명 추가 및 여백 조정
                    newsHtml += '<span style="font-size: 0.9em; color: gray;">' + news.press + '</span> | <span style="font-size: 0.9em; color: gray;">' + news.time + '</span>';
                    newsHtml += '</div>'; // div 닫기
                    newsHtml += '</li>'; // 리스트 항목 닫기
                    newsHtml += '<hr style="color:gray; margin-bottom:10px;">'; // 밑줄 추가
                });
                // 뉴스 리스트를 HTML로 변환하여 삽입
                $('#news-list').html(newsHtml);
            },
            error: function() {
                // 오류 발생 시 메시지를 표시
                $('#news-list').html('<li>Failed to load news.</li>');
            },
            complete: function() {
                // 스피너 숨기기
                $("#loadingSpinner").hide();
            }
        });
    }

});
</script>


<%@ include file="../common/foot.jspf"%>