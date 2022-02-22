<%@page import="dto.CommunityDTO"%>
<%@page import="dao.CommunityDAO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String name = request.getParameter("name");

if(!session.getAttribute("sessionId").equals(name)){
	%>
	<script type="text/javascript">
		alert("본인의 게시물이 아닙니다 수정 불가능!")
		history.back();
	</script>
	<%
}
request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num"));
int pageNum = Integer.parseInt(request.getParameter("page"));

CommunityDAO dao = new CommunityDAO();
CommunityDTO dto = dao.selectCommunity(num);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/community_update.jsp</title>
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
		
		<article>
		
			<h1>공지사항 글수정</h1>
			
			<form action="community_updatePro.jsp" method="post">
				<input type="hidden" name="num" value="<%=num%>">
				<input type="hidden" name="page" value="<%=pageNum%>">
				
				<table id="notice">
				
					<tr>
						<td>패스워드</td>
						<td><input type="password" name="password" ></td>
					</tr>
					<tr>
						<td>글쓴이</td>
						<td><input type="text" name="name" value="<%=dto.getName()%>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" value="<%=dto.getSubject()%>"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="10" cols="20" name="content"><%=dto.getContent()%></textarea></td>
					</tr>
					
				</table>

				<div id="table_search">
				
					<input type="submit" value="글수정" class="btn">
					
				</div>
				
			</form>
			
			<div class="clear"></div>
			
		</article>


		<div class="clear"></div>
		
		<jsp:include page="../inc/bottom.jsp" />
		
	</div>
	
</body>
</html>


