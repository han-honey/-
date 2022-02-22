<%@page import="dao.RecipeReplyDAO"%>
<%@page import="dao.RecipeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num"));
String password = request.getParameter("password");
String culture = request.getParameter("culture");

RecipeDAO recipeDAO = new RecipeDAO();
int deleteCount = recipeDAO.deleteRecipe(num,password);
recipeDAO.updateNumber();

if(deleteCount > 0){
	RecipeReplyDAO recipeReplyDAO = new RecipeReplyDAO();
	recipeReplyDAO.deleteAllReply(num);
%>
	<script type="text/javascript">
		alert("게시물 번호를 재정렬 하였습니다");
		location.href = "./recipe_<%=culture%>.jsp?culture=<%=culture%>";
	</script>
	
<%} else {%>

	<script type="text/javascript">
		alert("글삭제에 실패하였습니다")
		history.back();
	</script>
	
<%}%>