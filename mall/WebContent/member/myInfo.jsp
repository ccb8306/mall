<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*myInfo.jsp*/
	
	상단 메뉴바에서 사람 아이콘 클릭시 올 수 있는 페이지
	
	해당 페이지 안에 메뉴들이 존재하며
	메뉴를 따라 정보수정,비밀번호변경,회원탈퇴 등의 기능이 가능한 페이지로 이동할 수 있다
	
	이 페이지는 정보수정이 가능한 페이지 이다.
 -->
<%
	// 비로그인 시
	if(session.getAttribute("loginMemberEmail") == null){
		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ordersList</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<style>
	.align-left{text-align:left;}
	.align-center{text-align:center;}
	.align-right{text-align:right;}
	.ver-middel{vertical-align:midde;}
	.color-black{color:black};
</style>
</head>
<body>
	<!-- 메뉴바 -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	
	<!-- jsp -->
	<%
		String loginMemberEmail = session.getAttribute("loginMemberEmail").toString();
		MemberDao memberDao = new MemberDao();
		Member m = memberDao.selectMemberOne(loginMemberEmail);
		
	%>
	
	<!-- 내 정보 -->
	<div class="container form-group">
		<table class="table">
			<tr>
				<td>
					<!-- 마이페이지 메뉴 -->
					<jsp:include page="/inc/myPageMenu.jsp"></jsp:include>
				</td>		
				<td style="width:750px">
					<!-- 내용 -->
					<form method="post" action="<%=request.getContextPath()%>/member/modifyMemberInfoAction.jsp">
						<table class="table" style="width:750px">
							<thead class="thead-light">
								<tr>
									<th colspan="2">회원 정보</th>
								</tr>
							</thead>
							<tr>
								<th>이름 : </th>
								<td style="width:650px"><input name="memberName" class="form-control" type="text" value="<%=m.getMemberName()%>"></td>
							</tr>
							<tr>
								<th>이메일 : </th>
								<td><input name="memberEmail" type="hidden" value="<%=m.getMemberEmail()%>"><%=m.getMemberEmail()%></td>
							</tr>
							<tr>
								<th>가입일 : </th>
								<td><%=m.getMemberDate()%></td>
							</tr>
							<tr>
								<th colspan="2"><button class="btn btn-primary" type="submit">변경사항 저장</button></th>
							</tr>
						</table>
					</form>
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 최하단 -->
	<div>
		<jsp:include page="/inc/bottomMenu.jsp"></jsp:include>
	</div>
</body>
</html>