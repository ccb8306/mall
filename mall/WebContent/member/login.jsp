<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 비정상 적인 접근일 시
	if(session.getAttribute("loginMemberEmail") != null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
<!-- 
	/*login.jsp*/
	
	 페이지 접속후 로그인 버튼을 누르거나
	로그인이 필요한 페이지에 접속시 이 페이지로 이동됨.
	
	로그인 버튼을 누르면loginAction.jsp로 넘어가며
	로그인 성공 시 index.jsp로 이동하며
	로그인 실패시 이 페이지에 잔류함.
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
</head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<style>
	.align-left{text-align:left;}
	.align-center{text-align:center;}
	.align-right{text-align:right;}
	.color-black{color:black};
</style>
<body>
<div style="margin-top: 100px;"></div>
<!-- 로그인 폼 -->
<div style="width:430px" class="container form-group">	
	<form method="post" action="<%=request.getContextPath() %>/member/loginAction.jsp">
	
		<!-- 로고 -->
		<h2 class="align-center"><a class="color-black" href="<%=request.getContextPath() %>/index.jsp">Goodee Shop</a></h2>
		
		<!-- 로그인 -->
		<table style="margin-top:15px" class="table table-borderless">
			<thead class="thead-light">
				<tr>
					<th class="align-center" style="align-center" colspan="2"><h3>Login</h3></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width:15%" class="align-center" >
						<i class='fas fa-user-alt' style='font-size:36px; color:gray'></i>
						 </td>
					<td><input type="text" name="memberEmail" class="form-control"  placeholder="Email" value="user@naver.com"></td>
				</tr>
				<tr>
					<td style="width:15%" class="align-center" >
						<i class='fas fa-key' style='font-size:36px; color:gray'></i> 
					</td>
					<td><input type="password" name="memberPw" class="form-control"  placeholder="****" value="1234"></td>
				</tr>
			</tbody>
		</table>
		<button class="btn btn-primary btn-block" type="submit">로그인</button>
	</form>
	<a class="align-center page-link bg-muted" href="<%=request.getContextPath() %>/member/signup.jsp">회원가입</a>
</div>
</body>
</html>