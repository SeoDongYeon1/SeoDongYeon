<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${article.title } 수정" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUIEditorLib.jspf"%>

<!-- Article modify 관련 -->
<script type="text/javascript">
	let ArticleModify__submitFormDone = false;
	function ArticleModify__submit(form) {
		if (ArticleModify__submitFormDone) {
			return;
		}
		form.title.value = form.title.value.trim();
		if (form.title.value == 0) {
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
		
		ArticleModify__submitFormDone = true;
		form.submit();
	}
</script>

<div style="text-align: center;">
		<div style="font-weight: bold; font-size: 17px;">${article.id }번 게시글 수정</div>
		<form method="post" action="doModify" onsubmit="ArticleModify__submit(this); return false;"
				style="width: 850px; height: 1000px; border: 2px solid black; display: inline-block; border-radius: 8px;">
				<br />
				<div style="display: inline-block; text-align: left;">
						<input value="${article.id }" type="hidden" name="id" />
						<input type="hidden" name="body">
						<div style="text-align: right; font-size: 14px; font-weight: bold">
								작성날짜 : ${article.regDate } <br /> 수정날짜 : ${article.updateDate } <br /> 작성자 : ${article.extra__writer }
						</div>
						<div style="font-size: 17px; font-weight: bold;">
								제목 <br /> <input class="input input-bordered w-full max-w-xs"
										style="border-radius: 8px; width: 500px; border: 2px solid black;" type="text" value="${article.title }"
										name="title" />
						</div>
						<br />
						<div style="font-size: 17px; font-weight: bold;">
								내용 <br />
								<div style="width: 800px;" class="toast-ui-editor">
									<script type="text/x-template">${article.body }</script>
								</div>
						</div>
						<br />
				</div>
				<br /> <br />
				<div style="border-radius: 8px; display: inline-block; width: 200px;">
						<button class="btn btn-outline" style="padding: 0 40px;" type="submit">수정하기</button>
				</div>
		</form>
</div>

<%@ include file="../common/foot.jspf"%>