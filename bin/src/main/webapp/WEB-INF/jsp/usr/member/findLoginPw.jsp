<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LOGIN"></c:set>

<%@ include file="../common/toastUiEditorLib.jspf"%>
<%@ include file="../common/head.jspf"%>
<!-- daisyUI -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.12.10/full.css" />
<link rel="stylesheet" href="/resource/findLoginPw.css" />

<script type="text/javascript">
	let MemberFindLoginPw__submitFormDone = false;
	function MemberFindLoginPw__submit(form) {
		if (MemberFindLoginPw__submitFormDone) {
			return;
		}
		form.loginId.value = form.loginId.value.trim();
		form.email.value = form.email.value.trim();
		if (form.loginId.value.length == 0) {
			alert('아이디를 입력하세요.');
			form.loginId.focus();
			return;
		}
		if (form.email.value.length == 0) {
			alert('이메일을 입력하세요.');
			form.email.focus();
			return;
		}
		MemberFindLoginPw__submitFormDone = true;
		alert('메일로 임시 비밀번호를 발송했습니다');
		form.submit();
	}
</script>

<div class="main-content">
	<div class="form-container">
		<form action="../member/doFindLoginPw" method="POST" onsubmit="MemberFindLoginPw__submit(this);">
			<input type="hidden" name="afterFindLoginPwUri" value="${param.afterFindLoginPwUri  }" />
			<div class="form-contents-container">
				<div class="content-container">
					<input style="border: none" class="input" type="text" name="loginId" autocomplete="off" placeholder="아이디를 입력해주세요." />
					<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
						<path fill="currentColor"
							d="M12 4a4 4 0 0 1 4 4a4 4 0 0 1-4 4a4 4 0 0 1-4-4a4 4 0 0 1 4-4m0 2a2 2 0 0 0-2 2a2 2 0 0 0 2 2a2 2 0 0 0 2-2a2 2 0 0 0-2-2m0 7c2.67 0 8 1.33 8 4v3H4v-3c0-2.67 5.33-4 8-4m0 1.9c-2.97 0-6.1 1.46-6.1 2.1v1.1h12.2V17c0-.64-3.13-2.1-6.1-2.1" /></svg>
				</div>
				<div class="content-container">
					<input style="border: none" class="input" type="text" name="email" autocomplete="off" placeholder="이메일을 입력해주세요." />
					<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
					<path fill="currentColor"
							d="M22 6c0-1.1-.9-2-2-2H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2zm-2 0l-8 5l-8-5zm0 12H4V8l8 5l8-5z" /></svg>
				</div>

				<div class="btn-login">
					<button style="border: none;" type="submit" class="btn-login-content">비밀번호 찾기</button>
				</div>
			</div>
		</form>
		<!-- 비밀번호 찾기라는 안내문구창 -->
		<div class="notice">
			<div class="notice-content">비밀번호 찾기</div>
		</div>
		<div class="btns btns-back">
			<a href="javascript:history.back();" class="btns-content">뒤로가기</a>
		</div>
	</div>
	<div class="find-btns-container">
		<a class="find-btns find-btns-id" href="../member/login">로그인</a>
	</div>
</div>

<%@ include file="../common/foot.jspf"%>