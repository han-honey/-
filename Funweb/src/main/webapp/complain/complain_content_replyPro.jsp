<%@page import="dto.ComplainReplyDTO"%>
<%@page import="dao.ComplainReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num"));
int pageNum = Integer.parseInt(request.getParameter("page"));
int originNO = Integer.parseInt(request.getParameter("originNO"));
String reply = request.getParameter("reply");

if(request.getParameter("reply") != null && !request.getParameter("reply").equals("")){
	
	ComplainReplyDAO replyDAO = new ComplainReplyDAO();
	ComplainReplyDTO replyDTO = new ComplainReplyDTO();
	
	replyDTO.setId((String)session.getAttribute("sessionId"));
	replyDTO.setRoot_num(num);
	replyDTO.setComplain_reply(reply);
	
	int insertReplyCount = replyDAO.insertReply(replyDTO);
	
	if(insertReplyCount > 0){
		
		response.sendRedirect("complain_content.jsp?num="+num+"&page="+pageNum+"&originNO="+originNO);
		
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
