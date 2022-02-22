<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>company/welcome.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap" rel="stylesheet">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
		<div class="clear"></div>
		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="./welcome.jsp">환영합니다</a></li>
				<li><a href="./about_us.jsp">About Us</a></li>
				<li><a href="./about_service.jsp">서비스 소개</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article id="com">
			<h1>환영합니다 Chef 여러분!</h1>
			<p>
			본인들만이 가지고 있는 맛있는 레시피를 많이 공유해주세요!
			그리고 즐겁게 요리해주세요~
			</p>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


