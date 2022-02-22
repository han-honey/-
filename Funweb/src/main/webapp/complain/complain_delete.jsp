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
<title>complain/complain_delete.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap" rel="stylesheet">
</head>
<body>

	<div id="wrap">
		<jsp:include page="../inc/top.jsp" />

		<article>
		
			<h1>고객센터 글삭제</h1>
			
			<form action="complain_deletePro.jsp" method="post">
				<input type="hidden" name="num" value="<%=num%>">
				
				<table id="notice">
				
					<tr>
						<td>패스워드</td>
						<td><input type="password" name="password" ></td>
					</tr>
					
				</table>

				<div id="table_search">
					<input type="button" value="뒤로가기" class="btn" onclick="history.back()">
					<input type="button" value="목록" class="btn" onclick="location.href='./complain.jsp'">
					<input type="submit" value="글삭제" class="btn">
				</div>
				
			</form>
			
			<div class="clear"></div>
			
		</article>

		<div class="clear"></div>
		
		<jsp:include page="../inc/bottom.jsp" />
		
	</div>
	
</body>
</html>


