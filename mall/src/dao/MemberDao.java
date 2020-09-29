package dao;
import commons.*;
import vo.*;
import java.sql.*;

public class MemberDao {
	// ȸ������ - ����� ���̵�(�̸���) �ߺ� Ȯ��
	public Member selectMemberEmailCk(String memberEmail)throws Exception {
		Member m = null;
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT id FROM (SELECT member_email id FROM member UNION SELECT admin_id id FROM admin) t WHERE id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberEmail);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			m = new Member();
			m.setMemberEmail(rs.getString("id"));
		}
		
		return m;
	}
	
	// ȸ������ - ȸ�� ���
	public void insertMember(Member member)throws Exception {
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = dbUtil.getConnection();
		
		String sql = "insert into member(member_email, member_pw, member_name, member_date) values(?,?,?,now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberEmail());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());
		
		stmt.executeQuery();
	}
	
	// �α��� - ����� Ȯ��
	public String selectMemberCk(Member member)throws Exception{
		String memberEmail = null;

		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		
		String sql = "select member_email from member where member_email=? and member_pw=? and member_state='Y'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberEmail());
		stmt.setString(2, member.getMemberPw());	
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			memberEmail = rs.getString("member_email");
		}
		
		return memberEmail;
	}
	
	// �̸��Ϸ� �̸� ��������
	public String selectNameByEmail(String Email)throws Exception {
		String name = "";
		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		
		String sql = "select member_name from member where member_email=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, Email);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			name = rs.getString("member_name");
		}
		
		return name;
	}
	
	// ȸ�� �󼼺���(����������)
	public Member selectMemberOne(String memberEmail)throws Exception {
		Member member = null;
		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		
		String sql = "select member_email, member_name, member_date from member where member_email=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberEmail);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			member = new Member();
			member.setMemberEmail(rs.getString("member_email"));
			member.setMemberName(rs.getString("member_name"));
			member.setMemberDate(rs.getString("member_date"));
		}
		
		return member;
	}
	
	// ȸ���������� --> �̸��� ����
	public void updateMemberInfo(Member member)throws Exception {
		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		
		String sql = "update member set member_name=? where member_email=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberName());
		stmt.setString(2, member.getMemberEmail());
	    stmt.executeUpdate();
		
	}
	
	// ȸ�� ��й�ȣ ����
	public void updateMemberPw(Member member)throws Exception {
		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		
		String sql = "update member set member_pw=? where member_email=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberPw());
		stmt.setString(2, member.getMemberEmail());
	    stmt.executeUpdate();
		
	}
	
	// ȸ�� Ż�� --> ȸ�� ���¸� Ż��('N')�� �ٲ�
	public void updateMemberState(String memberEmail)throws Exception{
		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		String sql = "update member set member_state='N' where member_email=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberEmail);
		
		stmt.executeUpdate();
	}
}
