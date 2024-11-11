<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.code} LIST"></c:set>
<link rel="stylesheet" href="/resource/list.css" />
<link rel="stylesheet" href="/resource/common.css" />

<%@ include file="../common/head.jspf"%>

<hr />

<div class="main-title">
	<div class="main-title-content">${board.name}</div>
</div>
<div class="main-content">
	<div class="search-container">
		<form action="/article/list" method="get" id="search-form">
			<select name="searchKeywordTypeCode" class="option" id="keyword-type-filter">
				<option value="title">제목</option>
				<option value="body">내용</option>
				<option value="title,body">제목 + 내용</option>
				<option value="writer">작성자</option>
			</select>
			<input type="text" placeholder="검색어를 입력하세요." name="searchKeyword" class="search" id="keyword-filter"
				value="${param.searchKeyword}">
			<div class="btn_search-container">
				<input type="submit" value="검색" class="btn_search" id="search-button">
			</div>
		</form>
	</div>
	<p class="title">
		<span class="point">${articlesCount}개</span>
	</p>

	<div class="article-info-container">
		<table cellpadding="0" cellspacing="0">
			<colgroup>
				<col width="75">
				<col width="250">
				<col width="100">
				<col width="150">
				<col width="75">
				<col width="75">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>좋아요</th>
					<th>싫어요</th>
				</tr>
			</thead>
			<tbody id="article-table-body">
				<c:forEach var="article" items="${articles}">
					<tr class="hover">
						<td style="text-align: center;">${article.id}</td>
						<td style="text-align: center;">
							<a style="hover: underline;" href="detail?id=${article.id}">${article.title}
								<c:if test="${article.extra__repliesCount > 0 }">
									<span style="color: red;">[${article.extra__repliesCount}]</span>
								</c:if>
							</a>
						</td>
						<td style="text-align: center;">${article.extra__writer}</td>
						<td style="text-align: center;">${article.regDate.substring(0,10)}</td>
						<td style="text-align: center;">${article.goodReactionPoint}</td>
						<td style="text-align: center;">${article.badReactionPoint}</td>
					</tr>
				</c:forEach>

				<c:if test="${empty articles}">
					<tr>
						<td colspan="6" style="text-align: center;">게시글이 없습니다</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<div id="pagination-controls" class="pagination flex justify-center mt-3"></div>
	<div class="write">
		<a href="../article/write">글쓰기</a>
	</div>

</div>

<script>
    var totalPages = ${pagesCount}; // 전체 페이지 수
    var currentPage = ${page}; // 현재 페이지

    function renderPagination() {
        const paginationControls = $('#pagination-controls');
        paginationControls.empty();
        
        if (totalPages <= 1) return;

        if (currentPage > 1) {
            paginationControls.append('<a class="btn btn-sm" onclick="goToPage(1)">처음으로</a>');
            paginationControls.append('<a class="btn btn-sm" onclick="goToPage(' + (currentPage - 1) + ')">이전</a>');
        }

        const startPage = Math.max(1, currentPage - 3);
        const endPage = Math.min(totalPages, currentPage + 3);

        for (let i = startPage; i <= endPage; i++) {
            paginationControls.append('<a class="btn btn-sm ' + (i === currentPage ? 'btn-active' : '') + '" onclick="goToPage(' + i + ')">' + i + '</a>');
        }

        if (currentPage < totalPages) {
            paginationControls.append('<a class="btn btn-sm" onclick="goToPage(' + (currentPage + 1) + ')">다음</a>');
            paginationControls.append('<a class="btn btn-sm" onclick="goToPage(' + totalPages + ')">끝으로</a>');
        }
    }

    function goToPage(page) {
        if (page < 1 || page > totalPages) return;
        currentPage = page;
        sendAjaxRequest();
    }

    function sendAjaxRequest() {
        const searchKeywordTypeCode = $('#keyword-type-filter').val();
        const searchKeyword = $('#keyword-filter').val();

        $.ajax({
            type: 'GET',
            url: '/article/list',
            data: {
                page: currentPage,
                boardId: ${param.boardId},
                searchKeywordTypeCode: searchKeywordTypeCode,
                searchKeyword: searchKeyword
            },
            success: function(response) {
                $('#article-table-body').empty();

                response.articles.forEach(article => {
                    $('#article-table-body').append(
                        `<tr class="hover">
                            <td style="text-align: center;">${article.id}</td>
                            <td style="text-align: center;">${article.regDate.substring(0,10)}</td>
                            <td style="text-align: center;">
                                <a class="hover:underline" href="detail?id=${article.id}">${article.title}</a>
                            </td>
                            <td style="text-align: center;">${article.extra__writer}</td>
                            <td style="text-align: center;">${article.goodReactionPoint}</td>
                            <td style="text-align: center;">${article.badReactionPoint}</td>
                        </tr>`
                    );
                });

                renderPagination();
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청 실패:', status, error);
            }
        });
    }

    $('#search-form').on('submit', function(event) {
        event.preventDefault();
        currentPage = 1;
        sendAjaxRequest();
    });

    renderPagination();
</script>

<%@ include file="../common/foot.jspf"%>