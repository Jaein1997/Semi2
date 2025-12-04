<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/makeAccount.css"> 
<style>
	#profileImg {
		width: 200px;
		height: 200px;
	}
	body {
		background:#FAF7F9;
		display: flex;
		padding-left: 0px;
		padding-right: 0px;
		justify-content: center;
	}
</style>
<script>
	function openCheck() {
		window.open('idCheck.jsp', 'idCheck', 'width=500,height=200,top=150px,left=700px');
		
	}
</script>
</head>
<body>
	
		<section id="makeAccount">
			<div>
				<img src="/codeEffluve/img/leLogo1.png" alt="leLogo1" id="makeAccountLogo">
				<h1>회원가입</h1>
			</div>
			
			<form name="makeAccount" action="makeAccount_ok.jsp" method="post" enctype="multipart/form-data">
				<!--
				<div>
					<img src="http://localhost:9090/codeEffluve/membersProfiles/basic.jpg" alt="basic" id="profileImg">
					<input type="file" name="m_profile">
				</div>
				  -->
				<table>
					<tr>
						<td><img src="/codeEffluve/img/idIcon.png" alt="id"><input type="text" name="id" placeholder="아이디" required readonly><input type="button" value="중복확인" id="checkbtn"></td>
					</tr>
					<tr>
						<td><img src="/codeEffluve/img/pwdIcon.png" alt="pwd"><input type="password" name="pwd" placeholder="비밀번호" maxlength="16" required id="pwdText"></td>
					</tr>
				</table>
				<span id="pwdSpan"></span>
				<table>
					<tr>
						<td><img src="/codeEffluve/img/idIcon.png" alt="name"><input type="text" name="m_name" placeholder="이름" required></td>
					</tr>
					<tr>
						<td><input type="radio" name="sex" value="m" checked>남자<input type="radio" name="sex" value="f">여자<input type="radio" name="sex" value="n">선택안함</td>
					</tr>
					<tr>
						<td><img src="/codeEffluve/img/birthdayIcon.png" alt="birthday">생년월일&nbsp;<input type="date" name="birthday" required></td>
					</tr>
					<tr>
						<td><img src="/codeEffluve/img/telIcon.png" alt="tel"><input type="text" name="tel" placeholder="휴대전화번호" maxlength="11" required id="telText"></td>
						
					</tr>
					
					
				</table>
				<span id="telSpan"></span>
				<div class="makeAccountBtns">
					<input type="submit" value="가입" id="makeAccountBtn" disabled>
					<input type="button" value="취소" id="backbtn">
				</div>
			</form>
		</section>
	
</body>

<script>
	var makeAccountBtn = document.getElementById("makeAccountBtn");
	var pwdText = document.getElementById("pwdText");
	var telText = document.getElementById("telText");
	var pwdSpan = document.getElementById("pwdSpan");
	var telSpan = document.getElementById("telSpan");
	
	var backbtn = document.getElementById("backbtn");
	backbtn.onclick = function() {
		location.href='/codeEffluve/index.jsp';
	}
	
	var checkbtn = document.getElementById("checkbtn");
	checkbtn.onclick= function() {
		openCheck();
	}
	
	
	pwdText.onchange = function() {
		var thistext = pwdText.value;
		var countp = 0;
		
		if (thistext.length < 8 || thistext.length > 16) {
		    pwdSpan.innerHTML = '* 비밀번호: 8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.';
		    makeAccountBtn.disabled = true;
		    return;
		  }
		
		for (var i = 0; i<thistext.length; i++) {
			var ch = thistext.charAt(i);
			if(!(ch >= '!' && ch <='~')) {
				countp++;
				pwdSpan.innerHTML = '* 비밀번호: 8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.';
				makeAccountBtn.disabled = true;
				break;
			}
			
		}
		if (countp==0) {
			pwdSpan.innerHTML = '';
			makeAccountBtn.disabled = false;
		}
	}
	
	telText.onchange= function () {
		var thistext = telText.value;
		var countt = 0;
		
		if (thistext.length != 11) {
		    telSpan.innerHTML = '* 휴대전화번호가 정확한지 확인해 주세요.';
		    makeAccountBtn.disabled = true;
		    return;
		  }
		
		for (var i = 0; i<thistext.length; i++) {
			var ch = thistext.charAt(i);
			if(!(ch >= '0' && ch <= '9')) {
				countt++;
				telSpan.innerHTML = '* 휴대전화번호가 정확한지 확인해 주세요.';
				makeAccountBtn.disabled = true;
				break;
			}
			
		}
		if (countt==0) {
			telSpan.innerHTML = '';
			makeAccountBtn.disabled = false;
		}
		
	}
</script>
</html>