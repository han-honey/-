<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/join.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap" rel="stylesheet">
<script type="text/javascript">


function checkDuplicateId() {
	window.open("check_id.jsp","아이디 중복 확인","width=500,height=300");
	
}
function checkPassword(pass2) {
	var pass_span = document.getElementById("retypePassCheckResult");
	
	var pass = document.fr.pass.value;
	if(pass == pass2){
		pass_span.innerHTML = "패스워드 일치";
		pass_span.style.color = "GREEN";
	} else {
		pass_span.innerHTML = "패스워드 불일치";
		pass_span.style.color = "RED";
	}
}
</script>

</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp"></jsp:include>
		  <div class="clear"></div>  
		  <nav id="sub_menu">
		  	<ul>
		  		<li><a href="#">로그인 페이지</a></li>
		  		<li><a href="#">Privacy policy</a></li>
		  	</ul>
		  </nav>
		  <article>
		  	<h1>회원가입 페이지</h1>
		  	<form action="joinPro.jsp" method="post" id="join" name="fr">
		  		<fieldset>
		  			<legend>정보입력창<span style="color:red"><small>&nbsp;&nbsp;&nbsp;(필수사항)</small></span></legend>
		  			<label>아이디</label>
		  			<input type="text" name="id" class="id" id="id" readonly="readonly" >
		  			<input type="button" value="아이디중복확인" class="dup" id="btn" onclick="checkDuplicateId()" required="required"><br>
		  			
		  			<label>비밀번호</label>
		  			<input type="password" name="pass" id="pass" required="required" ><br> 			
		  			
		  			<label>비밀번호 확인</label>
		  			<input type="password" name="pass2" id="pass2" onkeyup="checkPassword(this.value)">
		  			<span id="retypePassCheckResult"><!-- 패스워드 일치 여부 결과 표시하는 영역 --></span><br>
		  			
		  			<label>이름</label>
		  			<input type="text" name="name" id="name" required="required"><br>
		  			
		  			<label>이메일</label>
		  			<input type="email" name="email" id="email" required="required"><br>
		  			
		  			<label>핸드폰 번호</label>
		  			<input type="text" name="mobile" required="required"><br>
		  		</fieldset>
		  		
		  		<fieldset>
		  			<legend>선택사항</legend>
		  			<label>주소</label>
		  			<input type="text" name="address" ><br>
		  			<label>유선 전화</label>
		  			<input type="text" name="phone" ><br>
		  		</fieldset>
		  		<div class="clear"></div>
		  		<div id="buttons">
		  			<input type="submit" value="Submit" class="submit">
		  			<input type="reset" value="Cancel" class="cancel">
		  		</div>
		  	</form>
		  </article>
		  
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


