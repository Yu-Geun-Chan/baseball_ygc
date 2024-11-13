<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ASK"></c:set>

<!-- daisyUI -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.12.10/full.css" />

<link rel="stylesheet" href="/resource/common.css" />
<link rel="stylesheet" href="/resource/ask.css" />

<%@ include file="../common/head.jspf"%>

<iframe name="frAttachFiles" style="display: none;"></iframe>

<div class="main-content">
	<div class="main-title">
		<h1 class="main-title-content">문의사항</h1>
	</div>
	<div class="write-container">
		<form role="form" method="POST"
			action="https://script.google.com/macros/s/AKfycbwFXIwPbVDjesLF6m9cpf0PjLcFsAWZQH3U2pYKDTOAByQUVTbOl5lWwY68DatCbzPU/exec"
			target="frAttachFiles" onSubmit="alert('이메일을 정상적으로 보냈습니다.');">
			<div class="form form_name">
				이름
				<input class="name input input-bordered input-sm w-full" name="name" type="text" placeholder="이름을 입력하세요." required>
			</div>
			<div class="form form_nickname">
				닉네임
				<input class="nickname input input-bordered input-sm w-full" name="nickname" type="text" placeholder="닉네임을 입력하세요."
					required>
			</div>
			<div class="form form_email">
				이메일
				<input class="email input input-bordered input-sm" name="email" type="email" placeholder="이메일을 입력하세요."
					style="min-width: 300px;" required>
			</div>
			<div class="form form_text">
				<div class="form_text_content">내용</div>
				<textarea style="width: 800px; min-height: 300px;" class="text input input-bordered input-sm"
					name="body" autocomplete="off" type="text" placeholder="내용을 입력하세요."></textarea>
			</div>
			<div class="form_summit" style="margin-top: 30px;">
				<button class="btn-write" type="submit">문의하기</button>
				<button class="btn-back" type="button" onclick="history.back()">뒤로가기</button>
			</div>
		</form>
	</div>
</div>

<%@ include file="../common/foot.jspf"%>