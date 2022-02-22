<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");
String password = request.getParameter("password");

MemberDAO memberDAO = new MemberDAO();
int deleteCount = memberDAO.deleteMember(id, password);

if(deleteCount > 0){
	
	response.sendRedirect("../main/main.jsp");
	session.invalidate();
	
} else {%>

	<script type="text/javascript">
		alert("비밀번호가 틀렸습니다");
		history.back();
	</script>
	
<%}%>