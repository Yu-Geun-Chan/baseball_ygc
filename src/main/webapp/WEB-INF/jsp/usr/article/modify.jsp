<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MODIFY"></c:set>

<%@ include file="../common/toastUiEditorLib.jspf"%>

<!-- daisyUI -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.12.10/full.css" />

<link rel="stylesheet" href="/resource/common.css" />
<link rel="stylesheet" href="/resource/articleModify.css" />

<%@ include file="../common/head.jspf"%>

<script type="text/javascript">
	function ArticleModify__submit(form) {

		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요');
			return;
		}
		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();
		if (markdown.length == 0) {
			alert('내용을 입력해주세요.');
			editor.focus();
			return;
		}
		form.body.value = markdown;

		form.submit();
	}
</script>

<div class="main-content">
	<div class="main-title">
		<h1 class="main-title-content">게시글 수정</h1>
	</div>
	<div class="write-container">
		<form onsubmit="ArticleModify__submit(this); return false;" action="../article/doModify" method="POST"
			enctype="multipart/form-data">
			<input type="hidden" name="id" value="${article.id}" />
			<input type="hidden" name="body">

			<div style="margin-bottom: 20px;">
				닉네임
				<span style="margin-left: 20px;">${rq.loginedMember.nickname }</span>
			</div>

			<div style="margin-bottom: 20px;">
				게시판
				<select class="input input-bordered input-sm w-full max-w-xs" style="margin-left: 15px;" name="boardId">
					<option value="" selected disabled>게시판을 선택해주세요.</option>
					<option value="1">공지사항</option>
					<option value="2">자유게시판</option>
					<option value="3">질의응답</option>
				</select>
			</div>
			<div style="margin-bottom: 20px;">
				제목
				<input class="input input-bordered input-sm w-full" style="margin-left: 29px; width: 800px;" name="title"
					autocomplete="off" type="text" placeholder="제목을 입력하세요." value="${article.title}" maxlength="20" />
			</div>
			<div>
				내용
				<div style="text-align: center; display: inline-block;">
					<div class="toast-ui-editor">
						<script type="text/x-template">${article.body }</script>
					</div>
				</div>
			</div>
			<div></div>
			<div style="text-align: center; margin-top: 20px;">
				<button class="btn-write">수정</button>
				<button class="btn-back" type="button" onclick="history.back()">뒤로가기</button>
			</div>
		</form>
	</div>
</div>

<%@ include file="../common/foot.jspf"%>