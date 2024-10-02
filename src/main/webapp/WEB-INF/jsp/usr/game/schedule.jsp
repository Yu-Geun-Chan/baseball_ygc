<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="GAMESCHEDULE"></c:set>
<link rel="stylesheet" href="/resource/gameSchedule.css" />
<link rel="stylesheet" href="/resource/common.css" />

<%@ include file="../common/head.jspf"%>



<div class="main-content">
	<div class="main-title">
		<h1 class="main-title-content">경기일정 · 결과</h1>
	</div>
	<!-- 리그 드롭다운 메뉴 -->
	<div class="league-container">
		<select class="league-select" id="league" name="league">
			<option value="1">KBO 시범경기 일정</option>
			<option value="0,9,6">KBO 정규시즌 일정</option>
			<option value="3,4,5,7">KBO 포스트시즌 일정</option>
		</select>
	</div>
	<!-- 월 드롭다운 메뉴 -->
	<div class="month-container">
		<select class="month-select" id="month" name="month">
			<option value="01">1월</option>
			<option value="02">2월</option>
			<option value="03">3월</option>
			<option value="04">4월</option>
			<option value="05">5월</option>
			<option value="06">6월</option>
			<option value="07">7월</option>
			<option value="08">8월</option>
			<option value="09">9월</option>
			<option value="10">10월</option>
			<option value="11">11월</option>
			<option value="12">12월</option>
		</select>
		<button class="search-btn" id="fetchSchedule">조회</button>
	</div>

	<!-- 경기 일정 · 결과 테이블 -->
	<div class="table-container">
		<table id="scheduleTable" class="game_table" border="1">
			<colgroup>
				<col width="120">
				<col width="120">
				<col width="180">
				<col width="120">
				<col width="120">
			</colgroup>
			<thead>
				<tr>
					<th>날짜</th>
					<th>시간</th>
					<th>경기</th>
					<th>경기 장소</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
				<!-- 일정 데이터가 여기에 추가됩니다. -->
			</tbody>
		</table>
	</div>
</div>

<!-- 경기일정/결과 함수 -->
<script>
$(document).ready(function() {
    // 현재 달 가져오기 (01, 02, ..., 12 형식으로)
    var currentMonth = new Date().toISOString().slice(5, 7);
    // 현재 달을 기본 선택값으로 설정
    $("#month").val(currentMonth);

    // 리그 선택의 기본값 설정 (예: "KBO 정규시즌 일정"이 기본값일 경우)
    var defaultLeague = "0,9,6"; // 기본값을 원하는 리그 값으로 설정
    $("#league").val(defaultLeague);

    // 페이지 첫 로드 시 현재 달과 리그의 데이터를 불러오는 함수 호출
    fetchScheduleData(currentMonth, defaultLeague);

    // 조회 버튼 클릭 시 AJAX 요청
	$("#fetchSchedule").click(function() {
   	 var month = $("#month").val();
   	 var league = $("#league").val(); // series 값 가져오기
    	if (league) {
        fetchScheduleData(month, league);
   	 } else {
        console.error("series 파라미터가 누락되었습니다.");
    	}
	});

	// AJAX를 통해 데이터를 가져오는 함수
	function fetchScheduleData(month, league) {
		$.ajax({
			url: "${pageContext.request.contextPath}/getSchedule", // 컨텍스트 경로에 따라 수정
			type: "GET",
			data: {
				month: month,
				series: league // 리그 데이터를 함께 보냄
			},
			success: function(data) {
				// 테이블 내용을 초기화
				$("#scheduleTable tbody").empty();

				// 데이터가 없을 경우 '데이터가 없습니다' 메시지 표시
				if (data.length === 0) {
					var noDataRow = "<tr><td colspan='5' style='text-align: center;'>데이터가 없습니다</td></tr>";
					$("#scheduleTable tbody").append(noDataRow);
				} else {
					var prevDate = ""; // 이전 행의 날짜를 저장할 변수

					// 데이터로 테이블 업데이트
					for (var i = 0; i < data.length; i++) {
						var gameInfo = data[i].game;

						// 경기 정보 포맷팅 (띄어쓰기 추가)
						var formattedGame = gameInfo.replace(/([가-힣A-Za-z]+)\s*(\d*)\s*vs\s*(\d*)\s*([가-힣A-Za-z]+)/,
							function(match, team1, score1, score2, team2) {
								var score1Int = parseInt(score1);
								var score2Int = parseInt(score2);

								if (score1Int > score2Int) {
									score1 = "<span style='color: #cc0000;'>" + score1 + "</span>";
									score2 = "<span style='color: #000099;'>" + score2 + "</span>";
								} else if (score1Int < score2Int) {
									score1 = "<span style='color: #000099;'>" + score1 + "</span>";
									score2 = "<span style='color: #cc0000;'>" + score2 + "</span>";
								} else {
									score1 = "<span>" + score1 + "</span>";
									score2 = "<span>" + score2 + "</span>";
								}

								return team1 + " " + score1 + " vs " + score2 + " " + team2;
							});

						var currentDate = data[i].gameDay; // 현재 행의 날짜
						var dateClass = (prevDate === currentDate) ? "same-date" : "new-date";

						var row = "<tr>"
							+ "<td class='" + dateClass + "' style='text-align: center;'>"
							+ (prevDate === currentDate ? "" : currentDate)
							+ "</td>"
							+ "<td>" + data[i].time + "</td>"
							+ "<td>" + formattedGame + "</td>"
							+ "<td>" + data[i].location + "</td>"
							+ "<td>" + data[i].etc + "</td>"
							+ "</tr>";

						$("#scheduleTable tbody").append(row);
						prevDate = currentDate;
					}
				}
			},
			error: function() {
				alert("경기 일정 로드 실패.");
			}
		});
	}
});
</script>

<%@ include file="../common/foot.jspf"%>