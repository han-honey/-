<%@page import="dto.ComplainDTO"%>
<%@page import="dao.ComplainDAO"%>
<%@page import="dto.RecipeDTO"%>
<%@page import="dao.RecipeDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

RecipeDAO recipedao = new RecipeDAO();
RecipeDTO recipedto = recipedao.seleteRecipe();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main/main.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap" rel="stylesheet">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		  
		<div class="clear"></div>
		<div id="main_random">오늘은 뭘 만들지?<br><br><br><br>
		<input type="button" value="랜덤으로 고르기!" name="randomBox" style="cursor:pointer;" onclick="value='<%=recipedto.getSubject()%> 당첨!'" >
		<input type="button" value="바로가기" name="drirect" style="cursor:pointer;" onclick="location.href='../recipe/recipe_content.jsp?num=<%=recipedto.getNum()%>&page=1'" >
		<input type="button" value="다시하기" name="randomBox" style="cursor:pointer;" onclick="location.href='main.jsp'" >
		</div>
		<!-- 본문 내용 -->
		<article id="front">
		  	<div id="solution">
		  			<h3>요리초보도 완전가능!</h3>
					<p>레시피 보면서 천천히 따라하면 누구든지 근사한 밥상 차리기 가능합니다!<br><br></p>
		  		  	<h3>편리한 인터페이스!</h3>
					<p>
					손이 열개라도 모자란데 동영상 재생,멈춤,뒤로가기,앞으로가기 불편하셨죠?
					음성인식을 통해서 동영상을 컨트롤 해보세요!<br><br>
					</p>
		  			<h3>내가 더 맛있는 방법 알아요!</h3>
					<p>
					기존 레시피에서 자신만의 방법을 공유할 수 있습니다
					매주마다 가장 많은 리스펙을 받으신분께 포인트 지급!
					</p>
		  	</div>
		  	<div class="clear"></div>
		  	
			<div id="sec_news">
			<%

				BoardDAO boardDAO = new BoardDAO();
				ArrayList<BoardDTO> boardList = boardDAO.selectBoardList(1, 3);
			%>
			
				<h3><a href="../center/notice.jsp">최근공지사항</a></h3>
					<%
					if(boardList != null && boardList.size() > 0){
								for(BoardDTO dto : boardList){
					%>
				<dl>
					<dt><a href="../center/notice_content.jsp?num=<%=dto.getNum() %>&page=1"><%boardDAO.selectBoard(dto.getNum());%>※  <%=dto.getSubject() %>(<%=dto.getReadcount()%>)<span class="dd"><%=dto.getDate() %></span></a></dt>
				</dl>
				<%
				}
				} else {
				%>
				<dl>
					<dt>표시할 게시물이 없습니다</dt>
				</dl>
				<%} %>
			</div>
			
			
			<%
			recipedao = new RecipeDAO();
			ArrayList<RecipeDTO> recipeList = recipedao.mostViewedRecipes(0, 3);
			%>
			<div id="news_notice">
		  		<h3><a href="../recipe/recipe_k.jsp">가장 주목받는 레시피</a></h3>
				<%if(recipeList != null && recipeList.size() > 0){
 					for(RecipeDTO dto : recipeList){
				%>
				<dl>
					<dd><a href="../recipe/recipe_content.jsp?num=<%=dto.getNum()%>&page=1&culture=<%=dto.getCulture() %>"><%=dto.getSubject() %> (<%=dto.getReadCount()%>)	<span class="dd"><%=dto.getDate() %></span></a></dd>
				</dl>
				<%
				}
				} else {
				%>
				<dl>
					<dt>표시할 게시물이 없습니다</dt>
				</dl>
				<%} %>
				</div>
				
				
			<%
			ComplainDAO complainDAO = new ComplainDAO();
			ArrayList<ComplainDTO> complainList = complainDAO.selectComplainList(1, 3);
			%>
			<div id="news_complain">
		  		<h3><a href="../complain/complain.jsp">이런거 마음에 안들어요!</a></h3>
				<%if(complainList != null && complainList.size() > 0){
				for(ComplainDTO dto : complainList){
				%>
				
				<dl>
					<dt><a href="../complain/complain_content.jsp?num=<%=dto.getNum()%>&page=1&originNO=<%=dto.getOriginNO()%>"><%=dto.getSubject() %> (<%=dto.getReadCount()%>)<span class="dd"><%=dto.getDate() %></span></a></dt>
				</dl>
				<%
				}
				} else {
				%>
				<dl>
					<dt>표시할 게시물이 없습니다</dt>
				</dl>
				<%} %>
				</div>
	  	</article>
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


