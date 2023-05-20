<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="비밀번호 확인"/>
<%@ include file="../common/head.jspf" %>
<%@ page import="com.KoreaIT.sdy.demo.vo.Member" %>

<%
Member member = (Member) request.getAttribute("member");
String loginPw = member.getLoginPw();
%>
<script type="text/javascript">
let MemberCheckPw__submitDone = false; 

function MemberCheckPw__submit(form) {
	if (MemberCheckPw__submitDone) {
		return;
	}
    
	form.loginPw.value = form.loginPw.value.trim();
	
    if (form.loginPw.value.length==0) {
    	alert('비밀번호를 입력해주세요.');
		form.loginPw.focus();
		return;
	}
    if(form.loginPw.value !== '<%=loginPw%>') {
        alert('비밀번호를 확인해주세요.');
        form.loginPw.focus(); 
        console.log(form.loginPw.value);
        return;
    }
    
    MemberCheckPw__submitDone = true;
    form.submit();
}
</script>	
	
	<div style="text-align:center;">
		<div style="font-weight:bold; font-size: 17px;">
			회원정보 확인
		</div>
		<form method= "POST" action="modify" onsubmit="MemberCheckPw__submit(this); return false;" style="width: 350px; height: 270px; border:2px solid black; display: inline-block;  border-radius: 8px;" >
			<br />
			<div style="display: inline-block; text-align:left;">
				<div style="font-size: 15px; font-weight: bold; ">
					아이디
					<br />
					${member.email }
				</div>
				<br />
				<div style="font-size: 15px; font-weight: bold;">
					비밀번호
					<br />
					<input class="input input-bordered w-full max-w-xs" style="height: 30px; border-radius: 8px; width: 230px; border: 2px solid black;" type="password" placeholder="비밀번호" name="loginPw" autocomplete="off"/>
				</div>
				<br />
			</div>
			<br />
			<div style="border-radius: 8px; display: inline-block; width: 150px;">
				<button class="btn btn-outline" style="padding: 0 40px; " type="submit">확인</button>
			</div>
		</form>
	</div>
	

<%@ include file="../common/foot.jspf" %>