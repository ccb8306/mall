<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!-- 
	/*noticeList.jsp*/
	
	공지사항 목록 페이지.
	
	관리자가 작성한 공지사항들을 볼 수 있는 게시판.
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeList</title>
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
		int currentPage = 1;
		int endPage = 1;
		int rowPage = 10;
		
		NoticeDao noticeDao = new NoticeDao();
		ArrayList<Notice> noticeList = noticeDao.selectNoticeList(currentPage, rowPage);
		
		// 최대페이지 구하기
		endPage = noticeDao.getNoticeEndPage(rowPage);
	%>
	
	<!-- 공지사항 리스트 -->
	<div class="container">
		<table class="table">
			<thead>
				<tr>
					<th colspan="4" class="table-active"><h4>Notice</h4></th>
				</tr>
				<tr>
					<th>[Notice]</th>
					<th>제목</th>
					<th>작성자</th>			
					<th>작성일</th>					
				</tr>
			</thead>
			<tbody>
				<%
					for(Notice n : noticeList){
				%>
					<tr>
						<td>Notice</td>
						<td><a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeId=<%=n.getNoticeId()%>"><%=n.getNoticeTitle() %></a></td>
						<td>관리자</td>
						<td><%=n.getNoticeDate() %></td>
					</tr>
				<%
					}
				%>
			</tbody>
		</table>
		
		<!-- 페이징 -->
		<ul class="pagination">
			<%
				// 현재 페이지가 1페이지 보다 클 시
				if(currentPage > 1){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=1">처음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage-1 %>">이전</a></li>
			<%
				// 현재 페이지가 1페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=1">처음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage-1 %>">이전</a></li>
			<%
				}// 현재 페이지
			%>
					<li class="page-item"><a class="page-link"><%=currentPage %></a></li>
			<%
				// 현재 페이지가 마지막 페이지보다 작을 시
				if(currentPage < endPage){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=endPage %>">맨끝</a></li>
			<%
				// 현재 페이지가 마지막 페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=endPage %>">맨끝</a></li>
			<%
				}
			%>	
		</ul>
	</div>
	
	<!-- 최하단 -->
	<div>
		<jsp:include page="/inc/bottomMenu.jsp"></jsp:include>
	</div>
</body>
</html>