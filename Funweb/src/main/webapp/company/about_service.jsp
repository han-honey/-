<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>company/서비스소개.jsp</title>
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
			<h1>서비스 소개</h1>
			
			 <p style="line-height: 30px;">첫번째! 보다 편한 조작법으로 음성인식을 사용하여 동영상의 전,후로 자유롭게 이동할 수 있습니다<br><br>
			 두번째! 여러 사람들과의 소통을 통해서 보다 많은 정보를 얻을 수 있다<br><br>
			 세번째! 자신이 만든 음식을 업로드해서 다양한 사람들의 의견을 얻을 수 있다<br><br>
			 네번째! 만약 자신이 업로드한 음식의 정보가 많은 이들에게 도움이 되고 추천을 많이 받았다면<br>해당 주(week)의 베스트레시피로 등록되고
			         포인트를 지급받을 수 있다</p>
			
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


