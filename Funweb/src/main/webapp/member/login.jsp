<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/login.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap" rel="stylesheet">
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<div class="clear"></div>
		  <nav id="sub_menu">
		  	<ul>
		  		<li><a href="#">회원가입</a></li>
		  		<li><a href="#">Privacy policy</a></li>
		  	</ul>
		  </nav>
		  <!-- 본문 내용 -->
		  <article>
		  	<h1>로그인 페이지</h1>
		  	<form action="loginPro.jsp" method="post" id="join">
		  		<fieldset>
		  			<legend>로그인</legend>
		  			<label>아이디</label>
		  			<input type="text" name="id" required="required"><br>
		  			
		  			<label>비밀번호</label>
		  			<input type="password" name="pass" required="required"><br>
		  			
		  			<input type="checkbox" value="remember_id">ID 기억하기&nbsp;&nbsp;
		  			<input type="checkbox" value="remember_login">패스워드 기억
		  		</fieldset>
		
		  		<div class="clear"></div>
		  		<div id="buttons">
		  			<input type="submit" value="Submit" class="submit">
		  			<input type="reset" value="Cancel" class="cancel">
		  		</div>
		  	</form>
		  </article>
		  
		  
		<div class="clear"></div>  
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
	</div>
</body>
</html>


