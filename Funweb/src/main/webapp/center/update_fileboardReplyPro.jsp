<%@page import="dao.FileboardReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num"));
int pageNum = Integer.parseInt(request.getParameter("page"));
int root_num = Integer.parseInt(request.getParameter("root_num"));
String id = request.getParameter("id");
String re_reply = request.getParameter("update_reply");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>check_id</title>
</head>
<body>
	<% 
	try{
		if(re_reply != null || !re_reply.equals("")){
			
			FileboardReplyDAO fileboardReplyDAO = new FileboardReplyDAO();
			int updateReplyCount = fileboardReplyDAO.updateReply(num, re_reply);
			if(updateReplyCount > 0){
				
				response.sendRedirect("./update_fileboardReply.jsp?num="+ num + "&root_num=" + root_num + "&page=" + pageNum + "&count=" + updateReplyCount + "&id=" + id);
				
			} else {%>
			
					<script type="text/javascript">
			 			alert("댓글 수정 실패");
			 			history.back();
			 		</script>
			<%}
		}
	} catch(Exception e){
		e.printStackTrace();
	}%>
		
	
</body>
</html>
