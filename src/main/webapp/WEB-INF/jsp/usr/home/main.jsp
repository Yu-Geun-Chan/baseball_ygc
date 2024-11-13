<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pageTitle }</title>
<c:set var="pageTitle" value="MAIN"></c:set>
<link rel="stylesheet" href="/resource/main.css" />
<link rel="stylesheet" href="/resource/common.css" />
<link rel="stylesheet" href="/resource/head.css" />
<script src="/resource/common.js" defer="defer"></script>
<!-- 제이쿼리, UI 추가 -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- 폰트어썸 FREE 아이콘 리스트 : https://fontawesome.com/v5.15/icons?d=gallery&p=2&m=free -->

</head>
<body>

	<!-- 1920x1300을 잡아주기 위한 -->
	<div class="_1300" id="section">
		<div class="header">
			<div class="topbar">
				<c:if test="${!rq.isLogined() }">
					<a class="topbar-contents topbar-contents-join" href="../member/join">회원가입</a>
					<a class="topbar-contents topbar-contents-login" href="../member/login">로그인</a>
				</c:if>
				<c:if test="${rq.isLogined() }">
					<a class="topbar-contents topbar-contents-info" href="../member/info">나의 정보</a>
					<a class="topbar-contents topbar-contents-logout" href="../member/doLogout">로그아웃</a>
				</c:if>
				<div class="topbar-contents topbar-contents-bar1">|</div>
				<div class="topbar-contents topbar-contents-bar2">|</div>
				<a href="../member/myPage">
					<svg class="mdi-user" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
					<path fill="currentColor"
							d="M12 4a4 4 0 0 1 4 4a4 4 0 0 1-4 4a4 4 0 0 1-4-4a4 4 0 0 1 4-4m0 10c4.42 0 8 1.79 8 4v2H4v-2c0-2.21 3.58-4 8-4" /></svg>
				</a>
			</div>
		</div>

		<div class="main-content">
			<div class="container">
				<div class="carousel">
					<a href="../game/schedule" id="gameSchedule" class="item">
						<h1>경기 일정</h1>
					</a>
					<a href="../home/weather" id="weather" class="item">
						<h1>야구장 날씨</h1>
					</a>
					<a href="../player/players" id="players" class="item">
						<h1>선수 조회</h1>
					</a>
					<a href="../home/teamInfo" id="teamInfo" class="item">
						<h1>구장 정보</h1>
					</a>
					<a href="../home/news" id="news" class="item">
						<h1>KBO 소식</h1>
					</a>
					<a href="../game/rank" id="teamRank" class="item">
						<h1>구단 순위</h1>
					</a>
					<a href="../article/freeList" id="article" class="item">
						<h1>자유게시판</h1>
					</a>
					<a href="#" id="ask" class="item">
						<h1>문의사항</h1>
					</a>
				</div>
			</div>
		</div>

<script>
    $(document).ready(function() {
        // 마우스 휠로 가로 스크롤 가능하게 하기
        $('.carousel').on('mousewheel', function(event) {
            event.preventDefault(); // 기본 스크롤 동작 방지
            // 스크롤 방향에 따라 캐러셀 이동 (속도 증가)
            this.scrollLeft += event.originalEvent.wheelDelta > 0 ? -50 : 50; // 속도 증가
        });
    });
</script>

<%@ include file="../common/foot.jspf"%>