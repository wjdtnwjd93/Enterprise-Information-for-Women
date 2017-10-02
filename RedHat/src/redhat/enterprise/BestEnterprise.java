package redhat.enterprise;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import redhat.util.DBManager;

public class BestEnterprise {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	int i=0;
	String[] ecode = {"","",""};
	double[] eavg = {0,0,0};
	String[] ename = {"","",""};
	EnterpriseDAO edao = new EnterpriseDAO();
	
	public BestEnterprise() {
		try {

			Class.forName("com.mysql.jdbc.Driver");
			conn = DBManager.getConnection();
			
			// total_evaluation이 가장 높은 기업 3개의 e_code와 avg(total_evaluation)를 가져온다.
			String sql = "select e_code, avg(total_evaluation) from enterprise_evaluation group by e_code order by avg(total_evaluation) DESC LIMIT 3;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			
			// 가져온 기업과 평균 값을 저장한다. 
			while (rs.next()) {
				ecode[i] = rs.getString("e_code");
				eavg[i] = rs.getDouble("avg(total_evaluation)");
				i=i+1;
			}
			
		} catch (Exception e) {
			 e.printStackTrace();
		} finally {
	         try {
	        	 	rs.close();
		            pstmt.close();
		            conn.close();
		         } catch (SQLException e) {
		            e.printStackTrace();
		         }
		}
	}
	
	//1위 기업의 이름을 리턴한다.
	public String getBestEnterpriseName1() {
		//EnterpriseDAO의 findEnterpriseName를 이용해 ecode를 가져온다.
		String name = edao.findEnterpriseName(ecode[0]);
		return name;
	}
	
	//2위 기업의 이름을 리턴한다.
	public String getBestEnterpriseName2() {
		//EnterpriseDAO의 findEnterpriseName를 이용해 ecode를 가져온다.
		String name = edao.findEnterpriseName(ecode[1]);
		return name;
	}
	
	//3위 기업의 이름을 리턴한다.
	public String getBestEnterpriseName3() {
		//EnterpriseDAO의 findEnterpriseName를 이용해 ecode를 가져온다.
		String name = edao.findEnterpriseName(ecode[2]);
		return name;
	}
}