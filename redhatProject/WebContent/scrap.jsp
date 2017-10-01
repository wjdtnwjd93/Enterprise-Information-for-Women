<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.* "%>
<%@page import="com.mysql.jdbc.Driver"%>
<jsp:useBean id="dbm" class="redhat.util.DBManager" />
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>스크랩 중</title>
</head>
<body>
<%

   String  uid = (String)session.getAttribute("uid");
   String e_name = request.getParameter("e_name");  // 사용자 계정
   e_name = e_name.trim();
   String e_code = request.getParameter("e_code");
   e_code = e_code.trim();
   Connection conn = null;                                      
   PreparedStatement pstmt = null;
   try{

      Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
      //conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jspbook? useUnicode=true&characterEncoding=utf-8","jspbook", "1234");               
      // DB연결
      conn = dbm.getConnection();
      
      String sql = "insert into enterprise_scrap values(?,?,?,sysdate())";        // sql 쿼리
      pstmt = conn.prepareStatement(sql);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
      pstmt.setString(1,uid);
      pstmt.setString(2,e_code);
      pstmt.setString(3,e_name);
      pstmt.executeUpdate();                                        // 쿼리를 실행한다.
      out.println("<Script>alert('스크랩되었습니다.');history.go(-1);</Script>");        // 성공시 메시지 출력
   } catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
      e.printStackTrace();
      out.println("<script>alert('이미 스크랩된 기업입니다.');history.go(-1);</script>");
   }finally{                                                            // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다. (순서중요)

      if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}            // PreparedStatement 객체 해제
      if(conn != null) try{conn.close();}catch(SQLException sqle){}            // Connection 해제
}
%>
</body>
</html>