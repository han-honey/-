<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

request.setCharacterEncoding("UTF-8");

String id = (String) session.getAttribute("sessionId");
if (id == null || id.equals(""))
%>

	<script type="text/javascript">
		alert("회원만 접근 가능합니다!")
		location.href="../member/login.jsp";
	</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice.jsp</title>
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
			<h1>공지사항</h1>
			<table id="notice">
				<tr>
					<th class="tno">번호</th>
					<th class="ttitle">제목</th>
					<th class="twrite">작성자</th>
					<th class="tdate">작성일</th>
					<th class="tread">조회수</th>
				</tr>
				<%

						BoardDAO boardDAO = new BoardDAO();
						int pageNum = 1;
						if(request.getParameter("page") != null){
							pageNum = Integer.parseInt(request.getParameter("page"));
						}
						int listCount = boardDAO.getListCount();
						int listLimit = 3;
						int pageLimit = 10;
						int maxPage = (int)Math.ceil((double)listCount / listLimit);
						int startPage = ((int)((double)pageNum / pageLimit + 0.9) - 1) * pageLimit + 1;
						int endPage = startPage + pageLimit - 1;
						if(endPage > maxPage){
							endPage = maxPage;
						}
						
						ArrayList<BoardDTO> list = boardDAO.selectBoardList(pageNum, listLimit);
						
						if(list != null && list.size() > 0){
							for(BoardDTO dto : list){
				%>
					<tr onclick="location.href='notice_content.jsp?num=<%=dto.getNum()%>&page=<%=pageNum%>'">
						<td><%=dto.getNum()%></td>
						<td><%=dto.getSubject()%></td>
						<td><%=dto.getName()%></td>
						<td><%=dto.getDate()%></td>
						<td><%=dto.getReadcount()%></td>
					</tr>
					<%
					}
				} else {
				%>
					<tr>
						<td colspan="5">작성된 게시물이 없습니다!</td>
					</tr>
				<%}	%>
			</table>
			<%
			try{
				
				if(id.equals("admin")){ // 관리자만 공지사항에 글쓰기 가능
			%> 
					<div id="table_search">
						<input type="button" value="글쓰기" class="btn" onclick="location.href='./notice_write.jsp'">
					</div>
				
				<%}
				
			} catch(Exception e) {
				
				e.printStackTrace();
			
			} finally {%>
			
			<div id="table_search">
				<form action="./notice_search.jsp" method="post">
					<select name="searchOption">
						<option value="subject">제목</option>
						<option value="name">작성자</option>
						<option value="subjectName">제목+작성자</option>
					</select>
					<input type="text" name="search" class="input_box">
					<input type="submit" value="Search" class="btn">
				</form>
			</div>
			
			<div class="clear"></div>
			
			<div id="page_control">
			
				<%if(pageNum == startPage) {%>
				
					Prev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<%} else { %>
				
					<a href="./notice.jsp?page=<%=pageNum - 1 %>">Prev</a>
				
				<%} %>
				
				<% for(int i = startPage; i <= endPage; i++){
					
						if(i == pageNum){%>
						
							<%=i %>	
							
						<%} else {%>
						
							<a href="./notice.jsp?page=<%=i %>"><%=i %></a>
							
						<%}
				}%>
				
				<%if(pageNum == endPage) {%>
				
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Next
				
				<%} else { %>
				
					<a href="./notice.jsp?page=<%=pageNum + 1  %>">Next</a>
				
				<%} %>

			</div>
			
		</article>
	
		<div class="clear"></div>
		
		<jsp:include page="../inc/bottom.jsp" />
		
	</div>
	
</body>
</html>
<%} %>

