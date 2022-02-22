<%@page import="dto.RecipeDTO"%>

<%@page import="dao.RecipeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String password = request.getParameter("password");
int num = Integer.parseInt(request.getParameter("num"));
String subject = request.getParameter("subject");
String content = request.getParameter("content");
int pageNum = Integer.parseInt(request.getParameter("page"));
String culture = request.getParameter("culture");

RecipeDAO recipeDAO = new RecipeDAO();
RecipeDTO recipeDTO = new RecipeDTO();

recipeDTO.setPassword(password);
recipeDTO.setNum(num);
recipeDTO.setSubject(subject);
recipeDTO.setContent(content);

int updateCount = recipeDAO.updateRecipe(recipeDTO);

if(updateCount > 0){
	
	response.sendRedirect("./recipe_content.jsp?num=" + num + "&page=" + pageNum +"&culture=" + culture);
	
} else {%>

	<script type="text/javascript">
		alert("글수정 실패!");
		history.back();
	</script>
	
<%}%>