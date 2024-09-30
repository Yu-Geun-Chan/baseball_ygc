<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER INFO"></c:set>

<link rel="stylesheet" href="/resource/memberInfo.css" />

<!-- lodash debounce -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<%@ include file="../common/head.jspf"%>

<div class="main-content">
	<div class="container">
		<div class="form-contents-container">
			<div class="content-container">
				<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
				<path fill="currentColor"
						d="M12 14q-.425 0-.712-.288T11 13t.288-.712T12 12t.713.288T13 13t-.288.713T12 14m-4 0q-.425 0-.712-.288T7 13t.288-.712T8 12t.713.288T9 13t-.288.713T8 14m8 0q-.425 0-.712-.288T15 13t.288-.712T16 12t.713.288T17 13t-.288.713T16 14m-4 4q-.425 0-.712-.288T11 17t.288-.712T12 16t.713.288T13 17t-.288.713T12 18m-4 0q-.425 0-.712-.288T7 17t.288-.712T8 16t.713.288T9 17t-.288.713T8 18m8 0q-.425 0-.712-.288T15 17t.288-.712T16 16t.713.288T17 17t-.288.713T16 18M5 22q-.825 0-1.412-.587T3 20V6q0-.825.588-1.412T5 4h1V2h2v2h8V2h2v2h1q.825 0 1.413.588T21 6v14q0 .825-.587 1.413T19 22zm0-2h14V10H5z" /></svg>
				<div class="content-title">가입일</div>
				<div class="content-body">${rq.loginedMember.regDate }</div>
			</div>
			<div class="content-container">
				<div class="content-title">아이디</div>
				<div class="icons-outline">
					<svg class="icons-outline-image" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 48 48">
					<g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="4">
					<circle cx="24" cy="11" r="7" />
					<path d="M4 41c0-8.837 8.059-16 18-16m9 17l10-10l-4-4l-10 10v4z" /></g></svg>
				</div>
				<div class="content-body">${rq.loginedMember.loginId }</div>
			</div>
			<div class="content-container">
				<div class="content-title">이름</div>
				<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
					<path fill="currentColor"
						d="M12 4a4 4 0 0 1 4 4a4 4 0 0 1-4 4a4 4 0 0 1-4-4a4 4 0 0 1 4-4m0 2a2 2 0 0 0-2 2a2 2 0 0 0 2 2a2 2 0 0 0 2-2a2 2 0 0 0-2-2m0 7c2.67 0 8 1.33 8 4v3H4v-3c0-2.67 5.33-4 8-4m0 1.9c-2.97 0-6.1 1.46-6.1 2.1v1.1h12.2V17c0-.64-3.13-2.1-6.1-2.1" /></svg>
				<div class="content-body">${rq.loginedMember.name }</div>
			</div>
			<div class="content-container">
				<div class="content-title">닉네임</div>
				<div class="icons-outline">
					<svg class="icons-outline-image" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 48 48">
					<g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="4">
					<circle cx="24" cy="11" r="7" />
					<path d="M4 41c0-8.837 8.059-16 18-16m9 17l10-10l-4-4l-10 10v4z" /></g></svg>
				</div>
				<div class="content-body">${rq.loginedMember.nickname }</div>
			</div>
			<div class="content-container">
				<div class="content-title">전화번호</div>
				<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 256 256">
					<path fill="currentColor"
						d="M231.88 175.08A56.26 56.26 0 0 1 176 224C96.6 224 32 159.4 32 80a56.26 56.26 0 0 1 48.92-55.88a16 16 0 0 1 16.62 9.52l21.12 47.15v.12A16 16 0 0 1 117.39 96c-.18.27-.37.52-.57.77L96 121.45c7.49 15.22 23.41 31 38.83 38.51l24.34-20.71a8 8 0 0 1 .75-.56a16 16 0 0 1 15.17-1.4l.13.06l47.11 21.11a16 16 0 0 1 9.55 16.62" /></svg>
				<div class="content-body">${rq.loginedMember.cellphoneNum }</div>
			</div>
			<div class="content-container">
				<div class="content-title">이메일</div>
				<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
					<path fill="currentColor"
						d="M22 6c0-1.1-.9-2-2-2H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2zm-2 0l-8 5l-8-5zm0 12H4V8l8 5l8-5z" /></svg>
				<div class="content-body">${rq.loginedMember.email }</div>
			</div>
		</div>
		<!-- 회원정보라는 안내문구창 -->
		<div class="notice">
			<div class="notice-content">회원정보</div>
		</div>
		<div class="btns btns-leave">
			<a href="../member/doDelete" class="btns-content">회원탈퇴</a>
		</div>
		<div class="btns btns-back">
			<a href="javascript:history.back();" class="btns-content">뒤로가기</a>
		</div>
		<div class="btn-myPage">
			<a href="../member/myPage" class="btn-myPage-content">마이페이지로 이동</a>
		</div>
		<div class="btn-modify">
			<a href="../member/checkPw" class="btn-modify-content">내 정보 수정</a>
		</div>
	</div>
</div>





<%@ include file="../common/foot.jspf"%>