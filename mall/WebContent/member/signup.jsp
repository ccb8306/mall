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

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- java script -->
<script>
	$(document).ready(function(){ 
		$("#btn").click(function(){
			if($("#memberEmail").val().length < 1){
				alert("이메일을 입력해 주세요.");
				$("#memberEmail").focus();
				return;
			}else if($("#memberPw").val().length < 1){
				alert("비밀번호를 입력해 주세요.");
				$("#memberPw").focus();
				return;
			}else if($("#memberPw2").val().length < 1){
				alert("비밀번호 확인을 입력해 주세요.");
				$("#memberPw2").focus();
				return;
			}else if($("#memberName").val().length < 1){
				alert("이름을 입력해 주세요.");
				$("#memberName").focus();
				return;
			}else if($("#memberPw") != $("memberPw2")){
				alert("비밀번호가 다릅니다.");
				$("#memberPw").focus();
				return
			}
			$("#signupForm").submit();
		});
	});
</script>
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
	<form id="signupForm" method="post" action="<%=request.getContextPath() %>/member/signupAction.jsp">
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
					<td style="width:30%" class="align-right" >이메일 : </td>
					<td><input id="memberEmail" type="text" name="memberEmail" class="form-control"></td>
				</tr>
				<tr>
					<td class="align-right" >비밀번호 : </td>
					<td><input id="memberPw" type="password" name="memberPw" class="form-control"></td>
				</tr>
				<tr>
					<td class="align-right" >비밀번호 확인 : </td>
					<td><input id="memberPw2" type="password" name="memberPw2" class="form-control"></td>
				</tr>
				<tr>
					<td class="align-right" >이름 : </td>
					<td><input id="memberName" type="text" name="memberName" class="form-control"></td>
				</tr>
			</tbody>
		</table>
		<button id="btn" class="btn btn-primary btn-block" type="button">회원가입</button>
	</form>
</div>
</body>
</html>