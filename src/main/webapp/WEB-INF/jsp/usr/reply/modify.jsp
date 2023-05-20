<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Article Modify"/>
<%@ include file="../common/head.jspf" %>
	<hr />

<!-- Reply modify 관련 -->
<script type="text/javascript">
	let ReplyModify__submitFormDone = false;
	function ReplyModify__submit(form) {
		if (ReplyModify__submitFormDone) {
			return;
		}
		form.body.value = form.body.value.trim();
		if (form.body.value.length < 2) {
			alert('2글자 이상 입력해주세요.');
			form.body.focus();
			return;
		}
		ReplyModify__submitFormDone = true;
		form.submit();
	}
</script>

	<div style="text-align:center;">
		<div style="font-weight:bold; font-size: 17px;">
			댓글 수정
		</div>
		<form onsubmit="ReplyModify__submit(this); return false;" style="width: 550px; height: 620px; border:2px solid black; display: inline-block;  border-radius: 8px;" method= "post" action="doModify">
			<br />
			<div style="display: inline-block; text-align:left;">
				<input value= "${reply.id }" type="hidden" name="id"/>
				<div style="text-align: right; font-size:14px; font-weight:bold">
					작성날짜 : ${reply.regDate }
					<br />
					수정날짜 : ${reply.updateDate }
					<br />
					작성자 : ${reply.extra__writer }
				</div>
				
				<br />
				<div style="font-size: 17px; font-weight: bold;">
					내용
					<br />
					<textarea class="textarea textarea-bordered" style="border: 2px solid black; border-radius: 8px; width: 500px; height: 300px;" name="body">${reply.body }</textarea>
				</div>
				<br />
			</div>
			<br />
			<br />
			<div style="border-radius: 8px; display: inline-block; width: 200px;">
				<button class="btn btn-outline" style="padding: 0 40px; " type="submit" >수정하기</button>
			</div>
		</form>
	</div>
	
	
<%@ include file="../common/foot.jspf" %>