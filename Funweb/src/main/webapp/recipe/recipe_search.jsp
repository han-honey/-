<%@page import="dao.RecipeDAO"%>
<%@page import="dto.RecipeDTO"%>
<%@page import="dao.BoardDAO"%>
<%@page import="dto.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String search = request.getParameter("search");
String searchOption = request.getParameter("searchOption");
String culture = request.getParameter("culture");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/recipe_search.jsp</title>
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
				<li><a href="./recipe_k.jsp">한국인은 역시 <Strong>한식</Strong></a></li>
				<li><a href="./recipe_w.jsp">맛스럽고 멋스러운 <Strong>양식</Strong></a></li>
				<li><a href="./recipe_j.jsp">깔끔하고 고급스러운 <Strong>일식</Strong></a></li>
				<li><a href="./recipe_c.jsp">화려하고 화끈한 <Strong>중식</Strong></a></li>
			</ul>
			
		</nav>
		
		<article>
		
			<%if(culture.equals("k")) {%>
			
				<h1>한식 레시피</h1>
				
			<%} else if(culture.equals("w"))  { %>
			
				<h1>양식 레시피</h1>
				
			<%} else if(culture.equals("j"))  { %>
			
				<h1>일식 레시피</h1>
				
			<%} else if(culture.equals("c"))  { %>
			
				<h1>중식 레시피</h1>
				
			<%} %>
			
			<table id="notice">
			
				<tr>
					<th class="tno">번호</th>
					<th class="ttitle">제목</th>
					<th class="twrite">작성자</th>
					<th class="tdate">작성일</th>
					<th class="tread">조회수</th>
				</tr>
				<%
				RecipeDAO recipeDAO = new RecipeDAO();
				int pageNum = 1;
				if(request.getParameter("page") != null){
					pageNum = Integer.parseInt(request.getParameter("page"));
				}
				int listCount = recipeDAO.getListSearchCount(search,searchOption,culture);
				int listLimit = 3;
				int pageLimit = 10;
				int maxPage = (int)Math.ceil((double)listCount / listLimit);
				int startPage = ((int)((double)pageNum / pageLimit + 0.9) - 1) * pageLimit + 1;
				int endPage = startPage + pageLimit - 1;
				if(endPage > maxPage){
					endPage = maxPage;
				}
				
				ArrayList<RecipeDTO> list = recipeDAO.searchRecipeList(pageNum, listLimit, search, searchOption, culture);
				
				if(list != null && list.size() > 0){
					
				for(RecipeDTO dto : list){
				%>
				
				<tr onclick="location.href='recipe_content.jsp?num=<%=dto.getNum()%>&page=<%=pageNum%>'">
					<td><%=dto.getNum()%></td>
					<td><%=dto.getSubject()%></td>
					<td><%=dto.getName()%></td>
					<td><%=dto.getDate()%></td>
					<td><%=dto.getReadCount()%></td>
				</tr>
				
				<%}
				
				} else {
					
					%>
					<tr>
						<td colspan="5">검색결과가 없습니다.</td>
					</tr>
					
				<%}%>
				
			</table>
			
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='./recipe_write.jsp'">
			</div>
			
			<div id="table_search">
				
				<form action="./recipe_search.jsp?culture=<%=culture %>" method="post">
				
					<%if(searchOption.equals("subject")){ %>
					
						<select name="searchOption">
							<option value="subject">제목</option>
							<option value="name">작성자</option>
							<option value="subjectName">제목+작성자</option>
						</select>
						
					<%} else if(searchOption.equals("name")) {%>
					
						<select name="searchOption">
							<option value="name">작성자</option>
							<option value="subject">제목</option>
							<option value="subjectName">제목+작성자</option>
						</select>
						
					<%} else if(searchOption.equals("subjectName")) {%>
					
						<select name="searchOption">
							<option value="subjectName">제목+작성자</option>
							<option value="subject">제목</option>
							<option value="name">작성자</option>
						</select>
						
					<%} %>
					
					<input type="text" name="search" class="input_box"
					
						<%if(search != null && !search.equals("")){%> value="<%=search %>" <%}%>>
						
					<input type="submit" value="Search" class="btn">
					
				</form>
				
			</div>

			<div class="clear"></div>
			
			<div id="page_control">
			
				<%if(pageNum == startPage) {%>
				
					이전페이지&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
				<%} else { %>
				
				<a href="./recipe_search.jsp?page=<%=pageNum - 1 %>&search=<%=search%>&searchOption=<%=searchOption%>&culture=<%=culture%>">이전페이지</a>
				
				<%}%>
					
				<% for(int i = startPage; i <= endPage; i++){
					
						if(i == pageNum){%>
						
						
							<%=i %>	
							
						<%} else {%>
						
							<a href="./recipe_search.jsp?page=<%=i %>&search=<%=search%>&searchOption=<%=searchOption%>&culture=<%=culture%>"><%=i %></a>
							
						<%}
						
				}%>
				
				<%if(pageNum == endPage) {%>
				
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;다음페이지
				
				<%} else { %>
				
					<a href="./recipe_search.jsp?page=<%=pageNum + 1  %>&search=<%=search%>&searchOption=<%=searchOption%>&culture=<%=culture%>">다음페이지</a>
				
				<%}%>
				
			</div>
			
		</article>

		<div class="clear"></div>
		
		<jsp:include page="../inc/bottom.jsp" />
		
	</div>
	
</body>
</html>