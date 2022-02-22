<%@page import="dao.MemberDAO"%>
<%@page import="dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String password = request.getParameter("pass");
String name = request.getParameter("name");
String email = request.getParameter("email");
String mobile = request.getParameter("mobile");
String address = request.getParameter("address");
String phone = request.getParameter("phone");

MemberDTO dto = new MemberDTO();
dto.setId(id);
dto.setPassword(password);
dto.setName(name);
dto.setEmail(email);
dto.setMobile(mobile);
dto.setAddress(address);
dto.setPhone(phone);

MemberDAO dao = new MemberDAO();
int insertCount = dao.insertMember(dto);

if(insertCount > 0){
	response.sendRedirect("../main/main.jsp");
} else {
	
	%>
	<script type="text/javascript">
		alert("회원가입실패!")
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
	<%
	// join.jsp 페이지로부터 전달받은 폼파라미터를 사용하여
	// MemberDAO 객체의 insertmember() 메서드를 호출하고
	// 해당 메서드를 통해 INSERT 작업을 수행한 후
	// 회원 가입 성공 시 joinSuccess.jsp로 이동하고
	// 실패 시 자바스크립트를 통해 "회원가입실패" 메세지 출력 후 이전페이지로 돌아가기
	%>
</body>
</html>