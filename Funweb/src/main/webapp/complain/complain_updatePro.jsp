<%@page import="dto.ComplainDTO"%>
<%@page import="dao.ComplainDAO"%>
<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num"));
int originNO = Integer.parseInt(request.getParameter("originNO"));
int pageNum = Integer.parseInt(request.getParameter("page"));
String password = request.getParameter("password");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
String id = request.getParameter("id");

ComplainDAO complainDAO = new ComplainDAO();
ComplainDTO complainDTO = new ComplainDTO();

complainDTO.setPassword(password);
complainDTO.setNum(num);
complainDTO.setSubject(subject);
complainDTO.setContent(content);

int updateCount = complainDAO.updateComplain(complainDTO);

if(updateCount > 0){
	
	response.sendRedirect("./complain_content.jsp?num="+num+"&page="+pageNum+"&originNO="+originNO);
	
} else {%>

	<script type="text/javascript">
		alert("글수정 실패!");
		history.back();
	</script>
	
<%}%>