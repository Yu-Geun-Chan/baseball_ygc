<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="DETAIL"></c:set>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<!-- daisyUI -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.12.10/full.css" />
<hr />
<%@ include file="../common/head.jspf"%>

<!-- <iframe src="http://localhost:8080/usr/article/doIncreaseHitCount?id=757" frameborder="0"></iframe> -->
<!-- 변수 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
	params.memberId = parseInt('${loginedMemberId}')
	
	console.log(params);
	console.log(params.id);
	console.log(params.memberId);

	var isAlreadyAddGoodRp = ${isAlreadyAddGoodRp};
	var isAlreadyAddBadRp = ${isAlreadyAddBadRp};
</script>

<!-- 조회수 -->
<script>
	function ArticleDetail__doIncreaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyOnView';

		if (localStorage.getItem(localStorageKey)) {
			return;
		}

		localStorage.setItem(localStorageKey, true);

		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			console.log(data);
			console.log(data.data1);
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json')
	}

	$(function() {
		// 		ArticleDetail__doIncreaseHitCount();
		setTimeout(ArticleDetail__doIncreaseHitCount, 2000);
	})
</script>

<!-- 좋아요 싫어요  -->
<script>
<!-- 좋아요 싫어요 버튼	-->
	function checkRP() {
		if (isAlreadyAddGoodRp == true) {
			$('#likeButton').toggleClass('btn-outline');
		} else if (isAlreadyAddBadRp == true) {
			$('#DislikeButton').toggleClass('btn-outline');
		} else {
			return;
		}
	}

function doGoodReaction(articleId) {
		if(isNaN(params.memberId) == true){
			if(confirm('로그인을 해야합니다.')){
// 				console.log(window.location.href);
// 				console.log(encodeURIComponent(window.location.href));
				var currentUri = encodeURIComponent(window.location.href);
				window.location.href = '../member/login?afterLoginUri=' + currentUri;
			}
			return;
		}	
	
	
		$.ajax({
			url: '/usr/reactionPoint/doGoodReaction',
			type: 'POST',
			data: {relTypeCode: 'article', relId: articleId},
			dataType: 'json',
			success: function(data){
				console.log(data);
				console.log('data.data1Name : ' + data.data1Name);
				console.log('data.data1 : ' + data.data1);
				console.log('data.data2Name : ' + data.data2Name);
				console.log('data.data2 : ' + data.data2);
				if(data.resultCode.startsWith('S-')){
					var likeButton = $('#likeButton');
					var likeCount = $('#likeCount');
					var likeCountC = $('.likeCount');
					var DislikeButton = $('#DislikeButton');
					var DislikeCount = $('#DislikeCount');
					var DislikeCountC = $('.DislikeCount');
					
					if(data.resultCode == 'S-1'){
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
						likeCountC.text(data.data1);
					}else if(data.resultCode == 'S-2'){
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
						DislikeCountC.text(data.data2);
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
						likeCountC.text(data.data1);
					}else {
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
						likeCountC.text(data.data1);
					}
					
				}else {
					alert(data.msg);
				}
		
			},
			error: function(jqXHR,textStatus,errorThrown) {
				alert('좋아요 오류 발생 : ' + textStatus);

			}
			
		});
	}

function doBadReaction(articleId) {
	if(isNaN(params.memberId) == true){
		if(confirm('로그인을 해야합니다.')){
//				console.log(window.location.href);
//				console.log(encodeURIComponent(window.location.href));
			var currentUri = encodeURIComponent(window.location.href);
			window.location.href = '../member/login?afterLoginUri=' + currentUri; // 로그인 페이지에 원래 페이지의 정보를 포함시켜서 보냄
		}
		return;
	}	
	 $.ajax({
			url: '/usr/reactionPoint/doBadReaction',
			type: 'POST',
			data: {relTypeCode: 'article', relId: articleId},
			dataType: 'json',
			success: function(data){
				console.log(data);
				console.log('data.data1Name : ' + data.data1Name);
				console.log('data.data1 : ' + data.data1);
				console.log('data.data2Name : ' + data.data2Name);
				console.log('data.data2 : ' + data.data2);
				if(data.resultCode.startsWith('S-')){
					var likeButton = $('#likeButton');
					var likeCount = $('#likeCount');
					var likeCountC = $('.likeCount');
					var DislikeButton = $('#DislikeButton');
					var DislikeCount = $('#DislikeCount');
					var DislikeCountC = $('.DislikeCount');
					
					
					if(data.resultCode == 'S-1'){
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
						DislikeCountC.text(data.data2);
					}else if(data.resultCode == 'S-2'){
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
						likeCountC.text(data.data1);
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
						DislikeCountC.text(data.data2);
		
					}else {
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
						DislikeCountC.text(data.data2);
					}
			
				}else {
					alert(data.msg);
				}
			},
			error: function(jqXHR,textStatus,errorThrown) {
				alert('싫어요 오류 발생 : ' + textStatus);
			}
			
		});
	}

	$(function() {
		checkRP();
	});
</script>
<!-- 댓글 수정 -->
<script>
function toggleModifybtn(replyId) {
	
	console.log(replyId);
	
	$('#modify-btn-'+replyId).hide();
	$('#save-btn-'+replyId).show();
	$('#reply-'+replyId).hide();
	$('#modify-form-'+replyId).show();
}

function doModifyReply(replyId) {
	 console.log(replyId); // 디버깅을 위해 replyId를 콘솔에 출력
	    
	    // form 요소를 정확하게 선택
	    var form = $('#modify-form-' + replyId);
	    console.log(form); // 디버깅을 위해 form을 콘솔에 출력

	    // form 내의 input 요소의 값을 가져옵니다
	    var text = form.find('input[name="reply-text-' + replyId + '"]').val();
	    console.log(text); // 디버깅을 위해 text를 콘솔에 출력

	    // form의 action 속성 값을 가져옵니다
	    var action = form.attr('action');
	    console.log(action); // 디버깅을 위해 action을 콘솔에 출력
	
    $.post({
    	url: '/usr/reply/doModify', // 수정된 URL
        type: 'POST', // GET에서 POST로 변경
        data: { id: replyId, body: text }, // 서버에 전송할 데이터
        success: function(data) {
        	$('#modify-form-'+replyId).hide();
        	$('#reply-'+replyId).text(data);
        	$('#reply-'+replyId).show();
        	$('#save-btn-'+replyId).hide();
        	$('#modify-btn-'+replyId).show();
        },
        error: function(xhr, status, error) {
            alert('댓글 수정에 실패했습니다: ' + error);
        }
	})
}
</script>

<div class="main-content">
	<section class="mt-24 text-xl px-4">
		<div style="margin-right: calc(50% + 150px);">
			<button class="btn-back" type="button" onclick="history.back()" style="margin-right: 10px;">뒤로가기</button>
			<c:if test="${article.userCanModify }">
				<button class="btn-modify" style="margin-right: 10px;">
					<a href="../article/modify?id=${article.id }">수정</a>
				</button>
			</c:if>
			<c:if test="${article.userCanDelete }">
				<button class="btn-delete" style="margin-right: 10px;">
					<a class="btn-delete" href="../article/doDelete?id=${article.id }">삭제</a>
				</button>
			</c:if>
			<button class="btns" type="button">
				<a href="../article/freeList">목록</a>
			</button>
		</div>
		<div class="mx-auto">
			<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
				<tbody>
					<tr>
						<th style="text-align: center;">번호</th>
						<td style="text-align: center;">${article.id}</td>
					</tr>
					<tr>
						<th style="text-align: center;">작성일</th>
						<td style="text-align: center;">${article.regDate.substring(0,10)}</td>
					</tr>
					<tr>
						<th style="text-align: center;">수정일</th>
						<td style="text-align: center;">${article.updateDate}</td>
					</tr>
					<tr>
						<th style="text-align: center;">게시판 번호</th>
						<td style="text-align: center;">${article.boardId}</td>
					</tr>
					<tr>
						<th style="text-align: center;">작성자</th>
						<td style="text-align: center;">${article.extra__writer}</td>
					</tr>
					<tr>
						<th class="reaction" style="text-align: center;">좋아요</th>
						<td id="likeCount" style="text-align: center;">${article.goodReactionPoint}</td>
					</tr>
					<tr>
						<th style="text-align: center;">싫어요</th>
						<td id="DislikeCount" style="text-align: center;">${article.badReactionPoint}</td>
					</tr>
					<tr>
						<th style="text-align: center;">좋아요 / 싫어요 ${usersReaction }</th>
						<td style="text-align: center;">

							<button id="likeButton" class="btn btn-outline btn-success" onclick="doGoodReaction(${param.id})">
								👍 LIKE
								<span class="likeCount">${article.goodReactionPoint}</span>
							</button>
							<button id="DislikeButton" class="btn btn-outline btn-error" onclick="doBadReaction(${param.id})">
								👎 DISLIKE
								<span class="DislikeCount">${article.badReactionPoint}</span>
							</button>
						</td>
					</tr>

					<tr>
						<th style="text-align: center;">조회수</th>

						<td style="text-align: center;">
							<span class="article-detail__hit-count">${article.hitCount}</span>
						</td>
					</tr>
					<tr>
						<th style="text-align: center;">제목</th>
						<td style="text-align: center;">${article.title}</td>
					</tr>
					<tr>
						<th style="text-align: center;">등록 이미지</th>
						<td style="text-align: center;">
							<div style="text-align: center;">
								<img class="mx-auto rounded-xl" src="${rq.getImgUri(article.id)}" onerror="${rq.profileFallbackImgOnErrorHtml}"
									alt="" />
							</div>
							<div>${rq.getImgUri(article.id)}</div>
						</td>
					</tr>
					<tr>
						<th style="text-align: center;">내용</th>
						<td>
							<div class="toast-ui-viewer">
								<script type="text/x-template">${article.body}</script>
							</div>
						</td>
					</tr>

				</tbody>
			</table>
		</div>
	</section>
</div>

<!-- 댓글 -->
<section class="mt-24 text-xl px-4">
	<c:if test="${rq.isLogined() }">
		<form action="../reply/doWrite" method="POST" onsubmit="ReplyWrite__submit(this); return false;" )>
			<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
				<input type="hidden" name="relTypeCode" value="article" />
				<input type="hidden" name="relId" value="${article.id }" />
				<tbody>

					<tr>
						<th>댓글 내용 입력</th>
						<td style="text-align: center;">
							<textarea class="input input-bordered input-sm w-full max-w-xs" name="body" autocomplete="off" type="text"
								placeholder="내용을 입력하세요."></textarea>
						</td>

					</tr>
					<tr>
						<th></th>
						<td style="text-align: center;">
							<button class="btn">작성</button>
						</td>

					</tr>
				</tbody>
			</table>
		</form>
	</c:if>

	<c:if test="${!rq.isLogined() }">
		댓글 작성을 위해 
		<div class="btns" style="width: 70px; height: 40px; display: inline-block; text-align: center; line-height: 40px;">
			<a href="${rq.loginUri }">로그인</a>
		</div>이 필요합니다
	</c:if>
	<!-- 	댓글 리스트 -->
	<div class="mx-auto">
		<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
			<thead>
				<tr>
					<th style="text-align: center;">등록일</th>
					<th style="text-align: center;">작성자</th>
					<th style="text-align: center;">내용</th>
					<th style="text-align: center;">좋아요</th>
					<th style="text-align: center;">싫어요</th>
					<th style="text-align: center;">수정</th>
					<th style="text-align: center;">삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="reply" items="${replies}">
					<tr class="hover">
						<td style="text-align: center;">${reply.regDate.substring(0,10)}</td>
						<td style="text-align: center;">${reply.extra__writer}</td>
						<td style="text-align: center;">
							<span id="reply-${reply.id }">${reply.body}</span>
							<form method="POST" id="modify-form-${reply.id }" style="display: none;" action="/usr/reply/doModify">
								<input type="text" value="${reply.body }" name="reply-text-${reply.id }" />
							</form>
						</td>
						<td style="text-align: center;">${reply.goodReactionPoint}</td>
						<td style="text-align: center;">${reply.badReactionPoint}</td>
						<td style="text-align: center;">
							<c:if test="${reply.userCanModify }">
								<%-- 								<a class="btn btn-outline btn-xs btn-success" href="../reply/modify?id=${reply.id }">수정</a> --%>
								<button onclick="toggleModifybtn('${reply.id}');" id="modify-btn-${reply.id }" style="white-space: nowrap;"
									class="btn btn-outline btn-xs btn-success">수정</button>
								<button onclick="doModifyReply('${reply.id}');" style="white-space: nowrap; display: none;"
									id="save-btn-${reply.id }" class="btn btn-outline btn-xs">저장</button>
							</c:if>
						</td>
						<td style="text-align: center;">
							<c:if test="${reply.userCanDelete }">
								<a class="btn btn-outline btn-xs btn-error" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
									href="../reply/doDelete?id=${reply.id }">삭제</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>

				<c:if test="${empty replies}">
					<tr>
						<td colspan="4" style="text-align: center;">댓글이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</section>
</div>

<script>
	function ReplyWrite__submit(form) {
		console.log(form.body.value);
		
		form.body.value = form.body.value.trim();
		
		if(form.body.value.length < 3){
			alert('3글자 이상 입력하세요.');
			form.body.focus();
			return;
		}
		
		form.submit();
	}
</script>

<style>
.btns {
	border: 1px solid #e1e1e1;
	border-radius: 5px;
	width: 70px;
	height: 40px;
	color: 444444;
	background: #e1e1e1;
	font-size: 16px;
}

.btn-modify {
	border: 1px solid #e1e1e1;
	border-radius: 5px;
	width: 70px;
	height: 40px;
	color: 444444;
	background: #e1e1e1;
	font-size: 16px;
}

.btn-delete {
	border: 1px solid #e1e1e1;
	border-radius: 5px;
	width: 70px;
	height: 40px;
	color: 444444;
	background: #e1e1e1;
	font-size: 16px;
}

.btn-back {
	border: 0px;
	color: 999999;
	width: 70px;
	height: 40px;
	line-height: 40px;
	text-align: center;
	font-size: 16px;
}
</style>

<%@ include file="../common/foot.jspf"%>