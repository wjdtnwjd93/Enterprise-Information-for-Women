package redhat.enterprise;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import redhat.util.DBManager;


public class EnterpriseDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	Logger logger = LoggerFactory.getLogger(EnterpriseDAO.class);

	// 기업 정보 데이터를 추가하는 메소드 (엑셀 파일에서 읽어온 정보 사용)
	// 기업 코드, 기업 이름, 가족친화여부
	public void insertEntData(String e_code, String e_name, boolean e_family) {
		conn = DBManager.getConnection(); // DB 연결
		String sql = "insert into enterprise_data values('" // 
				+ e_code + "', '" + e_name + "', " + e_family + ");"; //SQL Query
		
		// 쿼리 실행
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		} finally { // DB 닫기
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 기업 코드로 이름를 찾는 메소드
		public String findEnterpriseName(String e_code) {
			conn = DBManager.getConnection();
			String sql = "select e_name from enterprise_data where e_code = ?";
			//boolean result = false;
			String name = "";
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, e_code);
				rs = pstmt.executeQuery();
				rs.next();
				name = rs.getString("e_name");
			} catch (SQLException e) {
				e.printStackTrace();
				return name;
			}
			finally {
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return name;
		}
	
	// 기업이름로 코드를 찾는 메소드
	public String findEnterprise(String e_name) {
		conn = DBManager.getConnection();
		String sql = "select e_code from enterprise_data where e_name = ?";
		boolean result = false;
		String code = "";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, e_name);
			rs = pstmt.executeQuery();
			rs.next();
			code = rs.getString("e_code");
		} catch (SQLException e) {
			e.printStackTrace();
			return code;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return code;
	}
	
	public ArrayList<String> getNewEnterprise() {
		ArrayList<String> enterprises = new ArrayList<String>();
		conn = DBManager.getConnection();
		String sql = "select * from enterprise_data order by date desc limit 0,7";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				enterprises.add(rs.getString("e_name"));
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
		return enterprises;
	}
	
	   //기업 이름으로 가족친화기업을 판단
	   public boolean findEnterpriseFamily(String e_name){
	      conn = DBManager.getConnection();
	      String sql = "select e_family from enterprise_data where e_name = ?";
	      boolean result = false;
	      try {
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, e_name);
	         rs = pstmt.executeQuery();
	         rs.next();
	         result = rs.getBoolean("e_family");
	      } catch (SQLException e) {
	         e.printStackTrace();
	         return result;
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
	
}
