
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="WRITE"></c:set>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<!-- daisyUI -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.12.10/full.css" />
<%@ include file="../common/head.jspf"%>

<script type="text/javascript">
	function ArticleWrite__submit(form) {
		form.title.value = form.title.value.trim();

		if (form.title.value.length == 0) {
			alert('제목을 입력하세요.');
			return;
		}

		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();

		if (markdown.length == 0) {
			alert('내용을 입력하세요.');
			return;
		}
		
		$('#fileInput').attr('name', 'file__article__' + ${currentId} + '__extra__Img__1');

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
			<form onsubmit="ArticleWrite__submit(this); return false;" action="../article/doWrite" method="POST"
				enctype="multipart/form-data">
				<input type="hidden" name="body" />
				<input type="hidden" name=">${currentId }">

				<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
					<tbody>
						<tr>
							<th>닉네임</th>
							<td>
								<div style="margin-left:-10px;"class="input input-sm w-full max-w-xs">${rq.loginedMember.nickname }</div>
							</td>
						</tr>
						<tr>
							<th>게시판</th>
							<td>
								<select name="boardId">
									<option value="" selected disabled>게시판을 선택해주세요.</option>
									<option value="1">공지사항</option>
									<option value="2">자유게시판</option>
									<option value="3">질의응답</option>
								</select>
							</td>

						</tr>

						<tr>
							<th>제목</th>
							<td>
								<input class="input input-bordered input-sm w-full max-w-xs" name="title" autocomplete="off"
									type="text" placeholder="제목을 입력하세요."  maxlength="20"/>
							</td>
						</tr>
						<tr>
							<th>첨부 이미지</th>
							<td>
								<input id="fileInput" placeholder="이미지를 선택해주세요." type="file" />
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td style="text-align: center;">
								<div class="toast-ui-editor">
									<script type="text/x-template"></script>
								</div>
							</td>

						</tr>
						<tr>
							<th></th>
							<td style="text-align: center; margin-left: calc(50% - 250px);">
								<button class="btn-write">등록</button>
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
.btn-write {
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
