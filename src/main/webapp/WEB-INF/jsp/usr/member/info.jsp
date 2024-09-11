<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER INFO"></c:set>

<link rel="stylesheet" href="/resource/memberInfo.css" />

<!-- lodash debounce -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<%@ include file="../common/head.jspf"%>

<div class="container">
	<div class="form-contents-container">
		<div class="content-container">
			<img class="material-symbols-calendar-month" src="material-symbols-calendar-month0.svg" />
			<div class="content-title">가입일</div>
			<div class="_2024-08-30">${rq.loginedMember.regDate }</div>
		</div>
		<div class="content-container">
			<div class="content-title">아이디</div>
			<div class="icon-park-outline-edit-name">
				<img class="group" src="group0.svg" />
			</div>
			<div class="test-1">${rq.loginedMember.loginId }</div>
		</div>
		<div class="content-container">
			<div class="content-title">이름</div>
			<img class="icons-outline" src="mdi-user-outline0.svg" />
			<div class="div6">${rq.loginedMember.name }</div>
		</div>
		<div class="content-container">
			<div class="content-title">닉네임</div>
			<div class="icon-park-outline-edit-name2">
				<img class="group2" src="group1.svg" />
			</div>
			<div class="test-1">${rq.loginedMember.nickname }</div>
		</div>
		<div class="content-container">
			<div class="content-title">전화번호</div>
			<img class="ph-phone-fill" src="ph-phone-fill0.svg" />
			<div class="_010-1234-5678">${rq.loginedMember.cellphoneNum }</div>
		</div>
		<div class="content-container">
			<div class="content-title">이메일</div>
			<img class="icons-outline" src="ic-outline-email0.svg" />
			<div class="abc-naver-com">${rq.loginedMember.email }</div>
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
		<a href="../member/myPage" class="btn-myPage-content" href="#">마이페이지로 이동</a>
	</div>
	<div class="btn-modify">
		<a href ="../member/checkPw" class="btn-modify-content">내 정보 수정</a>
	</div>
</div>





<%@ include file="../common/foot.jspf"%>