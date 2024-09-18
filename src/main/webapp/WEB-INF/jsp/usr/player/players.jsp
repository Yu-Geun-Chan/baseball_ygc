<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="PLAYERS"></c:set>
<link rel="stylesheet" href="/resource/players.css" />

<%@ include file="../common/head.jspf"%>


<div class="main-title">
	<div class="main-title-content">선수 조회</div>
</div>
<div class="search-container">
	<form action="/players" method="get" id="search-form">
		<select name="teamName" class="option" id="team-filter">
			<option value="">팀</option>
			<option value="KIA">KIA</option>
			<option value="삼성">삼성</option>
			<option value="LG">LG</option>
			<option value="두산">두산</option>
			<option value="KT">KT</option>
			<option value="SSG">SSG</option>
			<option value="롯데">롯데</option>
			<option value="한화">한화</option>
			<option value="NC">NC</option>
			<option value="키움">키움</option>
		</select>
		<select name="position" class="option" id="position-filter">
			<option value="">포지션</option>
			<option value="투수">투수</option>
			<option value="포수">포수</option>
			<option value="내야수">내야수</option>
			<option value="외야수">외야수</option>
		</select>
		<input name="name" class="search" id="name-filter">
		<div class="btn_search-container">
			<input type="submit" value="검색" class="btn_search" id="search-button">
		</div>
	</form>
</div>
<p class="title">
	<strong>
		검색결과 :
		<span class="point">0</span>
		건
	</strong>
</p>

<div class="player-info-container">
	<table cellpadding="0" cellspacing="0">
		<colgroup>
			<col width="75">
			<col width="75">
			<col width="75">
			<col width="75">
			<col width="150">
			<col width="150">
			<col width="400">
		</colgroup>
		<thead>
			<tr>
				<th>등번호</th>
				<th>구단명</th>
				<th>선수명</th>
				<th>포지션</th>
				<th>생년월일</th>
				<th>체격</th>
				<th>출신교</th>
			</tr>
		</thead>
		<tbody id="player-table-body">
		</tbody>
	</table>
	<!-- 	동적 페이징 -->
	<div class="pagination">
		<c:set var="paginationLen" value="3" />
		<c:set var="startPage" value="${page - paginationLen >= 1 ? page - paginationLen : 1}" />
		<c:set var="endPage" value="${page + paginationLen <= pagesCount ? page + paginationLen : pagesCount}" />

		<c:if test="${startPage > 1}">
			<a class="btn btn-sm" href="?page=1&teamName=${teamName}&position=${position}&name=${name}">1</a>
		</c:if>
		<c:if test="${startPage > 2}">
			<button class="btn btn-sm btn-disabled">...</button>
		</c:if>

		<c:forEach begin="${startPage}" end="${endPage}" var="i">
			<a class="btn btn-sm ${page == i ? 'btn-active' : ''}"
				href="?page=${i}&teamName=${teamName}&position=${position}&name=${name}">${i}</a>
		</c:forEach>

		<c:if test="${endPage < pagesCount - 1}">
			<button class="btn btn-sm btn-disabled">...</button>
		</c:if>

		<c:if test="${endPage < pagesCount}">
			<a class="btn btn-sm" href="?page=${pagesCount}&teamName=${teamName}&position=${position}&name=${name}">${pagesCount}</a>
		</c:if>
	</div>
</div>


<script>
const teamColors = {
	    'KIA': '#F6C7C7',
	    '삼성': '#C4D6FF',
	    'LG': '#E1B7F6',
	    '두산': '#F4D3A0',
	    'KT': '#C4E1F3',
	    'SSG': '#E0E0E0',
	    '롯데': '#F7C4C4',
	    '한화': '#F5B7B1',
	    'NC': '#C8E6C9',
	    '키움': '#B3E5FC'
	};

	// Handle search button click
	document.getElementById('search-button').addEventListener('click', function() {
	    var teamName = encodeURIComponent(document.getElementById('team-filter').value);
	    var position = encodeURIComponent(document.getElementById('position-filter').value);
	    var name = encodeURIComponent(document.getElementById('name-filter').value);
	    var page = 1;
	    
	    console.log(`teamName: ${teamName}, position: ${position}, name: ${name}`);

	    fetch(`/players?teamName=${teamName}&position=${position}&name=${name}`)
	        .then(response => response.json())
	        .then(data => {
	        	console.log('데이터 : ', data);
	            var tbody = document.getElementById('player-table-body');
	            tbody.innerHTML = ''; // 행 초기화
	         
	            data.forEach(player => {
	            	console.log('선수 데이터:', player);  // 개별 player 데이터 출력
	                var tr = document.createElement('tr');
	                
	                // 배경색이 구단컬러로 바뀌게 하는 코드
	                var teamColor = teamColors[player.teamName] || '#FFFFFF'; // 기본 배경색
	                
	                tr.innerHTML = `
	                    <td>${player.number || ''}</td>
	                    <td style="background-color: ${teamColor}; border:2px solid; border-radius:5px; color:white; padding:7px;">${player.teamName || ''}</td>
	                    <td>${player.name || ''}</td>
	                    <td>${player.position || ''}</td>
	                    <td>${player.birthDate || ''}</td>
	                    <td>${player.height}cm / ${player.weight}kg</td>
	                    <td>${player.career || ''}</td>
	                `;
	                
	                tbody.appendChild(tr);
	            });
	            document.querySelector('.point').textContent = data.length;
	        })
	        .catch(error => console.error('Error:', error));
	});
</script>

<%@ include file="../common/foot.jspf"%>