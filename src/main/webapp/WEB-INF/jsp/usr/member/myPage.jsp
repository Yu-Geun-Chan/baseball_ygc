<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MYPAGE"></c:set>

<link rel="stylesheet" href="/resource/myPage.css" />

<!-- lodash debounce -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<%@ include file="../common/head.jspf"%>

<div class="main-content">
	<div class="container">
		<div class="form-contents-container">
			<div class="content-container">
				<div class="icons-outline">
					<svg class="icons-outline-image" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 48 48">
					<g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="4">
					<circle cx="24" cy="11" r="7" />
					<path d="M4 41c0-8.837 8.059-16 18-16m9 17l10-10l-4-4l-10 10v4z" /></g></svg>
				</div>
				<div class="content-title">나의 회원 정보</div>
				<a href="../member/info" class="content-body">바로가기</a>
			</div>
			<div class="content-container">
				<div class="content-title">나의 게시글</div>
				<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
					<g fill="none" stroke="currentColor" stroke-width="1.5">
					<path
						d="M2.906 17.505L5.337 3.718a2 2 0 0 1 2.317-1.623L19.472 4.18a2 2 0 0 1 1.622 2.317l-2.431 13.787a2 2 0 0 1-2.317 1.623L4.528 19.822a2 2 0 0 1-1.622-2.317Z" />
					<path stroke-linecap="round" d="m8.929 6.382l7.879 1.389m-8.574 2.55l7.879 1.39M7.54 14.26l4.924.869" /></g></svg>
				<a class="content-body" href="../article/myList">바로가기</a>
			</div>
			<div class="content-container">
				<div class="content-title">응원선수 선택</div>
				<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
				<path fill="currentColor"
						d="m7.8 5.225l-1-3l1.4-.45l1 2.975zM11.25 4V1h1.5v3zm4.95 1.225l-1.4-.475l1-2.975l1.4.475zM21.875 23l-5.275-.8q-.85-.125-1.487-.687T14.2 20.15l-.85-2.65q-.275-.875-.025-1.737t.9-1.438l1.375 4.25l.9-.275l-2.2-6.95q-.325-1.025.063-2.012t1.312-1.513l1.25-.7l4.425 8.35q.125.25.363.388t.512.137h.725zM2.15 23l-1.075-7H1.8q.275 0 .513-.137t.362-.388L7.1 7.125l1.25.7q.925.525 1.313 1.513t.062 2.012L7.5 18.3l.9.275L9.775 14.3q.675.575.925 1.45t-.025 1.75l-.85 2.65q-.275.8-.912 1.363t-1.488.687z" /></svg>
				<input name="name" class="cheer-select" id="name-filter" placeholder="선수이름 입력">
				<input type="button" value="검색" class="btn_search" id="search-button">
				<input type="button" value="적용" class="btn_apply" id="apply-button">
				<button id="delete-cheer-button">삭제</button>
			</div>
		</div>
		<!-- 마이페이지라는 안내문구창 -->
		<div class="notice">
			<div class="notice-content">마이페이지</div>
		</div>
		<div class="btn-modify">
			<a href="javascript:history.back();" class="btn-modify-content">뒤로가기</a>
		</div>
		<div class="cheer-message">
			<div class="cheer-message-content" id="cheer-message-display">
				<span id="current-cheer-message" style="cursor: pointer;">응원메세지를 입력하세요.</span>
			</div>
			<input type="text" id="cheer-message-input" placeholder="응원 메시지를 입력하세요" style="display: none;">
			<button id="save-cheer-button" style="display: none;">저장</button>
			<div id="warning-message"></div>
			<!-- 경고 메시지가 표시될 영역 -->
			<svg class="mdi-heart" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
			<path fill="currentColor"
					d="m12 21.35l-1.45-1.32C5.4 15.36 2 12.27 2 8.5C2 5.41 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.08C13.09 3.81 14.76 3 16.5 3C19.58 3 22 5.41 22 8.5c0 3.77-3.4 6.86-8.55 11.53z" />
		</svg>
		</div>
		<!-- 응원선수 정보 -->
		<div class="cheer-player-info-container" style="display: none;">
			<img id="player-image" src="" alt="Player Image" style="width: 150px; height: auto;">
			<div class="cheer-player-info-contents contents-1" id="player-name"></div>
			<div class="cheer-player-info-contents contents-2" id="player-teamName"></div>
			<div class="cheer-player-info-contents contents-3" id="player-position"></div>
		</div>
	</div>
</div>


<!-- 응원선수 정보 -->
<script>
	$(document).ready(
			function() {
				// 각 구단 대표컬러
				const teamColors = {
					'KIA' : '#B31020',
					'삼성' : '0068B3',
					'LG' : '#BD0936',
					'두산' : '#070A32',
					'KT' : '#000000',
					'SSG' : '#F00014',
					'롯데' : '#DB042F',
					'한화' : '#F27222',
					'NC' : '#1D467A',
					'키움' : '#800121'
				};

				// 검색 버튼 클릭 시 AJAX 요청
				$('#search-button').on(
						'click',
						function(event) {
							event.preventDefault(); // 기본 폼 제출 방지
							const playerName = $('#name-filter').val();

							$.ajax({
								url : '/searchPlayer',
								type : 'GET',
								data : {
									name : playerName
								},
								success : function(data) {
									if (data) {
										console.log(data); // 응답 데이터 확인
										// 선수 정보 표시
										$('#player-name').text(data.name);
										const teamName = data.teamName; // 팀명 변수에 저장
										$('#player-teamName').text(teamName)
												.css(
														'color',
														teamColors[teamName]
																|| 'black'); // 색상 적용
										$('#player-position').text(
												data.position);
										$('#player-image').attr('src',
												data.profileImage); // 이미지 URL 설정
									} else {
										alert('선수를 찾을 수 없습니다.');
									}
								},
								error : function() {
									alert('검색 중 오류가 발생했습니다.');
								}
							});
						});

				// 적용 버튼 클릭 시 정보 저장
				$('#apply-button').on('click', function() {
					const playerName = $('#player-name').text();
					const playerTeam = $('#player-teamName').text();
					const playerPosition = $('#player-position').text();
					const playerImage = $('#player-image').attr('src'); // 이미지 URL 저장

					// localStorage에 저장
					localStorage.setItem('selectedPlayer', JSON.stringify({
						name : playerName,
						team : playerTeam,
						position : playerPosition,
						image : playerImage
					}));

					// 선수 정보 표시
					$('.cheer-player-info-container').show();
				});

				// 페이지 로드 시 localStorage에서 정보 로드
				const storedPlayer = localStorage.getItem('selectedPlayer');
				if (storedPlayer) {
					const playerInfo = JSON.parse(storedPlayer);
					$('#player-name').text(playerInfo.name);
					$('#player-teamName').text(playerInfo.team).css('color',
							teamColors[playerInfo.team] || 'black'); // 색상 적용
					$('#player-position').text(playerInfo.position);
					$('#player-image').attr('src', playerInfo.image); // 저장된 이미지 URL 설정
					$('.cheer-player-info-container').show();
				}
			});

	//응원 선수 지우기 버튼 클릭 시
	$('#delete-cheer-button').on('click', function() {
		// localStorage에서 선수 정보 삭제
		localStorage.removeItem('selectedPlayer');

		// 화면에서 선수 정보 지우기
		$('#player-name').text('');
		$('#player-teamName').text('');
		$('#player-position').text('');
		$('#player-image').attr('src', ''); // 이미지 초기화
		$('.cheer-player-info-container').hide();
	});
</script>

<!-- 응원메세지 저장 -->
<script>
	$(document).ready(function() {
		// 응원 메시지 클릭 시 입력 필드로 전환
		$('#cheer-message-display').on('click', function() {
			const currentMessage = $('#current-cheer-message').text();
			$('#cheer-message-input').val(currentMessage).show();
			$('#save-cheer-button').show();
			$(this).hide();
		});

		// 저장 버튼 클릭 시 메시지 저장
		$('#save-cheer-button').on('click', function() {
			const newMessage = $('#cheer-message-input').val();
			$('#current-cheer-message').text(newMessage);
			localStorage.setItem('cheerMessage', newMessage); // 메시지를 localStorage에 저장
			$('#cheer-message-input').hide();
			$(this).hide();
			$('#cheer-message-display').show();
		});

		// 페이지 로드 시 localStorage에서 메시지 로드
		const storedMessage = localStorage.getItem('cheerMessage');
		if (storedMessage) {
			$('#current-cheer-message').text(storedMessage);
		}
	});
</script>

<%@ include file="../common/foot.jspf"%>