<%@page import="dao.ComplainReplyDAO"%>
<%@page import="dao.ComplainDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num"));
String password = request.getParameter("password");

ComplainDAO complainDAO = new ComplainDAO();
int deleteCount = complainDAO.deleteComplain(num,password);

if(deleteCount > 0 ){
	
	response.sendRedirect("./complain.jsp");
	
	} else {%>

	<script type="text/javascript">
		alert("글삭제에 실패하였습니다")
		history.back();
	</script>
	
<%}%>