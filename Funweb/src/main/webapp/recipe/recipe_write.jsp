<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/recipe_write.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap" rel="stylesheet">
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("sessionId");
	
	if (id == null) {
		
	%>
	
	<script type="text/javascript">
		alert("회원만 접근 가능합니다!")
		location.href="../member/login.jsp";
	</script>
	
	<%}%>
	
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
		
			<h1>글쓰기</h1>
			
			<form action="./recipe_writePro.jsp" method="post">
			
				<table id="notice">
				
					<tr>
						<td>카테고리</td>
							<td>
								<select name="culture">
									<option value="">카테고리</option>
									<option value="k">한식</option>
									<option value="w">양식</option>
									<option value="j">일식</option>
									<option value="c">중식</option>
								</select>
							</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td><input type="text" name="name" value=<%=id %> readonly="readonly" required="required"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="password" required="required"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" required="required"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="10" cols="20" name="content" required="required"></textarea></td>
					</tr>

				</table>

				<div id="table_search">
					<input type="submit" value="글쓰기" class="btn">
				</div>
				
			</form>
			
			<div class="clear"></div>
			
		</article>

		<div class="clear"></div>
		
		<jsp:include page="../inc/bottom.jsp" />
		
	</div>
	
</body>
</html>


