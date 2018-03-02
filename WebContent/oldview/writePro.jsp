<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String boardid = request.getParameter("boardid");
		if (boardid == null)
			boardid = "1";
	%>
	<jsp:useBean id="article" class="board.BoardDataBean" />
	<jsp:setProperty property="*" name="article" />
	<%
		BoardDBBean dbPro = BoardDBBean.getInstance();
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null || pageNum == "") 
		{
			pageNum = "1";	
		}
		article.setIp(request.getRemoteAddr());
		dbPro.insertArticle(article);
		
		response.sendRedirect("list.jsp?pageNum="+pageNum+"&boardid="+boardid);
	%>
</body>
</html>