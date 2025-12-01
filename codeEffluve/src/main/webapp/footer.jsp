<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<footer>
	<div class="footerLogo">
		<img src="/codeEffluve/img/ceLogo.png" alt="ceLogo" id="ceLogo">code Effluve
	</div>
	
	<div>Copyright &copy; 쌍용. All Rights Reserved.</div>
</footer>
<script>
	var clickCount = 0;
	document.onload = function() {
		clickCount = 0;
	}
	var ceLogo = document.getElementById("ceLogo");
	ceLogo.onclick = function() {
		clickCount++;
		if(clickCount==5) {
			window.open('/codeEffluve/admin/admin.jsp', '_blank');
		}
	}
</script>