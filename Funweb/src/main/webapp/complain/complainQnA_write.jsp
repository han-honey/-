<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
int originNO = Integer.parseInt(request.getParameter("originNO"));
int groupOrd = Integer.parseInt(request.getParameter("groupOrd"));
int groupLayer = Integer.parseInt(request.getParameter("groupLayer"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>complain/complainQnA_write.jsp</title>
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
		
		<article>
		
			<h1>고객센터 답글쓰기</h1>
			
			<form action="./complainQnA_writePro.jsp" method="post">
				<input type="hidden" name="originNO" value="<%=originNO%>">
				<input type="hidden" name="groupOrd" value="<%=groupOrd%>">
				<input type="hidden" name="groupLayer" value="<%=groupLayer%>">
			
				<table id="notice">

					<tr>
						<td>작성자</td>
						<td><input type="text" name="name" value=<%=session.getAttribute("sessionId") %> readonly="readonly" required="required"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="password" required="required"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" required="required" value="↪ RE : "></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="10" cols="20" name="content" required="required"></textarea></td>
					</tr>

				</table>

				<div id="table_search">
					<input type="button" value="뒤로가기" class="btn" onclick="history.back()">
					<input type="button" value="목록" class="btn" onclick="location.href='./complain.jsp'">
					<input type="submit" value="글쓰기" class="btn">
				</div>
				
			</form>
			
			<div class="clear"></div>
			
		</article>

		<div class="clear"></div>
		
		<jsp:include page="../inc/bottom.jsp" />
		
	</div>
	
</body>
</html>


