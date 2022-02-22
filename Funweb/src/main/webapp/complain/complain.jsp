<%@page import="java.util.ArrayList"%>
<%@page import="dao.ComplainDAO"%>
<%@page import="dto.ComplainDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>complain/complain.jsp</title>
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
		
			<h1>고객센터</h1>
			
			<table id="notice">
			
				<tr>
					<th class="tno">번호</th>
					<th class="ttitle">제목</th>
					<th class="twrite">작성자</th>
					<th class="tdate">작성일</th>
					<th class="tread">조회수</th>
				</tr>
				
				<%
				ComplainDAO complainDAO = new ComplainDAO();
				int pageNum = 1;
				if(request.getParameter("page") != null){
					pageNum = Integer.parseInt(request.getParameter("page"));
				}
				int listCount = complainDAO.getListCount();
				int listLimit = 10;
				int pageLimit = 10;
				int maxPage = (int)Math.ceil((double)listCount / listLimit);
				int startPage = ((int)((double)pageNum / pageLimit + 0.9) - 1) * pageLimit + 1;
				int endPage = startPage + pageLimit - 1;
				if(endPage > maxPage){
					endPage = maxPage;
				}
				
				ArrayList<ComplainDTO> list = complainDAO.selectComplainList(pageNum, listLimit);
				
				if(list != null && list.size() > 0){
					for(ComplainDTO dto : list){
					%>
					
					<tr onclick="location.href='complain_content.jsp?num=<%=dto.getNum()%>&page=<%=pageNum%>&originNO=<%=dto.getOriginNO()%>'">
						<td><%=dto.getNum()%></td>
						<td><%=dto.getSubject()%></td>
						<td><%=dto.getName()%></td>
						<td><%=dto.getDate()%></td>
						<td><%=dto.getReadCount()%></td>
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
			<div id="table_search">
			
				<input type="button" value="글쓰기" class="btn" onclick="location.href='./complain_write.jsp'">
				
			</div>
			
			<div id="table_search">
			
				<form action="./complain_search.jsp" method="post">
				
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
				
					<a href="./complain.jsp?page=<%=pageNum - 1 %>">Prev</a>
				
				<%}
				
				for(int i = startPage; i <= endPage; i++){
					
					if(i == pageNum){%>
					
						<%=i %>	
						
					<%} else {%>
					
						<a href="./complain.jsp?page=<%=i %>"><%=i %></a>
						
					<%}
				}%>
				
				<%if(pageNum == endPage) {%>
				
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Next
				
				<%} else { %>
				
					<a href="./complain.jsp?page=<%=pageNum + 1  %>">Next</a>
				
				<%} %>

			</div>
			
		</article>

		<div class="clear"></div>
		
		<jsp:include page="../inc/bottom.jsp" />
		
	</div>
	
</body>
</html>


