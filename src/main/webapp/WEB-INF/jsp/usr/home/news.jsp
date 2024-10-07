<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="NEWS"></c:set>
<link rel="stylesheet" href="/resource/common.css" />
<link rel="stylesheet" href="/resource/news.css" />

<%@ include file="../common/head.jspf"%>

<div class="main-content">
    <div class="main-title">
        <h1 class="main-title-content">최근 구단 뉴스</h1>
    </div>

    <!-- 팀 선택 목록 -->
    <div id="_kboTeamList" class="news_team">
        <ul>
            <li data-id="kbo" class="selected"><a href="#"><span class="name">전체</span></a></li>
            <li data-id="LG"><a href="#"><span class="name">LG</span></a></li>
            <li data-id="KT"><a href="#"><span class="name">KT</span></a></li>
            <li data-id="SK"><a href="#"><span class="name">SSG</span></a></li>
            <li data-id="NC"><a href="#"><span class="name">NC</span></a></li>
            <li data-id="OB"><a href="#"><span class="name">두산</span></a></li>
            <li data-id="HT"><a href="#"><span class="name">KIA</span></a></li>
            <li data-id="LT"><a href="#"><span class="name">롯데</span></a></li>
            <li data-id="SS"><a href="#"><span class="name">삼성</span></a></li>
            <li data-id="HH"><a href="#"><span class="name">한화</span></a></li>
            <li data-id="WO"><a href="#"><span class="name">키움</span></a></li>
       		<button class="search-btn" id="fetchNewsButton">조회</button>
        </ul>
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

    // 조회 버튼 클릭 시 뉴스 로딩
    $('#fetchNewsButton').click(function() {
        const selectedTeam = $('#_kboTeamList ul li.selected').data('id'); // 선택된 팀의 data-id 가져오기
        fetchNews(selectedTeam); // 선택된 팀의 뉴스 로딩
    });

    // 팀 선택 이벤트 처리
    $('#_kboTeamList ul li a').click(function(event) {
        event.preventDefault(); // 기본 링크 동작 방지
        $('#_kboTeamList ul li').removeClass('selected'); // 선택된 클래스 제거
        $(this).parent().addClass('selected'); // 선택된 팀 클래스 추가
    });

    // 뉴스 가져오는 함수
    function fetchNews(teamId) {
        // 스피너 표시
        $("#loadingSpinner").show();

        // 서버로부터 뉴스 데이터를 불러와서 동적으로 페이지에 삽입
        $.ajax({
            url: "${pageContext.request.contextPath}/getNews",  // 서버의 API 엔드포인트
            method: "GET",  // GET 메서드로 요청
            data: { team: teamId }, // 선택된 팀을 파라미터로 전송
            success: function(data) {
                console.log("teamId : " + teamId);
                // 뉴스 데이터를 리스트로 변환해서 출력
                let newsHtml = '';
                $.each(data, function(index, news) {
                    newsHtml += '<li>';
                    newsHtml += '<h2><a href="' + news.link + '" target="_blank">' + news.title + '</a></h2>';
                    newsHtml += '<img src="' + news.imgUrl + '" alt="' + news.title + '" />';
                    newsHtml += '<p>' + news.desc + '</p>';
                    newsHtml += '<span>' + news.press + '</span> | <span>' + news.time + '</span>';
                    newsHtml += '</li>';
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