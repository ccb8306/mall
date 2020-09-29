<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>

<!--
 	/*modifyMemberStateAction.jsp*/
 	
 	modifyMemberState.jsp에서 회원탈퇴 버튼을 누를시 실행되는 액션
 	
 	회원의 상태를 Y 에서 N으로 바꿔 회원탈퇴 된 상태로 변경시켜준다.
 	
 	본인확인 성공시  회원탈퇴가 진행되며
 	logoutAction.jsp로 이동해 세션을 초기화 시켜준다
 	
 	본인확인 실패시 modifyMemberState.jsp로 이동한다
 -->

<%
	// 비정상적인 접근일 시
	if(session.getAttribute("loginMemberEmail") == null){
		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
		return;
	}
	
	// 회원 정보
	String memberEmail = request.getParameter("memberEmail");
	String memberPw = request.getParameter("memberPw");
	
	Member member = new Member();
	member.setMemberEmail(memberEmail);
	member.setMemberPw(memberPw);

	System.out.println(memberEmail + "<--memberEmail");
	System.out.println(memberPw + "<--memberPw");
	
	// 본인 확인
	MemberDao memberDao = new MemberDao();
	// 본인확인 실패 시
	if(memberDao.selectMemberCk(member) == null){
		response.sendRedirect(request.getContextPath() + "/member/modifyMemberState.jsp");
		return;
	}
	
	// 본인확인 성공시
	// 회원탈퇴
	memberDao.updateMemberState(memberEmail);
	response.sendRedirect(request.getContextPath() + "/member/logoutAction.jsp");
%>