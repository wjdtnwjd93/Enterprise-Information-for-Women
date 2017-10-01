package redhat.enterprise.evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import redhat.enterprise.Enterprise;
import redhat.util.DBManager;

public class EvaluationDAO {
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   
   Logger logger = LoggerFactory.getLogger(EvaluationDAO.class);
   
   
   public boolean insertEavaluationData(Evaluation eva){
      Enterprise enterprise = new Enterprise(); //추가한 코드
      conn = DBManager.getConnection();
      // 공백 없애기...
      String uid = (eva.getUid()).trim();
      String ecode = (eva.getE_code()).trim();
      
      String sql = "insert into enterprise_evaluation(uid, e_code, total_evaluation, female_welfare, promotion_chance, gender_equal) values(?,?,?,?,?,?)";
      try {
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, uid);
         pstmt.setString(2, ecode); //원래의 코드
         //pstmt.setString(1, enterprise.getE_code()); //변경한 코드
         //pstmt.setString(1, "035420"); 
         System.out.println("enterprise 클래스 기업코드 출력하기: "+enterprise.getE_code());
         System.out.println("evaluation 클래스 기업코드 출력하기: "+eva.getE_code());

         pstmt.setInt(3, eva.getTotal_evaluation());
         pstmt.setInt(4, eva.getFemale_welfare());
         pstmt.setInt(5, eva.getPromotion_chance());
         pstmt.setInt(6, eva.getGender_equal());
         //System.out.println("기업 총평점: "+eva.getTotal_evaluation());
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

}