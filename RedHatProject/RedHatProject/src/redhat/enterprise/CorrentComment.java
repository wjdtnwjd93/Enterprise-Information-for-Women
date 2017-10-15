package redhat.enterprise;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import redhat.util.DBManager;

public class CorrentComment {
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   
   int i=0;

   // 최신 댓글 정보 담을 변수
   String[] ecode = {"","",""};
   String[] ename = {"","",""};
   String[] comment = {"","",""};
   String[] date = {"","",""};
   
   EnterpriseDAO edao = new EnterpriseDAO();
   
   public CorrentComment() {
      try {

         Class.forName("com.mysql.jdbc.Driver");
         conn = DBManager.getConnection();
         
         // 기업 코드, 최신 댓글, 날짜를 가져온다.
         String sql = "select e_code, reply_content, current from enterprise_reply order by current DESC LIMIT 3;";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         
         
         while (rs.next()) {
            ecode[i] = rs.getString("e_code");
            comment[i] = rs.getString("reply_content");
            date[i] = rs.getDate("current").toString();
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
   public String getEnterpriseName(int i) {
      //기업 코드를 기업명으로 변경
      String name = edao.findEnterpriseName(ecode[i]);
      return name;
   }
   public String getComment(int i) {
      return comment[i];
   
   }
   public String getDate(int i) {
      return date[i];
   }
   

}