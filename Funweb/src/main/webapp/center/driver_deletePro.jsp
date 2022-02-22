<%@page import="dao.FileboardReplyDAO"%>
<%@page import="dao.FileBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num"));
String password = request.getParameter("password");

dao.FileBoardDAO fileBoardDAO = new dao.FileBoardDAO();
int deleteCount = fileBoardDAO.deleteFileBoard(num,password);
fileBoardDAO.updateNumber();

if(deleteCount > 0 ){
	FileboardReplyDAO fileboardReplyDAO = new FileboardReplyDAO();
	fileboardReplyDAO.deleteAllReply(num);
	%>
	<script type="text/javascript">
		alert("게시물 번호를 재정렬 하였습니다");
		location.href = "./driver.jsp";
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