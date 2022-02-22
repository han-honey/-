<%@page import="dao.MemberDAO"%>
<%@page import="dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDTO dto = new MemberDTO();
MemberDAO dao = new MemberDAO();

request.setCharacterEncoding("UTF-8");
dto.setId(request.getParameter("id"));
dto.setPassword(request.getParameter("password"));
dto.setName(request.getParameter("name"));
dto.setEmail(request.getParameter("email"));
dto.setMobile(request.getParameter("mobile"));
dto.setAddress(request.getParameter("address"));
dto.setPhone(request.getParameter("phone"));

int updateCount = dao.updateMemberInfo(dto);
if(updateCount > 0){
	response.sendRedirect("./memberInfo.jsp?id="+ request.getParameter("id"));
} else {
	%>
	<script type="text/javascript">
		alert("정보수정실패!")
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