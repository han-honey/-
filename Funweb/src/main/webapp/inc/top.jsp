<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String sessionId = (String)session.getAttribute("sessionId"); // 강제로 타입을 바꿈
// String sessionId = session.getAttribute("sessionId").toString(); // 자신이 가진 데이터를 문자열로 전달해줌 
%>
<header>

  <!-- login join -->
  <%if(sessionId == null){ %>
  
  	<div id="login"><a href="../member/login.jsp">로그인</a> | <a href="../member/join.jsp">회원가입</a></div>
  	
	  <%} else if(sessionId.equals("admin")) { %>
	  
   <div id="login"><a href="../member/memberInfo.jsp?id=<%=sessionId %>"><%=sessionId %>님</a> | <a href="../member/logout.jsp">로그아웃</a>
   <a href="../member/adminMain.jsp">| 회원 리스트</a></div>
    
  <%} else {%>

	  <div id="login"><a href="../member/memberInfo.jsp?id=<%=sessionId %>"><%=sessionId %>님</a> | <a href="../member/logout.jsp">로그아웃</a></div>

  <%
  	}
  %>
  
  <div class="clear"></div>
  <!-- 로고들어가는 곳 -->
  <div id="logo"><img src="../images/design/logo.png" onclick="location.href='../main/main.jsp'" style="cursor:pointer;"></div>
  <!-- 메뉴들어가는 곳 -->
  <nav id="top_menu">
  	<ul>
  		<li><a href="../main/main.jsp">홈</a></li>
  		<li><a href="../company/welcome.jsp">저희를 소개합니다</a></li>
  		<li><a href="../recipe/recipe_k.jsp">레시피</a></li>
  		<li><a href="../center/notice.jsp">자유게시판</a></li>
  		<li><a href="../complain/complain.jsp">고객센터</a></li>
  	</ul>
  </nav>
</header>