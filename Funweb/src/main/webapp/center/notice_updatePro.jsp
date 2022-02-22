<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String password = request.getParameter("password");
int num = Integer.parseInt(request.getParameter("num"));
int pageNum = Integer.parseInt(request.getParameter("page"));
String subject = request.getParameter("subject");
String content = request.getParameter("content");

BoardDAO dao = new BoardDAO();
BoardDTO dto = new BoardDTO();

dto.setPassword(password);
dto.setNum(num);
dto.setSubject(subject);
dto.setContent(content);

int updateCount = dao.updateBoard(dto);

if(updateCount > 0){
	response.sendRedirect("./notice_content.jsp?num=" + num + "&page=" + pageNum);
} else {
%>
	<script type="text/javascript">
		alert("글수정 실패!");
		history.back();
	</script>
	<%
}
%>