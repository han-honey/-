<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!-- BoardDTO dto = new BoardDTO(); -->
<!-- dto.setName(request.getParameter("name")); -->
<!-- dto.setPassword(request.getParameter("password")); -->
<!-- dto.setSubject(request.getParameter("subject")); -->
<!-- dto.setContent(request.getParameter("content")); -->
<jsp:useBean id="board" class="dto.BoardDTO"/>
<jsp:setProperty property="*" name="board"/>
<%
BoardDAO dao = new BoardDAO();
int insertCount = dao.insertBoard(board);

if(insertCount > 0){
	response.sendRedirect("./notice.jsp");
} else {
	
	%>
	<script type="text/javascript">
		alert("글쓰기에 실패하였습니다!")
		history.back();
	</script>
	
<%}%>