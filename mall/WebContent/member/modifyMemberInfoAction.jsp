<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!-- 
	/*modifyMemberInfoAciton.jsp*/
	
	myInfo.jsp에서 수정 버튼을 누를시 실행되는 액션
	
	회원의 정보를 수정해줌
	(아직은 회원 이름만 수정 가능)
	
	액션이 끝난후 myInfo.jsp페이지로 돌아감
 -->
<%
	request.setCharacterEncoding("utf-8");

	// 비로그인 일 시
	if(session.getAttribute("loginMemberEmail") == null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 정보 저장
	String memberName = request.getParameter("memberName");
	String memberEmail = request.getParameter("memberEmail");

	System.out.println(memberEmail + "<--memberEmail");
	System.out.println(memberName + "<--memberName");
	
	Member m = new Member();
	m.setMemberEmail(memberEmail);
	m.setMemberName(memberName);
	
	
	// 회원 정보 수정
	MemberDao memberDao = new MemberDao();
	memberDao.updateMemberInfo(m);
	
	response.sendRedirect(request.getContextPath() + "/member/myInfo.jsp");
%>