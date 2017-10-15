<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import ="java.sql.*"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sns"%>
<%@ page session = "true" %>
<jsp:useBean id="dbm" class="redhat.util.DBManager" />
<!DOCTYPE HTML>
<html>
<head>
   <link rel=icon href="" type="image/x-icon">
   <link rel="stylesheet" href="css/style.css" type="text/css">
   <meta name="description" content="여성 구직자를 위한 기업, 채용, 복지 정보가 모두 모인 곳!">
   	<style>
	body {
	    opacity: 0;
	    transition: 1s opacity;
	}
	body.fadeIn {
	    opacity: 1;
	}
	</style>
	
	<script>
	window.onload = function() {
	    document.body.className += ' fadeIn';
	}
	</script>
   <title>기업정보 For Women</title>
   <script>
   
   
   function newuser() {
      window
            .open(
                  "new_user.jsp",
                  "newuser",
                  "titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=300,height=240");
   }
   </script>
   	<script>
	function mainpage() {
    window.location.replace('main_page.jsp');}  
	</script>	
</head>
<body>
<div class="main-header-container"> <!--상단 메뉴 공간-->
      <div class="main-header-contents">
         <img src="img/main_logo.png" class="main-header-logo-btn"> <!--로고 이미지-->
         <div class="entinfo-header-scrape-area-left">
				<input class="button-top" type="button" value="메인으로" onClick="mainpage();" /> 
		</div>
      </div>
      <ul class="main-header-menu">
           <%
           	
           if(session.getAttribute("uid")!=null&&!session.getAttribute("uid").equals("admin"))
           {
           %>
           <li id="mainHeaderScrapeBtn" class="main-header-menu-item">
         	  <a href="scrap_list.jsp">스크랩</a>
           </li> 
           <%};%>
         <li id="mainHeaderJoinBtn" class="main-header-menu-item">
            <%
            if(session.getAttribute("uid")==null)
            {
        	%>
         <li id="mainHeaderJoinBtn" class="main-header-menu-item">
            <a href="javascript:newuser()">회원가입</a>
         </li>
       	  <% }; %>
         <li class="main-header-menu-item"><sns:login/></li>
      </ul>
   </div>
   <div class="main-contents-container"> <!-- 내용 공간 -->
      <div class="main-contents">
	<%
	
	   String  uid = (String)session.getAttribute("uid");
	   Connection conn = null;                                      
	   PreparedStatement pstmt = null;
	   ResultSet rs =null;
	   String e_name, date;
	   String sql = null;
	   int i=0;
	   try{
	
	      Class.forName("com.mysql.jdbc.Driver");                       
	      // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	      //conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jspbook? useUnicode=true&characterEncoding=utf-8","jspbook","1234");               
	      // DB연결
	      conn = dbm.getConnection();
	      sql = "select * from redhat_member where uid = ?"; 
	      pstmt = conn.prepareStatement(sql);   
	      pstmt.setString(1,uid);
	      rs = pstmt.executeQuery();
	      if(rs.next()) {
	         out.println("<h2>"+rs.getString("name")+"님의 스크랩 목록입니다. </h2>");
	      }
	      else {
	         out.println("<script>alert('로그인 후 이용 가능합니다.');history.go(-1);</script>");
	      }
	      
	      sql = "select * from enterprise_scrap where uid = ? order by scrap_date";      
	      // sql 쿼리
	      pstmt = conn.prepareStatement(sql);   
	      pstmt.setString(1,uid);
	      rs = pstmt.executeQuery();
	      while(rs.next()) {
	         e_name = rs.getString("e_name");
	         date = rs.getDate("scrap_date").toString();
	         i++;
	         out.println(i+". 기업 이름: " + e_name + " 날짜: "+date +"<br>");
	      }
	   
	   } catch(Exception e){                                                    
		   // 예외가 발생하면 예외 상황을 처리한다.
	      e.printStackTrace();
	      
	   }finally{                                                            
		   // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다. (순서중요)
	      if(rs != null) try{rs.close();}catch(SQLException sqle){}    
	      if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}            
	      // PreparedStatement 객체 해제
	      if(conn != null) try{conn.close();}catch(SQLException sqle){}            
	      // Connection 해제
	}
	
	%>      
      </div>
   </div>
   <div class="main-footer-contents">
         <center>
      <p class="main-footer-text">
	   2017 redhat PINK CODING FEST<br>
	      기업정보 for Women<br>
	      덕성여자대학교 정수정 강문정 강연우<br>
      </p>
      </center>
   </div>

</body>
</html>