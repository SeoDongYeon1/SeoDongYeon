<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${article.title }" />
<%@ include file="../common/head.jspf"%>

<!-- 변수 생성 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
	params.memberId = parseInt('${loginedMemberId}');
	
</script>

<!-- 조회수 관련 -->
<script>
	function ArticleDetail__increaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyView';

		if (localStorage.getItem(localStorageKey)) {
			return;
		}

		localStorage.setItem(localStorageKey, true);
		$.get('../article/doIncreaseHitCount', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}
	
</script>


<!-- 리액션 실행 코드 -->
<script>
	$(function() {
		ArticleDetail__increaseHitCount();
	});
	
</script>

<div class="mt-8 text-xl mx-auto px-3">
		<table class="table-box-type-1 table table-zebra w-full" style="text-align: center;">
				<tr>
						<th>번호</th>
						<th>${article.id }</th>
				</tr>
				<tr>
						<th>작성자</th>
						<th>${article.extra__writer }</th>
				</tr>
				<tr>
						<th>제목</th>
						<th>${article.title }</th>
				</tr>
				<tr>
						<th>내용</th>
						<th>${article.body }</th>
				</tr>
				<tr>
						<th>작성날짜</th>
						<th>${article.regDate }</th>
				</tr>
				<tr>
						<th>수정날짜</th>
						<th>${article.updateDate }</th>
				</tr>
				<tr>
						<th>조회수</th>
						<th><span class="article-detail__hit-count">${article.hitCount }</span></th>
				</tr>
		</table>

		<br />
		<div class="btn_box">
				<c:if test="${rq.getLoginedMemberId()==article.memberId }">
						<a class="btn btn-outline" href="../article/modify?id=${article.id }">수정</a>
						<a class="btn btn-outline" onclick="if(confirm('정말 삭제하시겠습니까?')==false) return false;"
								href="doDelete?id=${article.id }">삭제</a>
				</c:if>
				<button class="btn btn-outline" type="button" onclick="history.back();">뒤로가기</button>
		</div>
</div>
<div class="reply_text">
		댓글
		<div class="mt-8 text-xl mx-auto px-3 reply_box">
				<c:forEach var="reply" items="${replies }">
						<div class="reply_top flex justify-between">
								<div class="reply_writer">${reply.extra__writer }</div>
								<div class="reply_regDate">${reply.regDate }</div>
						</div>


						<div class="reply-btn-box">
								<c:if test="${reply.actorCanModify }">
										<a href="../reply/modify?id=${reply.id }">수정</a>
								</c:if>
								<c:if test="${reply.actorCanDelete }">
										<a onclick="if(confirm('정말 삭제하시겠습니까?')==false) return false;" href="../reply/doDelete?id=${reply.id }">삭제</a>
								</c:if>
						</div>

						<br />
						<div class="reply_bottom flex justify-between">
								<div>${reply.body }</div>
								<div class="btn-box"></div>
						</div>
						<hr />
						<br />
				</c:forEach>
		</div>
</div>

<c:if test="${rq.logined }">
		<div style="text-align: center; margin-top: 30px;">
				<div style="font-weight: bold; font-size: 17px;">댓글</div>
				<form method="post" action="../reply/doWrite" onsubmit="return ReplyWrite__SubmitForm(this); return false;"
						style="width: 700px; height: 250px; border: 2px solid black; display: inline-block; border-radius: 8px;">
						<br /> <input type="hidden" name="relTypeCode" value="article" /> <input type="hidden" name="relId"
								value="${article.id }" />
						<div style="display: inline-block; text-align: left;">
								<div style="font-size: 17px; font-weight: bold;">
										내용 <br />
										<textarea class="body textarea textarea-bordered"
												style="border: 2px solid black; border-radius: 8px; border-color: black; width: 650px; height: 80px;"
												name="body"></textarea>
								</div>
								<br />
						</div>
						<br />
						<div style="border-radius: 8px; display: inline-block; width: 200px;">
								<button class="btn btn-outline" style="padding: 0 20px;" type="submit">댓글 작성</button>
						</div>
				</form>
		</div>
</c:if>
<script>
	let ReplyWrite__SubmitFormDone = false;
	
	function ReplyWrite__SubmitForm(form) {
		if(ReplyWrite__SubmitFormDone) {
			return;
		}
		
	    var body = form.body.value.trim();
	    
	    if(body.length < 2) {
	        alert('내용을 2글자 이상 입력해주세요.');
	        form.body.focus();
	        return false;
	    }
	    
	    ReplyWrite__SubmitFormDone = true;
	    form.submit();
	}
</script>

<!-- 커스텀 -->
<style type="text/css">
	.table-box-type-1 {
		margin-left: auto;
		margin-right: auto;
		width: 1000px;
	}
	
	.btn_box {
		text-align: center;
	}
	
	.btns {
		text-align: center;
	}
	
	.btns>.btn {
		width: 100px;
		height: 40px;
	}
	
	.reply_box {
		border: 2px solid black;
		text-align: left;
		font-weight: bold;
		width: 700px;
	}
	
	.reply_text {
		font-size: 25px;
		margin: 20px 0;
		text-align: center;
	}
	
	.reply_writer .reply_body {
		font-size: 20px;
	}
	
	.reply_regDate {
		font-size: 15px;
		text-align: right;
	}
	
	.reply-btn-box {
		text-align: right;
	}
	
	.reply-btn-box>.button {
		font-weight: bold;
		font-size: 13px;
		text-decoration: underline;
	}
	
	.reply_bottom {
		position: relative;
	}
</style>

		<%@ include file="../common/foot.jspf"%>