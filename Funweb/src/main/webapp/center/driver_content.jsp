<%@page import="dao.FileboardReplyDAO"%>
<%@page import="dto.FileboardReplyDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.FileBoardDTO"%>
<%@page import="dao.FileBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

if(request.getParameter("num") == null || request.getParameter("num").equals("")
   || session.getAttribute("sessionId") == null || session.getAttribute("sessionId").equals("")){
	
	if(session.getAttribute("sessionId") == null || session.getAttribute("sessionId").equals("")){
%>
		<script>
			alert("먼저 로그인이 필요합니다!");
			location.href="../member/login.jsp";
		</script>
		
		<%} else {%>
		
		<script>
			alert("잘못된 접근입니다!");
			location.href="../member/join.jsp";
		</script>
		
		<%}
}
int num = Integer.parseInt(request.getParameter("num"));
int pageNum = Integer.parseInt(request.getParameter("page"));

dao.FileBoardDAO fileboardDAO = new dao.FileBoardDAO();
dto.FileBoardDTO fileboardDTO = fileboardDAO.selectFileBoard(num);

FileboardReplyDAO fileReplyDAO = new FileboardReplyDAO();
FileboardReplyDTO fileReplyDTO = new FileboardReplyDTO();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/driver_content.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap" rel="stylesheet">
</head>

<body>

	<div id="wrap">
	
		<jsp:include page="../inc/top.jsp" />
		
		<div class="clear"></div>
		
		<nav id="sub_menu">
		
			<ul>
				<li><a href="./notice.jsp">공지사항</a></li>
				<li><a href="./contest.jsp">천하제일 요리대회</a></li>
				<li><a href="./driver.jsp">파일 다운로드 게시판</a></li>
				<li><a href="./community.jsp">커뮤니티</a></li>
			</ul>
			
		</nav>

		<article>
		
			<h1>파일 게시글</h1>
			
			<table id="notice">
			
				<tr>
					<td>글번호</td>
					<td><%=num %></td>
					<td>글쓴이</td>
					<td><%=fileboardDTO.getName() %></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><%=fileboardDTO.getDate() %></td>
					<td>조회수</td>
					<td><%=fileboardDTO.getReadcount() %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3">
						<%=fileboardDTO.getSubject() %>
						<!--
						실제 파일과 연결하여 다운로드를 위한 하이퍼링크 작성(HTML5 기능)
						하이퍼링크 태그에 download 속성 지정 시 파일 다운로드 기능 동작하며
						download 속성값에 다운로드할 파일명 지정 가능하므로 원본 파일의 이름을 속성값으로 전달
						-->
					</td>
				</tr>
				<tr>
					<td>파일</td>
					<!-- 사용자가 실제 업로드할 때의 파일명(원본파일명)을 표시 -->
					<td colspan="3"><%=fileboardDTO.getOriginal_file() %>
					<a href="../upload/<%=fileboardDTO.getFile()%>" download="<%=fileboardDTO.getOriginal_file() %>"><input type="button"value="다운로드"></a></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3"><%=fileboardDTO.getContent() %></td>
				</tr>
				
			</table>
			
			<table>
			
				<tr>
					<td>댓글</td>
				</tr>
				<%
				ArrayList<FileboardReplyDTO> replyDTOList = fileReplyDAO.replyList(num);
				
				if(replyDTOList != null && replyDTOList.size() > 0){
					for(FileboardReplyDTO list : replyDTOList){
				%>
						<tr>
							<td>
								<span id="ur"><%=list.getFileboard_reply()%></span> | <%=list.getId()%> | <%=list.getDate()%>
								
								<span> <span onclick="window.open('./update_fileboardReply.jsp?root_num=<%=num%>&page=<%=pageNum%>&num=<%=list.getNum()%>&id=<%=list.getId()%>','댓글 수정','width=500,height=300')" style="text-decoration: underline; cursor:pointer;">[수정]</span>
								| <a href="./delete_fileboardReply.jsp?root_num=<%=num%>&page=<%=pageNum%>&num=<%=list.getNum()%>&id=<%=list.getId()%>">[삭제]</a></span><br>
							</td>
						</tr>
					<%}%>
					
				<%} else {%>
					<tr>
						<td>클린한 댓글 문화를 만듭시다!</td>
					</tr>
				<%} %>
			</table>
			
			<form action="driver_content_replyPro.jsp?num=<%=num %>&page=<%=pageNum %>" method="post" name="fr">
			
				<div>
					<textarea rows="4" cols="30" name="reply"></textarea>
					<input type="submit" value="댓글달기" >
				</div>
				
			</form>
			
			<div id="table_search">
			
				<input type="button" value="글수정" class="btn" onclick="location.href='driver_update.jsp?num=<%=num%>&page=<%=pageNum%>&name=<%=fileboardDTO.getName()%>'">
				<input type="button" value="글삭제" class="btn" onclick="location.href='driver_delete.jsp?num=<%=num%>&name=<%=fileboardDTO.getName()%>'">
				<input type="button" value="글목록" class="btn" onclick="location.href='driver.jsp?page=<%=pageNum%>'">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='driver_write.jsp?'">
				
			</div>

			<div class="clear"></div>
			
		</article>

		<div class="clear"></div>
		
		<jsp:include page="../inc/bottom.jsp" />
		
	</div>
	
</body>
</html>


