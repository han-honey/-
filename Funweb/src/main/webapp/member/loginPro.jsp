<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String password = request.getParameter("pass");

MemberDAO dao = new MemberDAO();
boolean isLogin = dao.checkUser(id, password);


if(isLogin){
// 	response.sendRedirect("../main/main.jsp");
	%>
	<script type="text/javascript">
		location.href="../main/main.jsp";
	</script>
	<%
	
	session.setAttribute("sessionId", id);
// 만약, 로그인 상태를 자동으로 해제하지 않으려면(세션타이머를 무한대로 설정하려면)
// session 객체의 setMaxInactiveInterval() 메서드

	session.setMaxInactiveInterval(0);
} else {
	%>
	<script type="text/javascript">
		alert("아이디 또는 비밀번호 오류!")
		history.back();
	</script>
	<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>