<%@page import="dao.CommunityDAO"%>
<%@page import="dto.CommunityDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

CommunityDTO communityDTO = new CommunityDTO();

communityDTO.setName(request.getParameter("name"));
communityDTO.setPassword(request.getParameter("password"));
communityDTO.setSubject(request.getParameter("subject"));
communityDTO.setContent(request.getParameter("content"));

CommunityDAO communityDAO = new CommunityDAO();
int insertCount = communityDAO.insertCommunity(communityDTO);

if(insertCount > 0){
	
	response.sendRedirect("./community.jsp");
	
} else {%>

	<script type="text/javascript">
		alert("글쓰기에 실패하였습니다!")
		history.back();
	</script>
	
<%}%>