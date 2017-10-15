package redhat.enterprise.evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import redhat.message.Message;
import redhat.message.MessageSet;
import redhat.util.DBManager;

public class EvaluationDAO {
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;   
   Logger logger = LoggerFactory.getLogger(EvaluationDAO.class);
   
   //평균점수에 따라 해당 기업 코드를 보내자!
   public ArrayList<EvaluationSet> searchEnterpriseEvaluation(int number){
      ArrayList<EvaluationSet> datas = new ArrayList<EvaluationSet>();
      ArrayList<Evaluation> evluationes = new ArrayList<Evaluation>();
      conn = DBManager.getConnection();
      String sql="";
      //String e_code="";
      switch(number){
      case 1:
         sql = "select e_code, avg(total_evaluation) from enterprise_evaluation group by e_code order by avg(total_evaluation) desc";   
         break;
      case 2:
         sql = "select e_code, avg(female_welfare) from enterprise_evaluation group by e_code order by avg(female_welfare) desc";         
         break;
      case 3:
         sql = "select e_code, avg(promotion_chance) from enterprise_evaluation group by e_code order by avg(promotion_chance) desc";
         break;
      case 4:
         sql = "select e_code, avg(gender_equal) from enterprise_evaluation group by e_code order by avg(gender_equal) desc";
         break;
      default:
         break;
      }
      try{
         pstmt = conn.prepareStatement(sql);
         //pstmt.setString(2, e_code);
         //rs = pstmt.executeQuery();
         ResultSet rs = pstmt.executeQuery();   
         while(rs.next()){
            EvaluationSet est = new EvaluationSet();
            Evaluation e = new Evaluation();
            
            e.setE_code(rs.getString("e_code"));      
            evluationes.add(e);
            
            est.setEvaluation(e);
            datas.add(est);
         }   
         //e_code = rs.getString("e_code");
      }catch(SQLException e){
         e.printStackTrace();
         //return e_code;
      }
      finally {
         try {
            pstmt.close();
            conn.close();
         } catch (SQLException e) {
            e.printStackTrace();
         }
      }
      return datas;
   }
   
   public boolean insertEavaluationData(Evaluation eva){
      conn = DBManager.getConnection();
      // String uid = (eva.getUid()).trim(); 수정
     //   String ecode = (eva.getE_code()).trim(); 수정
      String sql = "insert into enterprise_evaluation(uid, e_code, total_evaluation, female_welfare, promotion_chance, gender_equal) values(?,?,?,?,?,?)";
      try {
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, eva.getUid()); 
         pstmt.setString(2, eva.getE_code()); //원래의 코드
         pstmt.setInt(3, eva.getTotal_evaluation());
         pstmt.setInt(4, eva.getFemale_welfare());
         pstmt.setInt(5, eva.getPromotion_chance());
         pstmt.setInt(6, eva.getGender_equal());
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