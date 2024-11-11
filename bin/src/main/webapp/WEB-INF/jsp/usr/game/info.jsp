<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="GAMEINFO"></c:set>
<link rel="stylesheet" href="/resource/gameInfo.css" />
<link rel="stylesheet" href="/resource/common.css" />

<%@ include file="../common/head.jspf"%>

<div class="main-content">
	<div class="main-title">
		<h1 class="main-title-content">게임 정보</h1>
	</div>
	<div class="table-container">
		<table border="1">
			<thead>
				<tr>
					<th>순위</th>
					<th>팀명</th>
					<th>경기수</th>
					<th>승</th>
					<th>패</th>
					<th>무</th>
					<th>승률</th>
					<th>게임차</th>
				</tr>
			</thead>
			<tbody>
				<!-- 여기에 데이터가 추가된다. -->
			</tbody>
		</table>
	</div>
	<div class="loading-spinner" id="loadingSpinner" style="display: none;">
		<div class="spinner"></div>
	</div>
</div>

<!-- 현재날짜 가져오는 함수 -->
<script>
$(document).ready(function () {
    const today = new Date();

    // 날짜 형식 정의
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더해줘야한다.
    const day = String(today.getDate()).padStart(2, '0');
    const formattedDate = '현재날짜기준' + ' (' + year + '.' + month + '.' + day + ')' ; // YYYY.MM.DD 형식으로 포맷팅

    console.log('formattedDate : ' + formattedDate);
    // 현재 날짜를 .date 요소에 추가
    $('.date').text(formattedDate);
});
</script>

<!-- 구단 순위 불러오는 함수 -->
<script>
$(document).ready(function () {
	// 스피너 표시
	$("#loadingSpinner").show();
    // AJAX 요청으로 팀 순위 가져오기
    $.ajax({
        url: "${pageContext.request.contextPath}/getRank",
        method: 'GET',
        dataType: 'json',
        success: function (data) {
            // 테이블에 데이터 추가
            let tbody = $('table tbody');
            tbody.empty(); // 기존 데이터 초기화
            if (data.length > 0) {
                data.forEach(function (rank) {
                    // 각 데이터 값을 변수에 저장
                    var rankValue = rank.rank;
                    var teamName = rank.teamName;
                    var games = rank.games;
                    var wins = rank.wins;
                    var losses = rank.losses;
                    var draws = rank.draws;
                    var winningPercentage = rank.winningPercentage;
                    var gamesBehind = rank.gamesBehind;

                    // HTML 생성
                    var row = "<tr>"
                        + "<td>" + rankValue + "</td>" // 팀 순위(ex : 1, 2, 3 ...)
                        + "<td>" + teamName + "</td>" // 구단명
                        + "<td>" + games + "</td>" // 총 진행한 게임 수
                        + "<td>" + wins + "</td>" // 승리한 횟수
                        + "<td>" + losses + "</td>" // 패배한 횟수
                        + "<td>" + draws + "</td>" // 비긴 횟수
                        + "<td>" + winningPercentage + "</td>" // 승률
                        + "<td>" + gamesBehind + "</td>" // 1위와의 게임차
                        + "</tr>";

                    // 테이블에 추가
                    tbody.append(row);
                });
            } else {
                tbody.append(`
                    <tr>
                        <td colspan="8">데이터가 없습니다.</td>
                    </tr>
                `);
            }
        },
        error: function () {
            alert('데이터를 가져오는 데 실패했습니다.');
        },
        complete: function() {
            // 스피너 숨기기
            $("#loadingSpinner").hide();
        }
    });
});
</script>

<%@ include file="../common/foot.jspf"%>