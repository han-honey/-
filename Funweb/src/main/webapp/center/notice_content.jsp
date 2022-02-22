<%@page import="javax.swing.plaf.basic.BasicOptionPaneUI.ButtonActionListener"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.BoardReplyDTO"%>
<%@page import="dao.BoardReplyDAO"%>
<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
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
		<%

				} else {
		%>
		<script>
			alert("잘못된 접근입니다!");
			location.href="../member/join.jsp";
		</script>
		<%

				}
				}
				int num = Integer.parseInt(request.getParameter("num"));
				int pageNum = Integer.parseInt(request.getParameter("page"));

				BoardDAO dao = new BoardDAO();
				BoardDTO dto = dao.selectBoard(num);

				BoardReplyDAO replyDAO = new BoardReplyDAO();
				BoardReplyDTO replyDTO = new BoardReplyDTO();
		%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_content.jsp</title>
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
			<h1>글 상세 페이지</h1>
			<table id="notice">
				<tr>
					<td>글번호</td>
					<td><%=num%></td>
					<td>글쓴이</td>
					<td><%=dto.getName()%></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><%=dto.getDate()%></td>
					<td>조회수</td>
					<td><%=dto.getReadcount()%></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><%=dto.getSubject()%></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3"><%=dto.getContent()%></td>
				</tr>
			</table>
			<table>
				<tr>
					<td>댓글</td>
				</tr>
				<%
				try{
					ArrayList<BoardReplyDTO> replyDTOList = replyDAO.replyList(num);
					if(replyDTOList != null && replyDTOList.size() > 0){
							
						for(BoardReplyDTO list : replyDTOList){
				%>
				<tr>	
					<td>
						<span id="ur"><%=list.getBoard_reply()%></span>  | <%=list.getId()%>  <%=list.getDate()%>
						
						<span> <span onclick="window.open('./update_boardReply.jsp?root_num=<%=num%>&page=<%=pageNum%>&num=<%=list.getNum()%>&id=<%=list.getId()%>','댓글 수정','width=500,height=300')" style="text-decoration: underline; cursor:pointer;">[수정]</span>
						| <a href="./delete_boardReplyPro.jsp?root_num=<%=num%>&page=<%=pageNum%>&num=<%=list.getNum()%>&id=<%=list.getId()%>">[삭제]</a></span><br>
						
					</td>
				</tr>
			</table>
					<%}
					} else {%>
					
			<table>
					<tr>
						<td>클린한 댓글 문화를 만듭시다!</td>
					</tr>
			</table>
					<%}
				} catch(Exception e){
					
					e.printStackTrace();
					
				} finally {%>
				
			<table>
					<tr>
						<td>클린한 댓글 문화를 만듭시다!</td>
					</tr>
			</table>
					
						
			
				
					
			<form action="notice_content_replyPro.jsp?num=<%=num %>&page=<%=pageNum %>" method="post" name="fr">
			
				<div>
					<textarea rows="4" cols="30" name="reply"></textarea>
					<input type="submit" value="댓글달기" >
				</div>
				
			</form>

			<div id="table_search">
			
				<%if(session.getAttribute("sessionId").equals("admin")){ %><!-- 관리자만 수정,삭제,쓰기 가능 -->
				
					<input type="button" value="글수정" class="btn" onclick="location.href='notice_update.jsp?num=<%=num%>&page=<%=pageNum%>&name=<%=dto.getName()%>'">
					<input type="button" value="글삭제" class="btn" onclick="location.href='notice_delete.jsp?num=<%=num%>&name=<%=dto.getName()%>'">
					<input type="button" value="글쓰기" class="btn" onclick="location.href='notice_write.jsp?'">
					
				<%} %>
				<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp'">
				
			</div>

			<div class="clear"></div>
			
		</article>

		<div class="clear"></div>
		
		<jsp:include page="../inc/bottom.jsp" />
		
	</div>
</body>
</html>
	<%} %>
