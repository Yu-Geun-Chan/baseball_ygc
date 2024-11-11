<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="DETAIL"></c:set>

<%@ include file="../common/toastUiEditorLib.jspf"%>
<!-- daisyUI -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.12.10/full.css" />

<link rel="stylesheet" href="/resource/common.css" />
<link rel="stylesheet" href="/resource/articleDetail.css" />

<%@ include file="../common/head.jspf"%>

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
	<div class="detail-container">
		<div style="display: flex; align-items: center; margin-left: -5px; margin-bottom: 10px; width: 800px;">
			<div>
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
			</div>
			<button class="btns" type="button" style="margin-left: auto;">
				<a href="../article/freeList">목록</a>
			</button>
		</div>

		<div>
			<div style="margin-bottom: 10px; font-size: 20px;">${article.title }</div>
			<div style="margin-bottom: 10px;">${article.extra__writer }</div>
			<div style="margin-bottom: 10px; color: 999999;">${article.regDate }</div>
			<div style="margin-bottom: 10px; color: 999999;">조회수 ${article.hitCount }</div>
			<hr style="margin-bottom: 10px;" />
			<div style="width: 800px; min-height: 400px;">${article.body}</div>
		</div>
		<div>
			<button id="likeButton" onclick="doGoodReaction(${param.id})">
				<svg style="display: inline-block;" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="-0.715 -0.715 20 20"
					id="Heart--Streamline-Core" height="20" width="20">
					<desc>Heart Streamline Icon: https://streamlinehq.com</desc>
					<g id="heart--reward-social-rating-media-heart-it-like-favorite-love">
					<path id="Vector" stroke="#f3063f" stroke-linecap="round" stroke-linejoin="round"
						d="M9.290438357142857 16.42463442857143 2.0290775785714286 9.847365921428572c-3.9464035500000003 -3.9464035500000003 1.8547981285714286 -11.523480857142857 7.261360778571429 -5.393417742857143 5.406522857142857 -6.130063114285715 11.181527571428573 1.4733305357142856 7.261400571428572 5.393417742857143L9.290438357142857 16.42463442857143Z"
						stroke-width="1.43"></path></g></svg>
				좋아요 ${article.goodReactionPoint }
			</button>
			<button id="DislikeButton" onclick="doBadReaction(${param.id})">
				<svg style="display: inline-block; margin-left: 10px;" xmlns="http://www.w3.org/2000/svg" height="20" width="20"
					viewBox="0 0 512 512">
					<path
						d="M323.8 477.2c-38.2 10.9-78.1-11.2-89-49.4l-5.7-20c-3.7-13-10.4-25-19.5-35l-51.3-56.4c-8.9-9.8-8.2-25 1.6-33.9s25-8.2 33.9 1.6l51.3 56.4c14.1 15.5 24.4 34 30.1 54.1l5.7 20c3.6 12.7 16.9 20.1 29.7 16.5s20.1-16.9 16.5-29.7l-5.7-20c-5.7-19.9-14.7-38.7-26.6-55.5c-5.2-7.3-5.8-16.9-1.7-24.9s12.3-13 21.3-13L448 288c8.8 0 16-7.2 16-16c0-6.8-4.3-12.7-10.4-15c-7.4-2.8-13-9-14.9-16.7s.1-15.8 5.3-21.7c2.5-2.8 4-6.5 4-10.6c0-7.8-5.6-14.3-13-15.7c-8.2-1.6-15.1-7.3-18-15.2s-1.6-16.7 3.6-23.3c2.1-2.7 3.4-6.1 3.4-9.9c0-6.7-4.2-12.6-10.2-14.9c-11.5-4.5-17.7-16.9-14.4-28.8c.4-1.3 .6-2.8 .6-4.3c0-8.8-7.2-16-16-16l-97.5 0c-12.6 0-25 3.7-35.5 10.7l-61.7 41.1c-11 7.4-25.9 4.4-33.3-6.7s-4.4-25.9 6.7-33.3l61.7-41.1c18.4-12.3 40-18.8 62.1-18.8L384 32c34.7 0 62.9 27.6 64 62c14.6 11.7 24 29.7 24 50c0 4.5-.5 8.8-1.3 13c15.4 11.7 25.3 30.2 25.3 51c0 6.5-1 12.8-2.8 18.7C504.8 238.3 512 254.3 512 272c0 35.3-28.6 64-64 64l-92.3 0c4.7 10.4 8.7 21.2 11.8 32.2l5.7 20c10.9 38.2-11.2 78.1-49.4 89zM32 384c-17.7 0-32-14.3-32-32L0 128c0-17.7 14.3-32 32-32l64 0c17.7 0 32 14.3 32 32l0 224c0 17.7-14.3 32-32 32l-64 0z" /></svg>
				싫어요 ${article.badReactionPoint }
			</button>
		</div>
		<hr style="width: 800px; margin-top: 10px;" />
	</div>

	<!-- 댓글 -->
	<div class="reply-container">
		<c:if test="${rq.isLogined() }">
			<form action="../reply/doWrite" method="POST" onsubmit="ReplyWrite__submit(this); return false;" )>
				<input type="hidden" name="relTypeCode" value="article" />
				<input type="hidden" name="relId" value="${article.id }" />

				<div style="width: 800px;">댓글 작성</div>
				<div style="width: 800px;">
					<textarea style="margin-top: 10px; width: 800px; min-height: 100px;" class="input input-bordered input-sm"
						name="body" autocomplete="off" type="text" placeholder="내용을 입력하세요."></textarea>
				</div>
				<div style="margin-top: 10px;">
					<button class="btns">등록</button>
				</div>

			</form>
		</c:if>

		<c:if test="${!rq.isLogined() }">
			<div style="font-size:16px;">
				댓글 작성을 위해
				<div class="btns" style="width: 70px; height: 40px; display: inline-block; text-align: center; line-height: 40px;">
					<a href="${rq.loginUri }">로그인</a>
				</div>
				이 필요합니다

			</div>
		</c:if>

		<!-- 	댓글 리스트 -->
		<div class="replyList-container">
			<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 800px; border-collapse: collapse;">
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
	</div>
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

<%@ include file="../common/foot.jspf"%>