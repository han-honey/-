<%@page import="dto.MemberDTO"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
MemberDAO dao = new MemberDAO();
MemberDTO dto = dao.selectMember(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="./memberDeletePro.jsp" method="post">
		<table border="1">
			<tr>
				<th>아이디<small style="color:red;">수정불가</small></th>
				<td><input type="text" name="id" required="required" readonly="readonly" value="<%=dto.getId() %> "></td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td><input type="password" name="password" required="required" ></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="submit" value="삭제" >
				<input type="reset" value="초기화">
				<input type="button" value="취소" onclick="history.back()">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>