<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="GAMESCHEDULE"></c:set>
<link rel="stylesheet" href="/resource/common.css" />

<%@ include file="../common/head.jspf"%>


<div class="main-content">
	<div>
		<h1>KBO 구단 순위</h1>
	</div>
	<table border="1">
		<thead>
			<tr>
				<th>순위</th>
				<th>팀명</th>
				<th>경기수</th>
				<th>승</th>
				<th>패</th>
				<th>게임차</th>
			</tr>
		</thead>
		<tbody>
			<!-- AJAX로 데이터가 추가됨 -->
		</tbody>
	</table>
</div>

<!-- 구단 순위 Ajax 요청-->
<script>
        $(document).ready(function () {
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
                            tbody.append(`
                                <tr>
                                    <td>${rank.rank}</td>
                                    <td>${rank.teamName}</td>
                                    <td>${rank.games}</td>
                                    <td>${rank.wins}</td>
                                    <td>${rank.losses}</td>
                                    <td>${rank.gamesBehind}</td>
                                </tr>
                            `);
                        });
                    } else {
                        tbody.append(`
                            <tr>
                                <td colspan="6">데이터가 없습니다.</td>
                            </tr>
                        `);
                    }
                },
                error: function () {
                    alert('데이터를 가져오는 데 실패했습니다.');
                }
            });
        });
    </script>

<%@ include file="../common/foot.jspf"%>