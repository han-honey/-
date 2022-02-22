<%@page import="dao.CommunityReplyDAO"%>
<%@page import="dao.CommunityDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num"));
String password = request.getParameter("password");

CommunityDAO communityDAO = new CommunityDAO();
int deleteCount = communityDAO.deleteCommunity(num,password);
communityDAO.updateNumber();

if(deleteCount > 0 ){
	CommunityReplyDAO communityReplyDAO = new CommunityReplyDAO();
	communityReplyDAO.deleteAllReply(num);
%>
	<script type="text/javascript">
		alert("게시물 번호를 재정렬 하였습니다");
		location.href = "./notice.jsp";
	</script>
<%} else {%>

	<script type="text/javascript">
		alert("글삭제에 실패하였습니다")
		history.back();
	</script>
	
<%}%>