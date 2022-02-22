<%@page import="dto.MemberDTO"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");

MemberDAO dao = new MemberDAO();
MemberDTO dto = dao.selectMember(id);

if(dto != null){
%>
			<table border="1">
			<tr>
				<th>아이디</th>
				<td><%=id %></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><%=dto.getName()%></td>
			</tr>
			<tr>
				<th>가입일</th>
				<td><%=dto.getDate()%></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><%=dto.getEmail()%></td>
			</tr>
			<tr>
				<th>핸드폰번호</th>
				<td><%=dto.getMobile()%></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><%=dto.getAddress()%></td>
			</tr>
			<tr>
				<th>유선전화</th>
				<td><%=dto.getPhone()%></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="submit" value="정보수정" onclick="location.href='memberUpdateForm.jsp?id=<%=dto.getId()%>'">
				<input type="submit" value="회원탈퇴" onclick="location.href='memberDeleteForm.jsp?id=<%=dto.getId()%>'">
				<input type="button" value="홈으로" onclick="location.href='../main/main.jsp'">
				</td>
			</tr>
			</table>
<%} else {%>
	
	<script type="text/javascript">
		alert("회원 정보 조회 불가!");
		history.back();
	</script>
<%} %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>