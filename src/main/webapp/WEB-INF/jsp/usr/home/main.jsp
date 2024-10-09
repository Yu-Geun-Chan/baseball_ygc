<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN"></c:set>
<link rel="stylesheet" href="/resource/main.css" />
<link rel="stylesheet" href="/resource/common.css" />

<%@ include file="../common/head1300.jspf"%>

<div class="main-content">
	<div class="container">
		<div class="carousel">
			<a href="../game/schedule" id="gameSchedule" class="item">
				<h1>경기 일정</h1>
			</a>
			<a href="#" id="gameInfo" class="item">
				<h1>경기 정보</h1>
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
			<a href="../article/list" id="article" class="item">
				<h1>자유게시판</h1>
			</a>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		// 마우스 휠로 가로 스크롤 가능하게 하기
		$('.carousel').on('mousewheel', function(event) {
			event.preventDefault(); // 기본 스크롤 동작 방지
			// 스크롤 방향에 따라 캐러셀 이동
			this.scrollLeft += event.originalEvent.wheelDelta > 0 ? -100 : 100; // 숫자 크기에 따라 스크롤이 빠르게 움직임
		});
	});
</script>


<%@ include file="../common/foot.jspf"%>