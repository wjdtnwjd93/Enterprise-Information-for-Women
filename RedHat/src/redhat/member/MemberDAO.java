package redhat.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import redhat.member.Member;
import redhat.member.MemberDAO;
import redhat.util.DBManager;

public class MemberDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	Logger logger = LoggerFactory.getLogger(MemberDAO.class);
	
	public boolean addMember(Member member) {
		conn = DBManager.getConnection();
		String sql = "insert into redhat_member(name, uid, passwd) values(?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getUid());
			pstmt.setString(3, member.getPasswd());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
	
	public boolean outMember(String uid) {
		conn = DBManager.getConnection();
		String sql = "delete from redhat_member where uid=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
	public boolean login(String uid, String passwd) {
		conn = DBManager.getConnection();
		String sql = "select uid, passwd from redhat_member where uid = ?";
		boolean result = false;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			rs.next();
			if(rs.getString("passwd").equals(passwd))
				result=true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	
	public ArrayList<String> getNewMembers() {
		ArrayList<String> nmembers = new ArrayList<String>();
		conn = DBManager.getConnection();
		String sql = "select * from redhat_member order by date desc limit 0,7";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				nmembers.add(rs.getString("uid"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return nmembers;
	}

}
