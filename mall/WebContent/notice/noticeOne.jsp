<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!-- 
	/*noticeOne.jsp*/
	
	noticeList.jsp에서 한 게시글 선택시
	올 수 있는 공지사항 상세보기 페이지.
	
	선택한 게시글을 자세히 볼 수 있다.
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeOne</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<style>
	.align-left{text-align:left;}
	.align-center{text-align:center;}
	.align-right{text-align:right;}
	.color-black{color:black};
</style>
</head>
<body>
	<!-- 메뉴바 -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	
	<!-- jsp -->
	<%
		int noticeId = Integer.parseInt(request.getParameter("noticeId"));
		System.out.println(noticeId + "<--noticeId");	
	
		NoticeDao noticeDao = new NoticeDao();
		Notice n = noticeDao.selectNoticeOne(noticeId);
	%>
	
	<!-- 공지사항 리스트 -->
	<div class="container">
		<table class="table">
			<thead class="thead-light">
				<tr>
					<th colspan="2"><h4><a class="color-black" href="<%=request.getContextPath() %>/notice/noticeList.jsp">Notice</a></h4></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th style="width:100px">제목</th>
					<td><%=n.getNoticeTitle() %></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>관리자</td>
				</tr>
				<tr>
					<th>작성일</th>
					<td><%=n.getNoticeDate() %></td>
				</tr>
				<tr>
					<th>내용</th>
					<td style="height:400px;"><%=n.getNoticeContent() %></td>
				</tr>
			</tbody>
		</table>
		<a class="btn btn-outline-primary" href="<%=request.getContextPath()%>/notice/noticeList.jsp">목록으로</a>
	</div>
	
	<!-- 최하단 -->
	<div>
		<jsp:include page="/inc/bottomMenu.jsp"></jsp:include>
	</div>
</body>
</html>