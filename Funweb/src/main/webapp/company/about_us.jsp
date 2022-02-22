<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>company/about_us.jsp</title>
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
			<h1>About Us!</h1>
					<h2>회사소개</h2>
						<p style="line-height: 30px;">에이치프로젝트(Hproject)는 2022년 1월 1일 설립하여 대한민국의 먹거리를 책임질 막중한 임무를 가지고 설립되었습니다</p>
					<h2>문제인식</h2>
						<p style="line-height: 30px;">음식배달시장의 규모가 해를 거듭할수록 커져만 갑니다<br>배달시장에 몸을 담고 있는 사람이라면 이 시국에 더할나위 없는 희망이죠<br>
						하지만, 보통 배달음식뿐만 아니라 일반 음식점에서 판매하고 있는 모든 음식은 맵고, 짜고, 달고, 너무 자극적입니다<br>
						그리고 점점 집에서 만들어 먹는것은 <Strong>그냥 귀찮고 이젠 하지 않는 일</Strong>... 이라는 생각이 팽배해져 갑니다<br>
						분명 흐름은 음식배달시장의 성장으로 가고 있는것은 맞지만 10년,20년 후... 그때는 정말 많은 사람들이 요리라는것을
						못하게 될 지 모릅니다 이제는 점점 김장을 하지 않는것처럼...<br>
						물론 아직 김장을 하는 집이 있긴합니다 그러나 김장하는 법을 아는 10대~30대는 잘 없습니다 <br>
						현재는 배달음식과 집밥을 겸하고 있지만 언젠가는 100% 배달음식에 의존하게 된다면 우리의 통장과 건강은 생각보다 많은 타격을 입을지도 모릅니다</p>
					<h2>솔루션</h2>
						<p style="line-height: 30px;">저희는 요리가 힘들고 어려운것이라는 생각에서 쉽고 재미있고 건강과 내 경제적인 부분까지 챙겨줄 수 있는 '재미있는' 것으로
						만들어가려고 합니다</p>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


