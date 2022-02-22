<%@page import="dao.ContestDAO"%>
<%@page import="dto.ContestDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

ContestDTO contestDTO = new ContestDTO();

contestDTO.setName(request.getParameter("name"));
contestDTO.setPassword(request.getParameter("password"));
contestDTO.setSubject(request.getParameter("subject"));
contestDTO.setContent(request.getParameter("content"));

ContestDAO dao = new ContestDAO();
int insertCount = dao.insertContest(contestDTO);

if(insertCount > 0){
	
	response.sendRedirect("./contest.jsp");
	
} else {%>

	<script type="text/javascript">
		alert("글쓰기에 실패하였습니다!")
		history.back();
	</script>
	
<%}%>