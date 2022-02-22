<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String name = request.getParameter("name");

if(!session.getAttribute("sessionId").equals(name)){
	%>
	<script type="text/javascript">
		alert("본인의 게시물이 아닙니다 삭제 불가능!")
		history.back();
	</script>
	<%
}
request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num"));
String culture = request.getParameter("culture");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>recipe/recipe_delete.jsp</title>
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
				<li><a href="./recipe_k.jsp">한국인은 역시 <Strong>한식</Strong></a></li>
				<li><a href="./recipe_w.jsp">맛스럽고 멋스러운 <Strong>양식</Strong></a></li>
				<li><a href="./recipe_j.jsp">깔끔하고 고급스러운 <Strong>일식</Strong></a></li>
				<li><a href="./recipe_c.jsp">화려하고 화끈한 <Strong>중식</Strong></a></li>
			</ul>
			
		</nav>
		
		<article>
		
			<h1>레시피 삭제</h1>
			
			<form action="recipe_deletePro.jsp?culture=<%=culture %>" method="post">
				<input type="hidden" name="num" value="<%=num%>">
				
				<table id="notice">
				
					<tr>
						<td>패스워드</td>
						<td><input type="password" name="password" ></td>
					</tr>
					
				</table>

				<div id="table_search">
					<input type="submit" value="글삭제" class="btn">
				</div>
				
			</form>
			
			<div class="clear"></div>
			
		</article>

		<div class="clear"></div>
		
		<jsp:include page="../inc/bottom.jsp" />
		
	</div>
	
</body>
</html>


