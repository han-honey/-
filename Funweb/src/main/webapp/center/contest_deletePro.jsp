<%@page import="dao.ContestReplyDAO"%>
<%@page import="dao.ContestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num"));
String password = request.getParameter("password");

ContestDAO contestDAO = new ContestDAO();
int deleteCount = contestDAO.deleteContest(num,password);
contestDAO.updateNumber();

if(deleteCount > 0 ){
	ContestReplyDAO contestReplyDAO = new ContestReplyDAO();
	contestReplyDAO.deleteAllReply(num);
%>
	<script type="text/javascript">
		alert("게시물 번호를 재정렬 하였습니다");
		location.href = "./contest.jsp";
	</script>
	
<%} else {%>
	
	<script type="text/javascript">
		alert("글삭제에 실패하였습니다")
		history.back();
	</script>
	
<%}%>