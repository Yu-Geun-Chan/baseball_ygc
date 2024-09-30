<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="GAMESCHEDULE"></c:set>
<link rel="stylesheet" href="/resource/gameSchedule.css" />
<link rel="stylesheet" href="/resource/common.css" />

<%@ include file="../common/head.jspf"%>


<!-- 월 드롭다운 메뉴 -->

<div class="main-content">
	<div class="main-title">
		<h1 class="main-title-content">경기일정 · 결과</h1>
	</div>
	<div class="search-container">
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
	$(document)
			.ready(
					function() {
						// 현재 달 가져오기 (01, 02, ..., 12 형식으로)
						var currentMonth = new Date().toISOString().slice(5, 7);
						// 현재 달을 기본 선택값으로 설정
						$("#month").val(currentMonth);

						// 페이지 첫 로드 시 현재 달의 데이터를 불러오는 함수 호출
						fetchScheduleData(currentMonth);

						// 조회 버튼 클릭 시 AJAX 요청
						$("#fetchSchedule").click(function() {
							var month = $("#month").val();
							fetchScheduleData(month);
						});

						// AJAX를 통해 데이터를 가져오는 함수
						function fetchScheduleData(month) {
							$
									.ajax({
										url : "${pageContext.request.contextPath}/getSchedule", // 컨텍스트 경로에 따라 수정
										type : "GET",
										data : {
											month : month
										},
										success : function(data) {
											// 테이블 내용을 초기화
											$("#scheduleTable tbody").empty();

											// 데이터가 없을 경우 '데이터가 없습니다' 메시지 표시
											if (data.length === 0) {
												var noDataRow = "<tr><td colspan='5' style='text-align: center;'>데이터가 없습니다</td></tr>";
												$("#scheduleTable tbody")
														.append(noDataRow);
											} else {
												var prevDate = ""; // 이전 행의 날짜를 저장할 변수

												// 데이터로 테이블 업데이트
												for (var i = 0; i < data.length; i++) {
													var gameInfo = data[i].game;

													// 경기 정보 포맷팅 (띄어쓰기 추가)
													var formattedGame = gameInfo
															.replace(
																	/([가-힣A-Za-z]+)\s*(\d*)\s*vs\s*(\d*)\s*([가-힣A-Za-z]+)/,
																	function(
																			match,
																			team1,
																			score1,
																			score2,
																			team2) {
																		// 점수를 정수로 변환
																		var score1Int = parseInt(score1);
																		var score2Int = parseInt(score2);

																		// 숫자 비교 후 스타일링
																		if (score1Int > score2Int) {
																			score1 = "<span style='color: #cc0000;'>"
																					+ score1
																					+ "</span>"; // 어두운 빨간색
																			score2 = "<span style='color: #000099;'>"
																					+ score2
																					+ "</span>"; // 어두운 파란색
																		} else if (score1Int < score2Int) {
																			score1 = "<span style='color: #000099;'>"
																					+ score1
																					+ "</span>"; // 어두운 파란색
																			score2 = "<span style='color: #cc0000;'>"
																					+ score2
																					+ "</span>"; // 어두운 빨간색
																		} else {
																			// 점수가 동일할 경우
																			score1 = "<span>"
																					+ score1
																					+ "</span>";
																			score2 = "<span>"
																					+ score2
																					+ "</span>";
																		}

																		return team1
																				+ " "
																				+ score1
																				+ " vs "
																				+ score2
																				+ " "
																				+ team2; // 띄어쓰기 추가
																	});

													var currentDate = data[i].gameDay; // 현재 행의 날짜

													// 이전 날짜와 현재 날짜가 같은지 확인하여 클래스 할당
													var dateClass = (prevDate === currentDate) ? "same-date"
															: "new-date";

													// 날짜가 같으면 빈칸으로 설정, 다르면 날짜 표시
													var row = "<tr>"
															+ "<td class='" + dateClass + "' style='text-align: center;'>"
															+ (prevDate === currentDate ? ""
																	: currentDate)
															+ "</td>" + // 날짜를 가운데 정렬
															"<td>"
															+ data[i].time
															+ "</td>" + // 시간
															"<td>"
															+ formattedGame
															+ "</td>" + // 포맷팅된 경기 정보
															"<td>"
															+ data[i].location
															+ "</td>" + // 장소
															"<td>"
															+ data[i].etc
															+ "</td>" + // 비고
															"</tr>";

													// 테이블에 행 추가
													$("#scheduleTable tbody")
															.append(row);

													// 현재 날짜를 이전 날짜로 저장
													prevDate = currentDate;
												}
											}
										},
										error : function() {
											// 데이터 로드 실패 시 알림
											alert("경기 일정 로드 실패.");
										}
									});
						}
					});
</script>

<%@ include file="../common/foot.jspf"%>