<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Member Modify"/>
<%@ include file="../common/head.jspf" %>

<!-- Member modify 관련 -->
<script type="text/javascript">
let MemberModify__submitFormDone = false;
function MemberModify__submit(form) {
	if (MemberModify__submitFormDone) {
		return;
	}
	form.loginPw.value = form.loginPw.value.trim();
	
	if (form.loginPw.value.length > 0) {
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value.length == 0) {
			alert('비밀번호 확인을 입력해주세요.');
			form.loginPwConfirm.focus();
			return;
		}
		if (form.loginPw.value != form.loginPwConfirm.value) {
			alert('비밀번호가 일치하지 않습니다.');
			form.loginPw.focus();
			return;
		}
	}
	
	form.name.value = form.name.value.trim();
	form.nickname.value = form.nickname.value.trim();
	form.cellphoneNum.value = form.cellphoneNum.value.trim();
	
	if (form.name.value.length < 2) {
		alert('이름을 2글자 이상 입력해주세요.');
		form.name.focus();
		return;
	}
	if (form.nickname.value.length < 2) {
		alert('닉네임을 2글자 이상 입력해주세요.');
		form.nickname.focus();
		return;
	}
	if (form.cellphoneNum.value.length < 11) {
		alert('전화번호를 정확히 입력해주세요.');
		form.cellphoneNum.focus();
		return;
	}
	MemberModify__submitFormDone = true;
	form.submit();
}
</script>


<div class="modify_box mt-8 text-xl">
	<form action="../member/doModify" method="POST" onsubmit="MemberModify__submit(this); return false;">
		<input type="hidden" name="id" value="${member.id }" />
		<table class="table-box-type-1 table table-zebra" style="width: 700px;">
				<tr>
						<th>가입날짜</th>
						<th>${member.regDate }</th>
				</tr>
				
				<tr>
						<th>이메일</th>
						<th>${member.email }</th>
				</tr>
				
				<tr>
						<th>새 비밀번호</th>
						<th><input name="loginPw" placeholder="새 비밀번호를 입력해주세요." type="text" class="input input-bordered w-full max-w-xs"/></th>
				</tr>
				
				<tr>
						<th>새 비밀번호 확인</th>
						<th><input name="loginPwConfirm" placeholder="새 비밀번호를 입력해주세요." type="text" class="input input-bordered w-full max-w-xs"/></th>
				</tr>

				<tr>
						<th>이름</th>
						<th><input class="input input-bordered w-full max-w-xs" type="text" name="name" value="${member.name }"/></th>
				</tr>

				<tr>
						<th>닉네임</th>
						<th><input class="input input-bordered w-full max-w-xs" type="text" name="nickname" value="${member.nickname }" /></th>
				</tr>
				
				<tr>
						<th>전화번호</th>
						<th><input class="input input-bordered w-full max-w-xs" type="text" name="cellphoneNum" value="${member.cellphoneNum }" /></th>
				</tr>
				
		</table>
			<br />
		<div class="btn_box">
				<button class="btn btn-outline" type="button" onclick="history.back()">뒤로가기</button>
				<button class="btn btn-outline" type="submit" onclick="if(confirm('수정 하시겠습니까?')==false) return false;">수정하기</button>
		</div>
	</form>
</div>

<style type="text/css">
	.modify_box {
		margin-left: auto;
		margin-right: auto;
		width: 600px;
	}
	
	.btn_box {
		text-align: center;
	}
</style>
	
<%@ include file="../common/foot.jspf" %>