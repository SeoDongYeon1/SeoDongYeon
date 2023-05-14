<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="로그인" />
<%@ include file="../common/head.jspf"%>

<div class="form-box">
		<form method="post" action="doLogin">
				<br /> <input type="hidden" name="afterLoginUri" value=${param.afterLoginUri } />
				<div style="display: inline-block; text-align: left;">
						<div style="font-size: 15px; font-weight: bold;">
								아이디 <br /> 
								<input class="input input-bordered w-full max-w-xs" type="text" placeholder="아이디" name="loginId" autocomplete="on" required />
						</div>
						<br />
						<div style="font-size: 15px; font-weight: bold;">
								비밀번호 <br /> 
								<input class="input input-bordered w-full max-w-xs" type="password" placeholder="비밀번호" name="loginPw" autocomplete="off" required />
						</div>
						<br />
				</div>
				<br />
				<div class="btn-box">
						<button class="btn btn-outline" style="padding: 0 40px;" type="submit">로그인</button>
				</div>
		</form>
</div>

<style type="text/css">
.form-box {
	text-align: center;
}

form {
	width: 350px;
	height: 320px;
	border: 2px solid black;
	display: inline-block;
	border-radius: 8px;
}

.input {
	height: 30px;
	border-radius: 8px;
	width: 230px;
	border: 2px solid black;
}

.btn-box {
	border-radius: 8px;
	display: inline-block;
	width: 200px;
}
</style>

<%@ include file="../common/foot.jspf"%>