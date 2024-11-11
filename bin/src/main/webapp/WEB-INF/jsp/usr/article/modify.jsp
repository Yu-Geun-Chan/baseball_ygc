<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MODIFY"></c:set>

<%@ include file="../common/toastUiEditorLib.jspf"%>

<!-- daisyUI -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.12.10/full.css" />

<%@ include file="../common/head.jspf"%>
<hr />

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
			alert('내용 써');
			editor.focus();
			return;
		}
		form.body.value = markdown;

		form.submit();
	}
</script>

<div class="main-title">
	<div class="main-title-content">글쓰기</div>
</div>

<div class="main-content">
	<section class="mt-24 text-xl px-4">
		<div class="mx-auto">
			<form onsubmit="ArticleModify__submit(this); return false;" action="../article/doModify" method="POST"
				enctype="multipart/form-data">
				<input type="hidden" name="id" value="${article.id}" />
				<input type="hidden" name="body">

				<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
					<tbody>
						<tr>
							<th>번호</th>
							<td>
								<div style="margin-left: -10px;" class="input input-sm w-full max-w-xs">${article.id }</div>
							</td>
						</tr>
						<tr>
							<th>작성날짜</th>
							<td>
								<div style="margin-left: -10px;" class="input input-sm w-full max-w-xs">${article.regDate }</div>
							</td>

						</tr>
						<tr>
							<th>수정날짜</th>
							<td>
								<div style="margin-left: -10px;" class="input input-sm w-full max-w-xs">${article.updateDate }</div>
							</td>

						</tr>

						<tr>
							<th>제목</th>
							<td>
								<input class="input input-bordered input-sm w-full max-w-xs" value="${article.title}" name="title"
									autocomplete="off" type="text" placeholder="제목을 입력하세요." maxlength="20" />
							</td>
						</tr>
						<tr>
							<th>첨부 이미지</th>
							<td>
								<input id="fileInput" placeholder="이미지를 선택해주세요." type="file" value="${genfile.originFileName }"/>
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td style="text-align: center;">
								<div class="toast-ui-editor">
									<script type="text/x-template">${article.body }</script>
								</div>
							</td>

						</tr>
						<tr>
							<th></th>
							<td style="text-align: center; margin-left: calc(50% - 250px);">
								<button class="btn-modify">수정</button>
								<button class="btn-back" type="button" onclick="history.back()">뒤로가기</button>

							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</section>
</div>

<style>
.btn-modify {
	border: 1px solid #e1e1e1;
	border-radius: 5px;
	width: 70px;
	height: 40px;
	color: 444444;
	background: #e1e1e1;
}

.btn-back {
	border: 0px;
	color: 999999;
	width: 120px;
	height: 40px;
	line-height: 40px;
	text-align: center;
	font-size: 16px;
	margin-left: calc(50%);
}
</style>

<%@ include file="../common/foot.jspf"%>