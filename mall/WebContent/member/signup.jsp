<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginMemberEmail") != null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>

<!-- 
	/*signup.jsp*/
	
	메뉴바에있는 회원가입 버튼이나
	login.jsp에 있는 회원가입 버튼으로 올 수 있는 
	회원가입 페이지 이다.
	
	회원 정보를 입력 후 회원가입 버튼을 누르면
	signupAction.jsp 페이지로 이동한다.
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signup</title>
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
<!-- 회원가입 폼 -->
<div style="width:520px" class="container form-group">	
	<form method="post" action="<%=request.getContextPath() %>/member/signupAction.jsp">
		<!-- 로고 -->
		<h2 class="align-center"><a class="color-black" href="<%=request.getContextPath() %>/index.jsp">Goodee Shop</a></h2>
		
		<!-- 회원가입 -->
		<table class="table table-borderless">
			<thead class="thead-light">
				<tr>
					<th class="align-center" style="align-center" colspan="2"><h3>Sign Up</h3></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width:20%" class="align-right" >이메일 : </td>
					<td><input type="text" name="memberEmail" class="form-control"></td>
				</tr>
				<tr>
					<td style="width:20%" class="align-right" >비밀번호 : </td>
					<td><input type="password" name="memberPw" class="form-control"></td>
				</tr>
				<tr>
					<td style="width:20%" class="align-right" >이름 : </td>
					<td><input type="text" name="memberName" class="form-control"></td>
				</tr>
			</tbody>
		</table>
		<button class="btn btn-primary btn-block" type="submit">회원가입</button>
	</form>
</div>
</body>
</html>