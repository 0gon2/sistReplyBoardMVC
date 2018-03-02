<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String boardid = request.getParameter("boardid");
		if (boardid == null)
			boardid = "1";
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {
			pageNum = "1";
		}
	%>
	
	

	<jsp:useBean id="article" class="board.BoardDataBean" />
	<jsp:setProperty property="*" name="article" />

	<%
		// System.out.println(article);
	%>
	<%
		int num = Integer.parseInt(request.getParameter("num"));
		String passwd = request.getParameter("passwd");
		
		BoardDBBean dbPro = BoardDBBean.getInstance();
		article.setIp(request.getRemoteAddr());
		int deleteCount = dbPro.deleteArticle(num,passwd,boardid);
	%>
	<%
		if (deleteCount == 1) {
	%>
	<meta http-equiv="Refresh"
		content="0;url=list.jsp?pageNum=<%=pageNum%>">

	<%
		} else {
	%>

	<script>
		alert("비밀번호가 맞지 않습니다");
		history.go(-1);
	</script>

	<%
		}
	%>
	
	
</body>
</html>