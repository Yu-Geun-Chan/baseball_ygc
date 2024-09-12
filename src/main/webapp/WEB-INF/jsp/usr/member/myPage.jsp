<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MYPAGE"></c:set>

<link rel="stylesheet" href="/resource/myPage.css" />

<!-- lodash debounce -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<%@ include file="../common/head.jspf"%>


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
			<div class="content-body">${rq.loginedMember.loginId }</div>
		</div>
		<div class="content-container">
			<div class="content-title">나의 댓글</div>
			<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
				<path fill="currentColor"
					d="M9 22a1 1 0 0 1-1-1v-3H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2h-6.1l-3.7 3.71c-.2.19-.45.29-.7.29zm1-6v3.08L13.08 16H20V4H4v12z" /></svg>
			<div class="content-body">${rq.loginedMember.name }</div>
		</div>
		<div class="content-container">
			<div class="content-title">나의 문의사항</div>
			<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 14 14">
					<path fill="currentColor" fill-rule="evenodd"
					d="M6.987 1.5A3.18 3.18 0 0 0 3.75 4.628V9a1 1 0 0 1-1 1H1.5A1.5 1.5 0 0 1 0 8.5v-2A1.5 1.5 0 0 1 1.5 5h.75v-.39A4.68 4.68 0 0 1 7 0a4.68 4.68 0 0 1 4.75 4.61V5h.75A1.5 1.5 0 0 1 14 6.5v2a1.5 1.5 0 0 1-1.5 1.5h-.75v.5a2.75 2.75 0 0 1-2.44 2.733A1.5 1.5 0 0 1 8 14H6.5a1.5 1.5 0 0 1 0-3H8c.542 0 1.017.287 1.28.718a1.25 1.25 0 0 0 .97-1.218V4.627A3.18 3.18 0 0 0 6.987 1.5"
					clip-rule="evenodd" /></svg>
			<div class="content-body">${rq.loginedMember.nickname }</div>
		</div>
		<div class="content-container">
			<div class="content-title">응원선수</div>
			<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
				<path fill="currentColor"
					d="m7.8 5.225l-1-3l1.4-.45l1 2.975zM11.25 4V1h1.5v3zm4.95 1.225l-1.4-.475l1-2.975l1.4.475zM21.875 23l-5.275-.8q-.85-.125-1.487-.687T14.2 20.15l-.85-2.65q-.275-.875-.025-1.737t.9-1.438l1.375 4.25l.9-.275l-2.2-6.95q-.325-1.025.063-2.012t1.312-1.513l1.25-.7l4.425 8.35q.125.25.363.388t.512.137h.725zM2.15 23l-1.075-7H1.8q.275 0 .513-.137t.362-.388L7.1 7.125l1.25.7q.925.525 1.313 1.513t.062 2.012L7.5 18.3l.9.275L9.775 14.3q.675.575.925 1.45t-.025 1.75l-.85 2.65q-.275.8-.912 1.363t-1.488.687z" /></svg>
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
		<div class="cheer-message-content">노시환 선수 V2를 향해 힘내주세요!</div>
		<svg class="mdi-heart" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
			<path fill="currentColor"
				d="m12 21.35l-1.45-1.32C5.4 15.36 2 12.27 2 8.5C2 5.41 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.08C13.09 3.81 14.76 3 16.5 3C19.58 3 22 5.41 22 8.5c0 3.77-3.4 6.86-8.55 11.53z" /></svg>
	</div>
	<div class="player-image-container">
		<img class="player-image" src="image-50.png" />
		<div class="player-info-container">
			<div class="player-info-contents contents-1">노시환</div>
			<div class="player-info-contents contents-2">한화</div>
			<div class="player-info-contents contents-3">내야수</div>
		</div>
	</div>
</div>





<%@ include file="../common/foot.jspf"%>