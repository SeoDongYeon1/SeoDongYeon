<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="JOIN" />
<%@ include file="../common/head.jspf"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js" referrerpolicy="no-referrer"></script>

<script>
	let submitJoinFormDone = false;
	let validLoginId = "";
	let validLoginPw = "";
	let validEmail = "";
	let validNickname = "";
	let validCellphoneNum = "";
	let validName = "";

	function submitJoinForm(form) {
		if (submitJoinFormDone) {
			alert('처리중입니다');
			return;
		}
		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value == 0) {
			alert('아이디를 입력해주세요');
			form.loginId.focus();
			return;
		}

		if (form.loginId.value != validLoginId) {
			alert('사용할 수 없는 아이디입니다.');
			form.loginId.focus();
			return;
		}
		
		if (form.loginPw.value != validLoginPw) {
			alert('사용할 수 없는 비밀번호입니다.');
			form.loginPw.focus();
			return;
		}
		
		if (form.name.value != validName) {
			alert('사용할 수 없는 이름입니다.');
			form.name.focus();
			return;
		}
		
		if (form.nickname.value != validNickname) {
			alert('사용할 수 없는 닉네임입니다.');
			form.nickname.focus();
			return;
		}
		
		if (form.cellphoneNum.value != validCellphoneNum ) {
			alert('사용할 수 없는 전화번호입니다.');
			form.cellphoneNum.focus();
			return;
		}
		
		if (form.email.value != validEmail) {
			alert('사용할 수 없는 이메일입니다.');
			form.email.focus();
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value == 0) {
			alert('비밀번호를 입력해주세요');
			form.loginPw.focus();
			return;
		}
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value == 0) {
			alert('비밀번호 확인을 입력해주세요');
			form.loginPwConfirm.focus();
			return;
		}
		if (form.loginPwConfirm.value != form.loginPw.value) {
			alert('비밀번호가 일치하지 않습니다');
			form.loginPw.focus();
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value == 0) {
			alert('이름을 입력해주세요');
			form.name.focus();
			return;
		}
		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value == 0) {
			alert('닉네임을 입력해주세요');
			form.nickname.focus();
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value == 0) {
			alert('이메일을 입력해주세요');
			form.email.focus();
			return;
		}
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		if (form.cellphoneNum.value == 0) {
			alert('전화번호를 입력해주세요');
			form.cellphoneNum.focus();
			return;
		}
		submitJoinFormDone = true;
		form.submit();
	}
	
	const CheckEmaildupDebounced = _.debounce(checkEmaildup, 600);
	
	// 이메일 중복체크 ajax
	function checkEmaildup(el) {
		const form = $(el).closest('form').get(0);

		if (form.email.value.length == 0) {
			$('.checkEmailDup-msg').html('<div class="mt-2 text-red-500">이메일을 입력해주세요.</div>');
			validEmail = "";
			return;
		}
		
		if (form.email.value == validEmail) {
			return;
		}

		if (form.email.value.length >= 1) {
			 const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
			
			if(!emailPattern.test(form.email.value)) {
				$('.checkEmailDup-msg').html('<div class="mt-2 text-red-500">올바른 이메일 형식이 아닙니다.</div>');
				validEmail = "";
				return;
			}
			
			var action = "../member/getEmailDup";
			
			$.get(action, {

				isAjax : 'Y',
				email : form.email.value

			}, function(data) {
			
				if (data.success) {
				$('.checkEmailDup-msg').html('<div class="mt-2">' + data.msg + '</div>');
				validEmail = data.data1;
					
				} else {
					$('.checkEmailDup-msg').html('<div class="mt-2 text-red-500">' + data.msg + '</div>');
					validEmail = "";
				}

			}, 'json');
		}
	}

	// 비밀번호 체크	
	const CheckPassword_Debounce = _.debounce(checkPassword, 600);

	function checkPassword(el) {
	    const form = $(el).closest('form').get(0);
	    const Password = form.loginPw.value.trim();
	    const PasswordConfirm = form.loginPwConfirm.value.trim();
	
	    if (Password.length === 0) {
	        $('.checkloginPw-msg').html('<div class="mt-2 text-red-500">비밀번호를 입력해주세요.</div>');
	        validLoginPw = "";
	        return;
	    }
	    
	    if (!/^.*(?=.{8,16})(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*]).*$/.test(Password)) {
	        $('.checkloginPw-msg').html('<div class="mt-2 text-red-500">비밀번호를 8~16자리의 영문, 숫자, 특수문자(!@#$%^&*)를 포함하여 입력해주세요.</div>');
	        validLoginPw = "";
	        return;
	    }
	    $('.checkloginPw-msg').empty();
	
	    if (Password !== PasswordConfirm && PasswordConfirm.length !== 0) {
	        $('.checkloginPwConfirm-msg').html('<div class="mt-2 text-red-500">비밀번호가 일치하지 않습니다.</div>');
	        validLoginPw = "";
	        return;
	    }  
	    if(Password === PasswordConfirm) {
	        $('.checkloginPwConfirm-msg').html('<div class="mt-2 text-blue-500">비밀번호가 일치합니다.</div>');
	        validLoginPw = Password;
	        return;
	    }
	}
	
	// 비밀번호 확인 체크	
	const CheckPasswordConfirm_Debounce = _.debounce(checkPasswordConfirm, 600);
	
	function checkPasswordConfirm(el) {
	    const form = $(el).closest('form').get(0);
	    const Password = form.loginPw.value.trim();
	    const PasswordConfirm = form.loginPwConfirm.value.trim();

	    if(PasswordConfirm.length == 0) {
	    	$('.checkloginPwConfirm-msg').html('<div class="mt-2 text-red-500">비밀번호 확인을 입력해주세요.</div>');
	    	validLoginPw = "";
	    	return;
	    }
	        
	    if (!/^.*(?=.{8,16})(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*]).*$/.test(PasswordConfirm)) {
	        $('.checkloginPwConfirm-msg').html('<div class="mt-2 text-red-500">비밀번호를 8~16자리의 영문, 숫자, 특수문자(!@#$%^&*)를 포함하여 입력해주세요.</div>');
	        validLoginPw = "";
	        return;
	    }
	    
	    if(Password !== PasswordConfirm && PasswordConfirm.length !== 0) {
	        $('.checkloginPwConfirm-msg').html('<div class="mt-2 text-red-500">비밀번호가 일치하지 않습니다.</div>');
	        validLoginPw = "";
	        return;
	    }
	    
	    if(Password === PasswordConfirm) {
	        $('.checkloginPwConfirm-msg').html('<div class="mt-2 text-blue-500">비밀번호가 일치합니다.</div>');
	        validLoginPw = Password;
	        return;
	    }
	    
	}
	
	// 이름 체크
	const CheckName_Debounce = _.debounce(checkName, 600);
	
	function checkName(el) {
	    $('.checkName-msg').empty();
	    const form = $(el).closest('form').get(0);
	    const name = form.name.value.trim();

	    if(name.length == 0) {
	    	$('.checkName-msg').html('<div class="mt-2 text-red-500">이름을 입력해주세요.</div>');
	    	validName = "";
	    	return;
	    }
	    
	    if (name == validName) {
			return;
		}
	    
	    validName = name;
	    
	}
	
	// 전화번호 체크
	const CheckCellphoneNum_Debounce = _.debounce(CheckCellphoneNum, 600);

	function CheckCellphoneNum(el) {
	    $('.checkCellphoneNum-msg').empty();
	    const form = $(el).closest('form').get(0);
	    const cellphoneNum = form.cellphoneNum.value.trim();
	    const cellphoneNumRegex = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	
	    if(cellphoneNum.length == 0) {
	        $('.checkCellphoneNum-msg').html('<div class="mt-2 text-red-500">전화번호를 입력해주세요</div>');
	        validCellphoneNum = "";
	        return;
	    }
	    
	    if (cellphoneNum == validCellphoneNum) {
			return;
		}
	    
	    if (!cellphoneNumRegex.test(cellphoneNum)) {
	    	$('.checkCellphoneNum-msg').html('<div class="mt-2 text-red-500">올바른 전화번호 형식이 아닙니다. [000-0000-0000]와 같이 입력해주세요.</div>');
	    	validCellphoneNum = "";
	    	return;
	    }
	    
	    validCellphoneNum = cellphoneNum;
	}
	
	// 닉네임 중복 체크
	const CheckNickName_Debounce = _.debounce(checkNickName, 700);
	
	function checkNickName(el) {
	    const form = $(el).closest('form').get(0);
	    const nickname = form.nickname.value.trim();

	    if(nickname.length == 0) {
	    	$('.checkNickName-msg').html('<div class="mt-2 text-red-500">닉네임을 입력해주세요.</div>');
	    	return;
	    }
	    if(nickname.length < 2) {
	    	$('.checkNickName-msg').html('<div class="mt-2 text-red-500">닉네임을 2글자 이상 입력해주세요.</div>');
	    	return;
	    }
	    
	    if (nickname == validNickname) {
			return;
		}
	    
	    if (form.nickname.value.length >= 2) {
			var action = "../member/getNicknameDup";
			$.get(action, {

				isAjax : 'Y',
				nickname : form.nickname.value

			}, function(data) {
				
				if (data.success) {
				$('.checkNickName-msg').html('<div class="mt-2">' + data.msg + '</div>');
					validNickname = data.data1;
					
				} else {
					$('.checkNickName-msg').html('<div class="mt-2 text-red-500">' + data.msg + '</div>');
					validNickname = "";
				}

			}, 'json');
		}
	    
	}
	
</script>

<section class="mt-8 text-xl">
		<div class="form-box">
				<form class="table-box-type-1" method="POST" action="../member/doJoin"
						onsubmit="submitJoinForm(this); return false;">
						<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}" />
						<table class="table table-zebra w-full">
								<colgroup>
										<col width="200" />
								</colgroup>

								<tbody>
										<tr>
												<th>이메일</th>
										</tr>
										<tr>
												<td><input onkeyup="CheckEmaildupDebounced(this);" name="email" class="w-full input input-bordered  max-w-xs" placeholder="이메일을 입력해주세요" />
												<div class="checkEmailDup-msg"></div></td>
										</tr>
										<tr>
												<th>비밀번호</th>
										</tr>
										<tr>
												<td><input onkeyup="CheckPassword_Debounce(this);" name="loginPw" class="w-full input input-bordered  max-w-xs" placeholder="비밀번호를 입력해주세요" />
												<div class="checkloginPw-msg"></div></td>
										</tr>
										<tr>
												<th>비밀번호 확인</th>
										</tr>
										<tr>
												<td><input onkeyup="CheckPasswordConfirm_Debounce(this);" name="loginPwConfirm" class="w-full input input-bordered  max-w-xs"
														placeholder="비밀번호 확인을 입력해주세요" />
														<div class="checkloginPwConfirm-msg"></div></td>
										</tr>
										<tr>
												<th>이름</th>
										</tr>
										<tr>
												<td><input onkeyup="CheckName_Debounce(this);" name="name" class="w-full input input-bordered  max-w-xs" placeholder="이름을 입력해주세요" />
												<div class="checkName-msg"></div></td>
										</tr>
										<tr>
												<th>닉네임</th>
										</tr>
										<tr>
												<td><input onkeyup="CheckNickName_Debounce(this);" name="nickname" class="w-full input input-bordered  max-w-xs" placeholder="닉네임을 입력해주세요" />
												<div class="checkNickName-msg"></div></td>
										</tr>
										<tr>
												<th>전화번호</th>
										</tr>
										<tr>
												<td><input onkeyup="CheckCellphoneNum_Debounce(this);" name="cellphoneNum" class="w-full input input-bordered  max-w-xs" placeholder="전화번호를 입력해주세요" />
												<div class="checkCellphoneNum-msg"></div></td>
										</tr>
										<tr>
												<td>
														<button class="btn btn-active btn-ghost" type="submit" value="회원가입">회원가입</button>
												</td>
										</tr>
								</tbody>

						</table>
				</form>
		</div>

		<div class="mx-auto btns">
				<button class="btn-text-link btn btn-active btn-ghost" type="button" onclick="history.back();">뒤로가기</button>
		</div>
</section>
<style>

form {
	width: 500px;
}
</style>

<%@ include file="../common/foot.jspf"%>