<%@page import="dao.ComplainDAO"%>
<%@page import="dto.ComplainDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

ComplainDTO complainDTO = new ComplainDTO();

complainDTO.setOriginNO(Integer.parseInt(request.getParameter("originNO")));
complainDTO.setGroupOrd(Integer.parseInt(request.getParameter("groupOrd")));
complainDTO.setGroupLayer(Integer.parseInt(request.getParameter("groupLayer")));
complainDTO.setName(request.getParameter("name"));
complainDTO.setPassword(request.getParameter("password"));
complainDTO.setSubject(request.getParameter("subject"));
complainDTO.setContent(request.getParameter("content"));

ComplainDAO complainDAO = new ComplainDAO();
int insertCount = complainDAO.insertComplainQnA(complainDTO);

if(insertCount > 0){
	
	response.sendRedirect("./complain.jsp");
	
} else {%>

	<script type="text/javascript">
		alert("글쓰기에 실패하였습니다!")
		history.back();
	</script>
	
<%}%>