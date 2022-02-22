<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String name = request.getParameter("name");

if(!session.getAttribute("sessionId").equals(name)){
	%>
	<script type="text/javascript">
		alert("본인의 게시물이 아닙니다 삭제 불가능!")
		history.back();
	</script>
	<%
}
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/community_delete.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap" rel="stylesheet">
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp" />
		<div class="clear"></div>
		<nav id="sub_menu">
			<ul>
				<li><a href="./notice.jsp">공지사항</a></li>
				<li><a href="./contest.jsp">천하제일 요리대회</a></li>
				<li><a href="./driver.jsp">파일 다운로드 게시판</a></li>
				<li><a href="./community.jsp">커뮤니티</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>공지사항 글삭제</h1>
			<form action="community_deletePro.jsp" method="post">
				<input type="hidden" name="num" value="<%=num%>">
				<table id="notice">
					<tr>
						<td>패스워드</td>
						<td><input type="password" name="password" ></td>
					</tr>
				</table>

				<div id="table_search">
					<input type="submit" value="글삭제" class="btn">
				</div>
			</form>
			<div class="clear"></div>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


