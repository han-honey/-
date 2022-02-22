<%@page import="dto.CommunityDTO"%>
<%@page import="dao.CommunityDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String password = request.getParameter("password");
int num = Integer.parseInt(request.getParameter("num"));
int pageNum = Integer.parseInt(request.getParameter("page"));
String subject = request.getParameter("subject");
String content = request.getParameter("content");

CommunityDAO communityDAO = new CommunityDAO();
CommunityDTO communityDTO = new CommunityDTO();

communityDTO.setPassword(password);
communityDTO.setNum(num);
communityDTO.setSubject(subject);
communityDTO.setContent(content);

int updateCount = communityDAO.updateCommunity(communityDTO);

if(updateCount > 0){
	
	response.sendRedirect("./community_content.jsp?num=" + num + "&page=" + pageNum);
	
} else {%>

	<script type="text/javascript">
		alert("글수정 실패!");
		history.back();
	</script>
	
<%}%>