<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*modifyMemberPw.jsp*/
	
	상단 메뉴바에서 사람 아이콘 클릭시 올 수 있는 페이지
	
	해당 페이지 안에 메뉴들이 존재하며
	메뉴를 따라 정보수정,비밀번호변경,회원탈퇴 등의 기능이 가능한 페이지로 이동할 수 있다
	
	이 페이지는 회원의 비밀번호를 변경할 수 있는 페이지다.
	
	현재비밀번호와 바꿀 비밀번호를 입력후
	변경 버튼을 누르면
	modifyMemberPwAction.jsp로 이동함.
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
<title>myPage</title>
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
	
	<!-- 비밀번호 확인 -->
	<div class="container form-group">
		<table class="table">
			<tr>
				<td>
					<!-- 마이페이지 메뉴 -->
					<jsp:include page="/inc/myPageMenu.jsp"></jsp:include>
				</td>
				<td style="width:750px">
					<!-- 내용 -->
					<form method="post" action="<%=request.getContextPath()%>/member/modifyMemberPwAction.jsp">
						<input type="hidden" name="memberEmail" value="<%=loginMemberEmail%>">
						<table class="table" style="width:750px">
							<thead class="thead-light">
								<tr>
									<th colspan="2">비밀번호 변경</th>
								</tr>
							</thead>
							<tr>
								<th>현재 비밀번호  : </th>
								<td style="width:550px"><input name="beginMemberPw" class="form-control" type="password"></td>
							</tr>
							<tr>
								<th>변경할 비밀번호  : </th>
								<td style="width:550px"><input name="afterMemberPw" class="form-control" type="password"></td>
							</tr>
							<tr>
								<th colspan="2"><button class="btn btn-outline-danger" type="submit">비밀번호 변경</button></th>
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