<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<style>
	#profileImg {
		width: 200px;
		height: 200px;
	}
</style>
<script>
	function openCheck() {
		window.open('idCheck.jsp', 'idCheck', 'width=450, height=300');
		
	}
	
	
	function onlyNum(input) {
		var value = input.value;
		var result = "";

		for (var i = 0; i < value.length; i++) {
			var ch = value.charAt(i);

			if (ch >= '0' && ch <= '9') {
				result += ch;
			}
		}

		if (value != result) {
			input.value = result;
		}
	}
</script>
</head>
<body>
	
	<main>
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
						<td><img src="/codeEffluve/img/pwdIcon.png" alt="pwd"><input type="password" name="pwd" placeholder="비밀번호" required></td>
					</tr>
				</table>
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
						<td><img src="/codeEffluve/img/telIcon.png" alt="tel"><input type="text" name="tel" placeholder="휴대전화번호" required oninput="onlyNum(this)"></td>
					</tr>
					
					
				</table>
				<div class="makeAccountBtns">
					<input type="submit" value="가입">
					<input type="button" value="취소" id="backbtn">
				</div>
			</form>
		</section>
	</main>
	
	<%@include file="/footer.jsp" %>
</body>

<script>
	var backbtn = document.getElementById("backbtn");
	backbtn.onclick = function() {
		location.href='/codeEffluve/index.jsp';
	}
	
	var checkbtn = document.getElementById("checkbtn");
	checkbtn.onclick= function() {
		openCheck();
	}
</script>
</html>