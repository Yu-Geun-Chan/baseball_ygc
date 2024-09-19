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
	<!-- 동적 페이징 -->
	<div id="pagination-controls" class="pagination"></div>
</div>

<script>
    var totalPages = 1; // 초기값은 1로 설정
    var currentPage = 1;
    
    function renderPagination() {
        const paginationControls = $('#pagination-controls');
        paginationControls.empty(); // 기존 버튼 제거

        if (totalPages <= 1) return; // 페이지가 1개 이하일 경우 버튼을 표시하지 않음

        // 첫 페이지 버튼
        if (currentPage > 1) {
            paginationControls.append(`<a class="btn btn-sm" onclick="goToPage(1)">1</a>`);
        }

        // 이전 페이지 버튼
        if (currentPage > 1) {
            paginationControls.append(`<a class="btn btn-sm" onclick="goToPage(${currentPage - 1})">이전</a>`);
        }

        // 페이지 버튼
        const startPage = Math.max(1, currentPage - 3);
        const endPage = Math.min(totalPages, currentPage + 3);
        console.log(`페이지 버튼 범위 : startPage=${startPage}, endPage=${endPage}`);
        for (let i = startPage; i <= endPage; i++) {
            paginationControls.append(`
                <a class="btn btn-sm ${i == currentPage ? 'btn-active' : ''}" onclick="goToPage(${i})">${i}</a>
            `);
        }

        // 다음 페이지 버튼
        if (currentPage < totalPages) {
            paginationControls.append(`<a class="btn btn-sm" onclick="goToPage(${currentPage - 1})">다음</a>`);
        }

        // 마지막 페이지 버튼
        if (currentPage < totalPages) {
            paginationControls.append(`<a class="btn btn-sm" onclick="goToPage(${totalPages})">${totalPages}</a>`);
        }
    }

    function goToPage(page) {
        if (page < 1 || page > totalPages) return; // 페이지 범위를 벗어나면 무시
        console.log(`현재 페이지 : ${page}`);
        currentPage = page;
        sendAjaxRequest(); // 페이지 변경 시 AJAX 요청
    }

    function updatePagination(newTotalPages, page) {
    	console.log(`업데이트 페이지네이션: newTotalPages=${newTotalPages}, newPage=${page}`);
        totalPages = newTotalPages;
        currentPage = page; // 현재 페이지 업데이트
        renderPagination(); // 페이지네이션 버튼 업데이트
    }

    <!-- 선수정보  -->
    // 각 구단 대표컬러
    const teamColors = {
            'KIA': '#B31020',
            '삼성': '0068B3',
            'LG': '#BD0936',
            '두산': '#070A32',
            'KT': '#000000',
            'SSG': '#F00014',
            '롯데': '#DB042F',
            '한화': '#F27222',
            'NC': '#1D467A',
            '키움': '#800121'
        };
    
    function sendAjaxRequest() {
        // 각 필드 값을 가져옴
        var teamName = $('#team-filter').val();
        var position = $('#position-filter').val();
        var name = $('#name-filter').val();

        console.log('AJAX 요청 - currentPage :', currentPage, 'teamName:', teamName, 'position:', position, 'name:', name);

        $.ajax({
            type: 'GET',
            url: '/players',
            data: {
                page: currentPage,   // 현재 페이지	
                teamName: teamName,  // 팀 이름 값
                position: position,  // 포지션 값
                name: name           // 선수 이름 값
            },
            success: function(response) {
                console.log('서버 응답:', response);

                var tbody = $('#player-table-body');
                tbody.empty(); // 기존 행 초기화

                response.players.forEach(function(player) {
                	
                    var teamColor = teamColors[player.teamName] || '#FFFFFF';
                    var tr = $('<tr></tr>');

                    var numberCell = $('<td></td>').text(player.number || '');
                    var teamNameCell = $('<td></td>').text(player.teamName || '');
                    // 구단명에 따른 배경색 설정
                    teamNameCell.css({
                        'background-color': teamColor,
                        'border': '2px solid',
                        'border-radius': '5px',
                        'padding': '7px',
                        'color': '#FFFFFF'
                    });
                    var nameCell = $('<td></td>').text(player.name || '');
                    var positionCell = $('<td></td>').text(player.position || '');
                    var birthDateCell = $('<td></td>').text(player.birthDate || '');
                    var physiqueCell = $('<td></td>').text(player.height +'cm / ' + player.weight +'kg');
                    var weightCell = $('<td></td>').text(player.weight || '');
                    var careerCell = $('<td></td>').text(player.career || '');

                    // 테이블 행 생성
                    tr.append(numberCell)
                      .append(teamNameCell)
                      .append(nameCell)
                      .append(positionCell)
                      .append(birthDateCell)
                      .append(physiqueCell)
                      .append(careerCell);

                    tbody.append(tr); // 테이블에 추가
                });
               
                $('.point').text(response.playersCount); // 검색 결과 업데이트
                updatePagination(response.totalPages, response.currentPage); // 페이지네이션 업데이트
                console.log('currentPage : '+ response.currentPage);
                console.log('totalPages : '+ response.totalPages);
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청 실패:', status, error);
            }
        });
    }

    // 폼의 submit 이벤트를 막고 AJAX 요청을 보내도록 수정
    $('#search-form').on('submit', function (event) {
        event.preventDefault(); // 폼 제출 기본 동작 방지
        sendAjaxRequest(); // AJAX 요청 보내기
    });
    
    $('#team-filter').on('change', function() {
        currentPage = 1; // 검색 시 첫 페이지로 이동
        sendAjaxRequest();
    });

    $('#position-filter').on('change', function() {
        currentPage = 1; // 검색 시 첫 페이지로 이동
        sendAjaxRequest();
    });

    $('#name-filter').on('input', function() {
        currentPage = 1; // 검색 시 첫 페이지로 이동
        sendAjaxRequest();
    });
</script>


<%@ include file="../common/foot.jspf"%>