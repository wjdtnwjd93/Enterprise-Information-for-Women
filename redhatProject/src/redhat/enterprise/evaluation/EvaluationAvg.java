package redhat.enterprise.evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import redhat.util.DBManager;

public class EvaluationAvg {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	double total_evaluation =0, female_welfar =0, promotion_chance =0, gender_equal=0;
	public EvaluationAvg() {
		
	}
	
	// ecode에 해당하는 평점 가지고 오기 
	public void setEvaluationAvg(String ecode) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DBManager.getConnection();
			String sql = "select e_code, avg(total_evaluation), avg(female_welfare), avg(promotion_chance), avg(gender_equal) from enterprise_evaluation where e_code='"+ecode+"' group by e_code ;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				total_evaluation = rs.getDouble("avg(total_evaluation)");
				female_welfar = rs.getDouble("avg(female_welfare)");
				promotion_chance = rs.getDouble("avg(promotion_chance)");
				gender_equal = rs.getDouble("avg(gender_equal)");
			}
		} catch (Exception e) {
			 e.printStackTrace();
		}  finally {
	         try {
	        	 	rs.close();
		            pstmt.close();
		            conn.close();
		         } catch (SQLException e) {
		            e.printStackTrace();
		         }
		}
	}
	
	//총 평점 평균 가져오기
	public double getTotal_evaluation() {
		return total_evaluation;
	}
	
	//여성 복지 평점 평균 가지고 오기
	public double getFemale_welfar() {
		return female_welfar;
	}
	
	//승진 기회 평점 평균 가지고 오기
	public double getPromotion_chance() {
		return promotion_chance;
	}
	
	//성 평등 평점 평균 가지고 오기
	public double getGender_equal() {
		return gender_equal;
	}
	
}
