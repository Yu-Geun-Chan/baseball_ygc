<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LOGIN"></c:set>

<!-- lodash debounce -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<%@ include file="../common/head.jspf"%>
<!-- daisyUI -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.12.10/full.css" />
<link rel="stylesheet" href="/resource/login.css" />

<div class="main-content">
	<div class="form-container">
		<form action="../member/doLogin" method="POST">
			<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri }" />
			<div class="form-contents-container">
				<div class="content-container">
					<input style="border: none" class="input" type="text" name="loginId" autocomplete="off" placeholder="아이디를 입력해주세요." />
					<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
						<path fill="currentColor"
							d="M12 4a4 4 0 0 1 4 4a4 4 0 0 1-4 4a4 4 0 0 1-4-4a4 4 0 0 1 4-4m0 2a2 2 0 0 0-2 2a2 2 0 0 0 2 2a2 2 0 0 0 2-2a2 2 0 0 0-2-2m0 7c2.67 0 8 1.33 8 4v3H4v-3c0-2.67 5.33-4 8-4m0 1.9c-2.97 0-6.1 1.46-6.1 2.1v1.1h12.2V17c0-.64-3.13-2.1-6.1-2.1" /></svg>
				</div>
				<div class="content-container">
					<input style="border: none" class="input" type="text" name="loginPw" autocomplete="off" placeholder="비밀번호를 입력해주세요." />
					<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
					<path fill="currentColor"
							d="M12 17a2 2 0 0 1-2-2c0-1.11.89-2 2-2a2 2 0 0 1 2 2a2 2 0 0 1-2 2m6 3V10H6v10zm0-12a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V10c0-1.11.89-2 2-2h1V6a5 5 0 0 1 5-5a5 5 0 0 1 5 5v2zm-6-5a3 3 0 0 0-3 3v2h6V6a3 3 0 0 0-3-3" /></svg>
				</div>

				<div class="btn-login">
					<button style="border: none;" type="submit" class="btn-login-content">로그인</button>
				</div>
			</div>
		</form>
		<!-- 로그인이라는 안내문구창 -->
		<div class="notice">
			<div class="notice-content">로그인</div>
		</div>
		<div class="btns btns-join">
			<a href="../member/join" class="btns-content">회원가입</a>
		</div>
		<div class="btns btns-back">
			<a href="javascript:history.back();" class="btns-content">뒤로가기</a>
		</div>
	</div>
	<div class="find-btns-container">
		<a class="find-btns find-btns-id" href="${rq.findLoginIdUri }">아이디 찾기</a>
		<a class="find-btns find-btns-pw" href="${rq.findLoginPwUri }">비밀번호찾기</a>
	</div>
</div>

<%@ include file="../common/foot.jspf"%>