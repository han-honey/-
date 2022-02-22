<%@page import="dao.BoardReplyDAO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num"));
String password = request.getParameter("password");
BoardDAO boardDAO = new BoardDAO();
int deleteCount = boardDAO.deleteBoard(num,password);
boardDAO.updateNumber();
if(deleteCount > 0 ){
	BoardReplyDAO boardReplyDAO = new BoardReplyDAO();
	boardReplyDAO.deleteAllReply(num);
	%>
	<script type="text/javascript">
		alert("해당 게시물의 댓글을 모두 삭제하였습니다");
		alert("게시물 번호를 재정렬 하였습니다");
		location.href = "./notice.jsp";
	</script>
	<%
} else {
	%>
	<script type="text/javascript">
		alert("글삭제에 실패하였습니다")
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