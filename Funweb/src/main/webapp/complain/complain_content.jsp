<%@page import="dto.ComplainReplyDTO"%>
<%@page import="dao.ComplainReplyDAO"%>
<%@page import="dto.ComplainDTO"%>
<%@page import="dao.ComplainDAO"%>
<%@page import="javax.swing.plaf.basic.BasicOptionPaneUI.ButtonActionListener"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

if(request.getParameter("num") == null || request.getParameter("num").equals("")) {
%>   		
		<script>
			alert("잘못된 접근입니다!");
			location.href="../member/join.jsp";
		</script>
<%}

if(session.getAttribute("sessionId") == null || session.getAttribute("sessionId").equals("")){
%>
		<script>
			alert("먼저 로그인이 필요합니다!");
			location.href="../member/login.jsp";
		</script>
<%}

int num = Integer.parseInt(request.getParameter("num"));
int originNO = Integer.parseInt(request.getParameter("originNO"));
int pageNum = Integer.parseInt(request.getParameter("page"));

ComplainDAO complainDAO = new ComplainDAO();
ComplainDTO complainDTO = complainDAO.selectComplain(num);

ComplainReplyDAO replyDAO = new ComplainReplyDAO();
ComplainReplyDTO replyDTO = new ComplainReplyDTO();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>complain/complain_content.jsp</title>
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

		<article>
		
			<h1>글 상세 페이지</h1>
			
			<table id="notice">
			
				<tr>
					<td>글번호</td>
					<td><%=num%></td>
					<td>글쓴이</td>
					<td><%=complainDTO.getName()%></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><%=complainDTO.getDate()%></td>
					<td>조회수</td>
					<td><%=complainDTO.getReadCount()%></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><%=complainDTO.getSubject()%></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3"><%=complainDTO.getContent()%></td>
				</tr>
				
			</table>
			
			<table>
			
				<tr>
					<td>댓글</td>
				</tr>
				<%
				ArrayList<ComplainReplyDTO> replyDTOList = replyDAO.replyList(num);
				if(replyDTOList != null && replyDTOList.size() > 0){
					
					for(ComplainReplyDTO list : replyDTOList){
				%>
						<tr>
							<td>
								<span id="ur"><%=list.getComplain_reply()%></span> | <%=list.getId()%><%=list.getDate()%>
								
								<span> <span onclick="window.open('./update_complainReply.jsp?root_num=<%=num%>&page=<%=pageNum%>&num=<%=list.getNum()%>&id=<%=list.getId()%>','댓글 수정','width=500,height=300')" style="text-decoration: underline; cursor:pointer;">[수정]</span>
								| <a href="./delete_complainReplyPro.jsp?root_num=<%=num%>&page=<%=pageNum%>&num=<%=list.getNum()%>&id=<%=list.getId()%>&originNO=<%=originNO %>">[삭제]</a></span><br>
								
							</td>
						</tr>
						
					<%}%>
					
				<%} else {%>
				
					<tr>
						<td>클린한 댓글 문화를 만듭시다!</td>
					</tr>
					
				<%} %>
				
			</table>
					
			<form action="complain_content_replyPro.jsp?num=<%=num %>&page=<%=pageNum %>&originNO=<%=originNO %>" method="post" name="fr">
			
				<div>
					<textarea rows="4" cols="30" name="reply"></textarea>
					<input type="submit" value="댓글달기" >
				</div>
				
			</form>

			<div id="table_search">
				<input type="button" value="글수정" class="btn" onclick="location.href='complain_update.jsp?num=<%=num%>&page=<%=pageNum%>&name=<%=complainDTO.getName()%>&originNO=<%=originNO %>'">
				<input type="button" value="글삭제" class="btn" onclick="location.href='complain_delete.jsp?num=<%=num%>&name=<%=complainDTO.getName()%>'">
				<input type="button" value="글목록" class="btn" onclick="location.href='complain.jsp'">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='complain_write.jsp'">
				<%if(session.getAttribute("sessionId").equals("admin")){ %> <!-- 관리자만 답글 쓰기 가능 -->
					<input type="button" value="답글쓰기" class="btn" onclick="location.href='complainQnA_write.jsp?originNO=<%=originNO%>&groupOrd=<%=complainDTO.getGroupOrd()%>&groupLayer=<%=complainDTO.getGroupLayer()%>'">
				<%} %>
			</div>

			<div class="clear"></div>
			
		</article>

		<div class="clear"></div>
		
		<jsp:include page="../inc/bottom.jsp" />
		
	</div>
	
</body>
</html>


