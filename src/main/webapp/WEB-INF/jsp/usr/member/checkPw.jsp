<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="CHECKPW"></c:set>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<%@ include file="../common/head.jspf"%>
<!-- daisyUI -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.12.10/full.css" />
<link rel="stylesheet" href="/resource/findLoginPw.css" />
<hr />

<div class="main-content">
	<div class="form-container">
		<form action="../member/doCheckPw" method="POST">
			<div class="form-contents-container">
				<div class="content-container">
					<div class="input">${rq.loginedMember.loginId }</div>
					<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
						<path fill="currentColor"
							d="M12 4a4 4 0 0 1 4 4a4 4 0 0 1-4 4a4 4 0 0 1-4-4a4 4 0 0 1 4-4m0 2a2 2 0 0 0-2 2a2 2 0 0 0 2 2a2 2 0 0 0 2-2a2 2 0 0 0-2-2m0 7c2.67 0 8 1.33 8 4v3H4v-3c0-2.67 5.33-4 8-4m0 1.9c-2.97 0-6.1 1.46-6.1 2.1v1.1h12.2V17c0-.64-3.13-2.1-6.1-2.1" /></svg>
				</div>
				<div class="content-container">
					<input class="input" type="text" name="loginPw" autocomplete="off" placeholder="비밀번호를 입력해주세요." />
					<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
					<path fill="currentColor"
							d="M12 17a2 2 0 0 1-2-2c0-1.11.89-2 2-2a2 2 0 0 1 2 2a2 2 0 0 1-2 2m6 3V10H6v10zm0-12a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V10c0-1.11.89-2 2-2h1V6a5 5 0 0 1 5-5a5 5 0 0 1 5 5v2zm-6-5a3 3 0 0 0-3 3v2h6V6a3 3 0 0 0-3-3" /></svg>
				</div>

				<div class="btn-login">
					<button style="border: none;" type="submit" class="btn-login-content">확인</button>
				</div>
			</div>
		</form>
		<!-- 비밀번호 찾기라는 안내문구창 -->
		<div class="notice">
			<div class="notice-content">비밀번호 확인</div>
		</div>
		<div class="btns btns-back">
			<a href="javascript:history.back();" class="btns-content">뒤로가기</a>
		</div>
	</div>
</div>

<div class="main-content">
	<section class="mt-24 text-xl px-4">
		<div class="mx-auto">
			<form action="../member/doCheckPw" method="POST">
				<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
					<tbody>
						<tr>
							<th>아이디</th>
							<td style="text-align: center;">${rq.loginedMember.loginId }</td>

						</tr>
						<tr>
							<th>비밀번호</th>
							<td style="text-align: center;">
								<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="loginPw" autocomplete="off"
									type="text" placeholder="비밀번호를 입력해" />
							</td>

						</tr>
						<tr>
							<th></th>
							<td style="text-align: center;">
								<button type="submit" class="btn btn-primary">확인</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<div class="btns">
				<button class="btn" type="button" onclick="history.back()">뒤로가기</button>
			</div>
		</div>
	</section>
</div>

<%@ include file="../common/foot.jspf"%>