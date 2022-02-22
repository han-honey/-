<%@page import="dto.CommunityReplyDTO"%>
<%@page import="dao.CommunityReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num"));
int pageNum = Integer.parseInt(request.getParameter("page"));
String reply = request.getParameter("reply");

if(request.getParameter("reply") != null && !request.getParameter("reply").equals("")){
	
	CommunityReplyDAO replyDAO = new CommunityReplyDAO();
	CommunityReplyDTO replyDTO = new CommunityReplyDTO();
	
	replyDTO.setId((String)session.getAttribute("sessionId"));
	replyDTO.setRoot_num(num);
	replyDTO.setCommunity_reply(request.getParameter("reply"));
	
	int insertReplyCount = replyDAO.insertReply(replyDTO);
	
	if(insertReplyCount > 0){
		
		response.sendRedirect("community_content.jsp?num="+num+"&page="+pageNum);
		
	} else {%>
	
		<script type="text/javascript">
			alert("댓글 쓰기 실패!")
			history.back();
		</script>
		
	<%}
	
} else {%>

	<script type="text/javascript">
		alert("내용을 입력하세요")
		history.back();
	</script>
	
<%}%>