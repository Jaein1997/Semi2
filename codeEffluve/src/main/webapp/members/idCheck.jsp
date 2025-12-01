<%@page import="javax.swing.text.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 중복확인</title>
<link rel="stylesheet" type="text/css" href="/codeEffluve/css/mainLayout.css">
<style>
	body {
		background:#FAF7F9;
		display: flex;
		padding-left: 0px;
		padding-right: 0px;
		justify-content: center;
	}
</style>
</head>

<body>
	
		<div id="idCheckDiv">
		<form name="findID" action="idCheck_ok.jsp">
			<h2 style="text-align:center; color: rgb(109, 16, 68)">ID 중복확인</h2>
			<div>
				<input type="text" name="findid" maxlength="20" id="findid">
				<input type="submit" value="중복확인" id="idbtn" disabled>
			</div>
			
			</form>
			<span id="idSpan"></span>
		</div>
	
</body>
<script>
var idbtn = document.getElementById("idbtn");
var findid = document.getElementById("findid");
var idSpan = document.getElementById("idSpan");
findid.onchange= function () {
	var thistext = findid.value;
	var count = 0;
	if (thistext.length < 5 || thistext.length > 20) {
		idSpan.innerHTML = '* 아이디: 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.';
	    idbtn.disabled = true;
	    return;
	}
	for (var i = 0; i<thistext.length; i++) {
		var ch = thistext.charAt(i);
		if(!((ch >= '0' && ch <= '9') || (ch>='a' && ch<='z') || (ch=='-') || (ch=='='))) {
			count++;
			idSpan.innerHTML = '* 아이디: 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.';
			idbtn.disabled = true;
			break;
		}
		
	}
	if (count==0) {
		idbtn.disabled = false;
	}
	
}
</script>
</html>