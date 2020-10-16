<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!-- 
	/*modifyMemberPwAction.jsp*/
	
	modifyMemberPw.jsp에서 비밀번호 변경 버튼을 누를시 실행되는 액션
	
	회원 정보(이메일,비밀번호)가 일치 할 경우 비밀번호 변경 후 myInfo.jsp로 이동
	일치하지 않을 경우 modifyMemberPw.jsp로 이동
 -->
<%
	request.setCharacterEncoding("utf-8");

	// 비로그인 일 시
	if(session.getAttribute("loginMemberEmail") == null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 정보 저장
	String memberEmail = request.getParameter("memberEmail");
	String beginMemberPw = request.getParameter("beginMemberPw");
	String afterMemberPw = request.getParameter("afterMemberPw");

	// 디버깅
	System.out.println(memberEmail + "<--memberEmail");
	System.out.println(beginMemberPw + "<--beginMemberPw");
	System.out.println(afterMemberPw + "<--afterMemberPw");
	
	Member m1 = new Member();
	m1.setMemberEmail(memberEmail);
	m1.setMemberPw(beginMemberPw);
	// 비밀번호 확인
	MemberDao memberDao = new MemberDao();
	
	// 비밀번호 변경 실패
	if(memberDao.selectMemberCk(m1) == null){
		System.out.println("비밀번호 변경 실패"); // 디버깅
		response.sendRedirect(request.getContextPath() + "/member/modifyMemberPw.jsp");
		return;
	}
	
	// 비밀번호 확인 성공시
	
	Member m2 = new Member();
	m2.setMemberEmail(memberEmail);
	m2.setMemberPw(afterMemberPw);
	// 회원 정보 수정
	memberDao.updateMemberPw(m2);

	
	System.out.println("비밀번호 변경 성공"); // 디버깅
	response.sendRedirect(request.getContextPath() + "/member/myInfo.jsp");
%>