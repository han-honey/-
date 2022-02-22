<%@page import="dao.RecipeDAO"%>
<%@page import="dto.RecipeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
RecipeDTO recipeDTO = new RecipeDTO();
request.setCharacterEncoding("UTF-8");

if(!request.getParameter("culture").equals("")){
	
	recipeDTO.setName(request.getParameter("name"));
	recipeDTO.setPassword(request.getParameter("password"));
	recipeDTO.setSubject(request.getParameter("subject"));
	recipeDTO.setContent(request.getParameter("content"));
	recipeDTO.setCulture(request.getParameter("culture"));
	
} else {%>

	<script type="text/javascript">
		alert("카테고리를 입력해주세요");
		history.back();
	</script>
	
<%}

RecipeDAO recipeDAO = new RecipeDAO();
int insertCount = recipeDAO.insertRecipe(recipeDTO);

if(insertCount > 0){
	
	response.sendRedirect("./recipe_"+request.getParameter("culture")+".jsp");
	
} else {%>

	<script type="text/javascript">
		alert("글쓰기에 실패하였습니다!")
		history.back();
	</script>
	
<%}%>