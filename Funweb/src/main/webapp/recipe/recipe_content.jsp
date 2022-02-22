<%@page import="dto.RecipeReplyDTO"%>
<%@page import="dao.RecipeReplyDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.RecipeDTO"%>
<%@page import="dao.RecipeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

if(request.getParameter("num") == null || request.getParameter("num").equals("")
   || session.getAttribute("sessionId") == null || session.getAttribute("sessionId").equals("")){
	
	if(session.getAttribute("sessionId") == null || session.getAttribute("sessionId").equals("")){
%>
		<script>
			alert("먼저 로그인이 필요합니다!");
			location.href="../member/login.jsp";
		</script>
		
		<%} else {%>
		
		<script>
			alert("잘못된 접근입니다!");
			location.href="../member/join.jsp";
		</script>
		
		<%}
			
}
int num = Integer.parseInt(request.getParameter("num"));
int pageNum = Integer.parseInt(request.getParameter("page"));
String culture = request.getParameter("culture");

RecipeDAO recipeDAO = new RecipeDAO();
recipeDAO.addReadCount(num); // 조회수 1 증가
RecipeDTO recipeDTO = recipeDAO.selectRecipe(num);

RecipeReplyDAO recipeReplyDAO = new RecipeReplyDAO();
RecipeReplyDTO recipeReplyDTO = new RecipeReplyDTO();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_content.jsp</title>
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
		
			<h1>글 상세 페이지</h1>
			
			<table id="notice">
			
				<tr>
					<td>글번호</td>
					<td><%=num%></td>
					<td>글쓴이</td>
					<td><%=recipeDTO.getName()%></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><%=recipeDTO.getDate()%></td>
					<td>조회수</td>
					<td><%=recipeDTO.getReadCount()%></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><%=recipeDTO.getSubject()%></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3"><%=recipeDTO.getContent()%></td>
				</tr>
				
			</table>
			
			<table>
			
				<tr>
					<td>댓글</td>
				</tr>
				
				<%
				ArrayList<RecipeReplyDTO> recipeReplyDTOList = recipeReplyDAO.recipeReplyList(num);
				
				if(recipeReplyDTOList != null && recipeReplyDTOList.size() > 0){
					
					for(RecipeReplyDTO list : recipeReplyDTOList){
				%>
						<tr>
							<td>
								<%=list.getRecipe_reply()%> | <span id="commend"><%=list.getId()%><%=list.getDate()%></span>
								
								<span> <span onclick="window.open('./update_recipeReply.jsp?root_num=<%=num%>&page=<%=pageNum%>&num=<%=list.getNum()%>&id=<%=list.getId()%>','댓글 수정','width=500,height=300')" style="text-decoration: underline; cursor:pointer;">[수정]</span>
								| <a href="./delete_recipeReplyPro.jsp?root_num=<%=num%>&page=<%=pageNum%>&num=<%=list.getNum()%>&id=<%=list.getId()%>">[삭제]</a></span><br>
								
							</td>
						</tr>
						
					<%}
					
				} else {%>
				
					<tr>
						<td>클린한 댓글 문화를 만듭시다!</td>
					</tr>
					
				<%} %>
					
			</table>
				
					
			<form action="recipe_content_replyPro.jsp?num=<%=num %>&page=<%=pageNum %>" method="post" name="fr">
			
				<div>
					<textarea rows="4" cols="30" name="reply"></textarea>
					<input type="submit" value="댓글달기" >
				</div>
				
			</form>

			<div id="table_search">
				<input type="button" value="글수정" class="btn" onclick="location.href='recipe_update.jsp?num=<%=num%>&page=<%=pageNum%>&culture=<%=culture%>&name=<%=recipeDTO.getName()%>'">
				<input type="button" value="글삭제" class="btn" onclick="location.href='recipe_delete.jsp?num=<%=num%>&culture=<%=culture%>&name=<%=recipeDTO.getName()%>'">
				<input type="button" value="글목록" class="btn" onclick="location.href='recipe_<%=culture %>.jsp'">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='recipe_write.jsp?'">
			</div>

			<div class="clear"></div>
			
		</article>

		<div class="clear"></div>
		
		<jsp:include page="../inc/bottom.jsp" />
		
	</div>
	
</body>
</html>


