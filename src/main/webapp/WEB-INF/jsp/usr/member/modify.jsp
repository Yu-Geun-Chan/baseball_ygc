<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER MODIFY"></c:set>


<!-- daisyUI -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.12.10/full.css" />
<link rel="stylesheet" href="/resource/memberModify.css" />

<%@ include file="../common/head.jspf"%>

<hr />

<script type="text/javascript">
	function MemberModify__submit(form) {
		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length > 0) {
			form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
			if (form.loginPwConfirm.value == 0) {
				alert('비밀번호 확인을 입력하세요.');
				return;
			}

			if (form.loginPwConfirm.value != form.loginPw.value) {
				alert('비밀번호가 일치하지 않습니다.');
				return;
			}

		}

		form.submit();
	}
</script>

<div class="main-content">
	<div class="container">
		<form onsubmit="MemberModify__submit(this); return false;" action="../member/doModify" method="POST">
			<div class="form-contents-container">
				<div class="content-container">
					<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
				<path fill="currentColor"
							d="M12 14q-.425 0-.712-.288T11 13t.288-.712T12 12t.713.288T13 13t-.288.713T12 14m-4 0q-.425 0-.712-.288T7 13t.288-.712T8 12t.713.288T9 13t-.288.713T8 14m8 0q-.425 0-.712-.288T15 13t.288-.712T16 12t.713.288T17 13t-.288.713T16 14m-4 4q-.425 0-.712-.288T11 17t.288-.712T12 16t.713.288T13 17t-.288.713T12 18m-4 0q-.425 0-.712-.288T7 17t.288-.712T8 16t.713.288T9 17t-.288.713T8 18m8 0q-.425 0-.712-.288T15 17t.288-.712T16 16t.713.288T17 17t-.288.713T16 18M5 22q-.825 0-1.412-.587T3 20V6q0-.825.588-1.412T5 4h1V2h2v2h8V2h2v2h1q.825 0 1.413.588T21 6v14q0 .825-.587 1.413T19 22zm0-2h14V10H5z" /></svg>
					<div class="content-title">가입일</div>
					<div class="content-body-regDate">${rq.loginedMember.regDate }</div>
				</div>
				<div class="content-container">
					<div class="content-title">아이디</div>
					<div class="icons-outline">
						<svg class="icons-outline-image" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 48 48">
					<g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="4">
					<circle cx="24" cy="11" r="7" />
					<path d="M4 41c0-8.837 8.059-16 18-16m9 17l10-10l-4-4l-10 10v4z" /></g></svg>
					</div>
					<div class="content-body-id">${rq.loginedMember.loginId }</div>
				</div>
				<div class="content-container">
					<div class="content-title">새 비밀번호</div>
					<div class="icons-outline">
						<svg class="icons-outline-image" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
					<path fill="currentColor"
								d="M12 17a2 2 0 0 1-2-2c0-1.11.89-2 2-2a2 2 0 0 1 2 2a2 2 0 0 1-2 2m6 3V10H6v10zm0-12a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V10c0-1.11.89-2 2-2h1V6a5 5 0 0 1 5-5a5 5 0 0 1 5 5v2zm-6-5a3 3 0 0 0-3 3v2h6V6a3 3 0 0 0-3-3" /></svg>
					</div>
					<input class="content-body input" name="loginPw" autocomplete="off" type="text" placeholder="새 비밀번호를 입력하세요." />
				</div>
				<div class="content-container">
					<div class="content-title">새 비밀번호 확인</div>
					<div class="icons-outline">
						<svg class="icons-outline-image" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
							<path
								d="M256 48a208 208 0 1 1 0 416 208 208 0 1 1 0-416zm0 464A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209c9.4-9.4 9.4-24.6 0-33.9s-24.6-9.4-33.9 0l-111 111-47-47c-9.4-9.4-24.6-9.4-33.9 0s-9.4 24.6 0 33.9l64 64c9.4 9.4 24.6 9.4 33.9 0L369 209z" /></svg>
					</div>
					<input class="content-body input" name="loginPwConfirm" autocomplete="off" type="text" placeholder="새 비밀번호를 입력하세요." />
				</div>
				<div class="content-container">
					<div class="content-title">이름</div>
					<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
					<path fill="currentColor"
							d="M12 4a4 4 0 0 1 4 4a4 4 0 0 1-4 4a4 4 0 0 1-4-4a4 4 0 0 1 4-4m0 2a2 2 0 0 0-2 2a2 2 0 0 0 2 2a2 2 0 0 0 2-2a2 2 0 0 0-2-2m0 7c2.67 0 8 1.33 8 4v3H4v-3c0-2.67 5.33-4 8-4m0 1.9c-2.97 0-6.1 1.46-6.1 2.1v1.1h12.2V17c0-.64-3.13-2.1-6.1-2.1" /></svg>
					<input class="content-body input" name="name" autocomplete="off" type="text" placeholder="이름을 입력하세요."
						value="${rq.loginedMember.name }" />
				</div>
				<div class="content-container">
					<div class="content-title">닉네임</div>
					<div class="icons-outline">
						<svg class="icons-outline-image" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 48 48">
					<g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="4">
					<circle cx="24" cy="11" r="7" />
					<path d="M4 41c0-8.837 8.059-16 18-16m9 17l10-10l-4-4l-10 10v4z" /></g></svg>
					</div>
					<input class="content-body input" name="nickname" autocomplete="off" type="text" placeholder="닉네임을 입력하세요."
						value="${rq.loginedMember.nickname }" />
				</div>
				<div class="content-container">
					<div class="content-title">전화번호</div>
					<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 256 256">
					<path fill="currentColor"
							d="M231.88 175.08A56.26 56.26 0 0 1 176 224C96.6 224 32 159.4 32 80a56.26 56.26 0 0 1 48.92-55.88a16 16 0 0 1 16.62 9.52l21.12 47.15v.12A16 16 0 0 1 117.39 96c-.18.27-.37.52-.57.77L96 121.45c7.49 15.22 23.41 31 38.83 38.51l24.34-20.71a8 8 0 0 1 .75-.56a16 16 0 0 1 15.17-1.4l.13.06l47.11 21.11a16 16 0 0 1 9.55 16.62" /></svg>
					<input class="content-body input" name="cellphoneNum" autocomplete="off" type="text" placeholder="전화번호를 입력하세요."
						value="${rq.loginedMember.cellphoneNum }" />
				</div>
				<div class="content-container">
					<div class="content-title">이메일</div>
					<svg class="icons" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24">
					<path fill="currentColor"
							d="M22 6c0-1.1-.9-2-2-2H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2zm-2 0l-8 5l-8-5zm0 12H4V8l8 5l8-5z" /></svg>
					<input class="content-body input" name="email" autocomplete="off" type="text" placeholder="이메일을 입력하세요."
						value="${rq.loginedMember.email }" />
				</div>
				<div class="btn-join">
					<button style="border: none;" type="submit" class="btn-join-content">수정</button>
				</div>
			</div>
		</form>
		<!-- 회원정보라는 안내문구창 -->
		<div class="notice">
			<div class="notice-content">회원정보</div>
		</div>
		<div class="btns btns-back">
			<a href="javascript:history.back();" class="btns-content">뒤로가기</a>
		</div>
	</div>
</div>

<section class="mt-24 text-xl px-4">
	<div class="mx-auto">
		<form onsubmit="MemberModify__submit(this); return false;" action="../member/doModify" method="POST">
			<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
				<tbody>
					<tr>
						<th>가입일</th>
						<td style="text-align: center;">${rq.loginedMember.regDate }</td>

					</tr>
					<tr>
						<th>아이디</th>
						<td style="text-align: center;">${rq.loginedMember.loginId }</td>

					</tr>
					<tr>
						<th>새 비밀번호</th>
						<td style="text-align: center;">
							<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="loginPw" autocomplete="off"
								type="text" placeholder="새 비밀번호를 입력하세요." />
						</td>
					</tr>
					<tr>
						<th>새 비밀번호 확인</th>
						<td style="text-align: center;">
							<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="loginPwConfirm"
								autocomplete="off" type="text" placeholder="새 비밀번호확인을 입력하세요." />
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td style="text-align: center;">
							<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="name" autocomplete="off"
								type="text" placeholder="이름을 입력하세요." value="${rq.loginedMember.name }" />
						</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td style="text-align: center;">
							<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="nickname" autocomplete="off"
								type="text" placeholder="닉네임을 입력하세요." value="${rq.loginedMember.nickname }" />
						</td>

					</tr>
					<tr>
						<th>이메일</th>
						<td style="text-align: center;">
							<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="email" autocomplete="off"
								type="text" placeholder="이메일을 입력하세요." value="${rq.loginedMember.email }" />
						</td>

					</tr>
					<tr>
						<th>전화번호</th>
						<td style="text-align: center;">
							<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="cellphoneNum" autocomplete="off"
								type="text" placeholder="전화번호를 입력하세요." value="${rq.loginedMember.cellphoneNum }" />
						</td>
					</tr>
					<tr>
						<th></th>
						<td style="text-align: center;">
							<button class="btn btn-primary">수정</button>
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

<%@ include file="../common/foot.jspf"%>