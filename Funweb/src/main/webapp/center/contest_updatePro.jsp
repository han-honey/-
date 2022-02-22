<%@page import="dto.ContestDTO"%>
<%@page import="dao.ContestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String password = request.getParameter("password");
int num = Integer.parseInt(request.getParameter("num"));
int pageNum = Integer.parseInt(request.getParameter("page"));
String subject = request.getParameter("subject");
String content = request.getParameter("content");

ContestDAO contestDAO = new ContestDAO();
ContestDTO contestDTO = new ContestDTO();

contestDTO.setPassword(password);
contestDTO.setNum(num);
contestDTO.setSubject(subject);
contestDTO.setContent(content);

int updateCount = contestDAO.updateContest(contestDTO);

if(updateCount > 0){
	
	response.sendRedirect("./contest_content.jsp?num=" + num + "&page=" + pageNum);
	
} else {%>

	<script type="text/javascript">
		alert("글수정 실패!");
		history.back();
	</script>
	
<%}%>