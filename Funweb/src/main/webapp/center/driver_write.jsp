<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/driver_write.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap" rel="stylesheet">
</head>
<body>
	<%
	// 세션에 저장된 아이디를 id 변수에 저장
	// 단, 세션 아이디가 없을 경우(=null 일 경우) "잘못된 접근입니다" 출력 후 이전페이지로 돌아가기
	String id = (String) session.getAttribute("sessionId");
	if (id == null) {%>
	
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
				<li><a href="./notice.jsp">공지사항</a></li>
				<li><a href="./contest.jsp">천하제일 요리대회</a></li>
				<li><a href="./driver.jsp">파일 다운로드 게시판</a></li>
				<li><a href="./community.jsp">커뮤니티</a></li>
			</ul>
		</nav>
		
		<article>
			<h1>글쓰기(파일첨부가능)</h1><br>
			<!-- 파일 업로드 기능을 동작시키려면 form 태그에 enctype 속성값으로 "multipart/form-data -->
			<form action="./driver_writePro.jsp" method="post" enctype="multipart/form-data">
			
				<table id="driver">

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
					<tr>
						<td>파일</td>
						<td><input type="file" name="file" required="required"></td>
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


