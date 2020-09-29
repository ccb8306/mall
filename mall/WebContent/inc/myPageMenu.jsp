<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 마이페이지 메뉴바 
	마이페이지에 들어갈 시 좌측에 존재하는 메뉴바 -->
<table class="table" style="width:150px">
	<thead class="thead-dark ver-middle" >
		<tr><th class="ver-middle align-center" style="height:100px;"><h5>마이페이지</h5></th></tr>
	</thead>
	<tr><td><a class="color-black" href="<%=request.getContextPath() %>/member/myInfo.jsp">회원정보</a></td></tr>
	<tr><td><a class="color-black" href="<%=request.getContextPath() %>/member/modifyMemberPw.jsp">비밀번호 변경</a></td></tr>
	<tr><td><a class="color-black" href="<%=request.getContextPath() %>/member/modifyMemberState.jsp">회원탈퇴</a></td></tr>
</table>