<%@page import="java.util.ArrayList"%>
<%@page import="dto.MemberDTO"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(!session.getAttribute("sessionId").equals("admin")){
	%>
	<script type="text/javascript">
		alert("잘못된 접근입니다!");
		location.href="../main/main.jsp";
	</script>
	<%
}
MemberDAO dao = new MemberDAO();
ArrayList<MemberDTO> memberList = dao.selectMemberList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap" rel="stylesheet">
<style type="text/css">
h1 {
	text-align: center;
}

table {
	width: 1000px;
	text-align: center;
	font-size: 18px;
	margin: 20px auto;
}
td, th {
	padding: 5px;
}

#subject {
	text-align: left;
	padding-left: 10px;
}

#command {
	width: 850px;
	margin: 0 300px 0 610px;
	text-align: right;
}
</style>
</head>
<body>
	<h1>회원 리스트</h1>
	<table border="1">
		<tr>
			<th width="150">ID</th>
			<th width="150">이름</th>
			<th width="300">가입일</th>
			<th width="200">이메일</th>
			<th width="400">핸드폰번호</th>
			<th width="600">집주소</th>
			<th width="300">유선전화번호</th>
		</tr>

		<%
// 		for (int i = 0; i < memberList.size(); i++) {
// 			dto = (MemberDTO) memberList.get(i);
// 		for(Object o : memberList){}
		%>
<!-- 		<tr> -->
<%-- 			<td><%=dto.getId()%></td> --%>
<%-- 			<td><%=dto.getName()%></td> --%>
<%-- 			<td><%=dto.getEmail()%></td> --%>
<%-- 			<td><%=dto.getPhone()%></td> --%>
<%-- 			<td><%=dto.getDate()%></td> --%>
<!-- 		</tr> -->
		<%
// 		}
		%>
		
		<%
		// 향상된 for문을 사용할 경우 => 제네릭 타입 사용했으므로 바로 MemberDTO 타입에 저장
		for(MemberDTO dto : memberList){
		%>
		<tr>
			<td><a href="memberInfo.jsp?id=<%=dto.getId()%>"><%=dto.getId()%></a></td>
			<td><%=dto.getName()%></td>
			<td><%=dto.getDate()%></td>
			<td><%=dto.getEmail()%></td>
			<td><%=dto.getMobile()%></td>
			<td><%=dto.getAddress()%></td>
			<td><%=dto.getPhone()%></td>
		</tr>
		<%
		}
		%>
		
	</table>

	<div id="command">
		<input type="button" value="홈으로" onclick="location.href='../main/main.jsp'">
	</div>
</body>
</html>