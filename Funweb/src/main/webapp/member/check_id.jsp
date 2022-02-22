<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>check_id</title>
<script type="text/javascript">
	function useId() {
		window.opener.document.fr.id.value = document.fr.check_id.value;
		window.close();
	}
</script>
</head>
<body>

<%
	String check_id = request.getParameter("check_id");
%>
	<form action="check_id.jsp" method="post" name="fr">
	
		<input type="text" name="check_id" <%if(check_id != null && !check_id.equals("")){ %> value="<%=check_id%>"<%} %>>
		<input type="submit" value="아이디 중복 확인" >
	
	</form>
	<%if(check_id != null && !check_id.equals("")){
		
		MemberDAO memberDAO	= new MemberDAO();
		boolean isCheckedId = memberDAO.checkDupleId(check_id);
		
		if(isCheckedId){
			%>
			<script type="text/javascript">
			alert("이 아이디는 사용할 수 없습니다(중복!)")
			</script>
			<%
		} else {
			%>
			<script type="text/javascript">
			
			alert("아이디 사용 가능!")
			</script>
			<input type="button" value="이 아이디 사용하기" onclick="useId()">
			<%
		}
			
	} %>
	
</body>
</html>
