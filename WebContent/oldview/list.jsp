<%@page import="board.BoardDataBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String boardid = request.getParameter("boardid");
	if (boardid == null)
		boardid = "1";
%>

<%
	int pageSize = 5;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null || pageNum == "") {
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	List articleList = null;
	BoardDBBean dbPro = BoardDBBean.getInstance();
	count = dbPro.getArticleCount(boardid);
	if (count > 0) {
		articleList = dbPro.getArticles(startRow, endRow, boardid);
	}
	number = count - (currentPage - 1) * pageSize;
%>




<html>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<p class="w3-left" style="padding-left: 30px;"></p>
	<div class="w3-container">
		<span class="w3-center  w3-large">
			<h3><%=boardid%>(전체 글:<%=count%>)</h3>
		</span>
		<p class="w3-right w3-padding-right-large">
			<a href="writeForm.jsp">글쓰기</a>
		</p>
		
		
		<%
			if (count == 0) {
		%>
		<table class="table-bordered" width="700">
			<tr class="w3-grey">
				<td align="center">게시판에 저장된 글이 없습니다.</td>
		</table>
		<%
			} else {
		%>
		
		
		<table class="w3-table-all" width="700">
			<tr class="w3-grey">
				<td align="center" width="50">번호</td>
				<td align="center" width="250">제 목</td>
				<td align="center" width="100">작성자</td>
				<td align="center" width="150">작성일</td>
				<td align="center" width="50">조 회</td>
				<td align="center" width="100">IP</td>
			</tr>
			<%
				for (int i = 0; i < articleList.size(); i++) {
						BoardDataBean article = (BoardDataBean) articleList.get(i);
			%>
			<tr height="30">
				<td align="center" width="50"><%=number--%></td>
				<td width="250">
				<%
					int wid = 0;
					if (article.getRe_level() > 0) {
						wid = 5 * (article.getRe_level());
				%> 
					<img src="../images/level.gif" width="<%=wid%>" height="16">
					<img src="../images/re.gif">
				<%
 					} else {
 				%> 
 					<img src="../images/level.gif" width="<%=wid%>" height="16"> 
 				<%
 					}
 				%> 
 				<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
						<%=article.getSubject()%></a> 
				<%
			 		if (article.getReadcount() >= 20) {
				%> 
					<img src="../images/hot.gif" border="0" height="16"> 
				<%
 					}
 				%>
				</td>
				<td align="center" width="100"><%=article.getWriter()%></td>
				<td align="center" width="150"><%=sdf.format(article.getReg_date())%></td>
				<td align="center" width="50"><%=article.getReadcount()%></td>
				<td align="center" width="100"><%=article.getIp()%></td>
			</tr>
			<%
				}
			%>
		</table>
		
		
		<%
			}
		%>


		<div class="w3-center">
			<%
				int bottomLine = 3;
				if (count > 0) {
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
					int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine;
					int endPage = startPage + bottomLine - 1;
					if (endPage > pageCount)
						endPage = pageCount;
					if (startPage > bottomLine) {
			%>
			<a href="list.jsp?pageNum=<%=startPage - bottomLine%>">[이전]</a>
			<%
					}
			%>
			<%
				for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="list.jsp?pageNum=<%=i%>"> <%
 				if (i != currentPage)
 				out.print("[" + i + "]");
 				else
 				out.print("<font color='red'>[" + i + "]</font>");
 			%></a>
			<%
				}
					if (endPage < pageCount) {
			%>
			<a href="list.jsp?pageNum=<%=startPage + bottomLine%>">[다음]</a>
			<%
					}
				}
			%>
		</div>
	</div>
</body>
</html>