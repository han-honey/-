<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("page"));
	int root_num = Integer.parseInt(request.getParameter("root_num"));
	String id = request.getParameter("id");
	System.out.println(id);
	if(!session.getAttribute("sessionId").equals(id)){
		%>
		<script type="text/javascript">
			alert("본인의 댓글이 아닙니다 수정 할 수 없습니다!");
			window.close();
		</script>
		<%
	}
	if(request.getParameter("count") != null){
		int count = Integer.parseInt(request.getParameter("count"));
		if(count > 0){
			%>
			<script type="text/javascript">
				window.close();
				opener.parent.location.reload();
			</script>
			<%
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update_reply</title>
</head>
<body>
	<form action="update_complainReplyPro.jsp?num=<%=num%>&page=<%=pageNum%>&root_num=<%=root_num%>&id=<%=id%>" method="post" name="fr">
	
		<input type="text" name="update_reply">
		<input type="submit" value="댓글 수정 하기">
		
	</form>
	
</body>
</html>