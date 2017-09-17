<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page session="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 확인</title>
</head>
<body>
</head>
<body>
<%
 String id = request.getParameter("id");
 String pw = request.getParameter("pw");

 id = new String(id.getBytes("8859_1"), "utf-8");
 pw = new String(pw.getBytes("8859_1"), "utf-8");
 
 Connection conn = null;
 Statement stmt = null;
 ResultSet rs = null;
 Boolean isLogin = false;
 
 try{
   Class.forName("com.mysql.jdbc.Driver");
   conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jspbook?" +
     "characterEncoding=utf-8", "root","1234");
   
   stmt = (Statement) conn.createStatement();
   // 현재 페이지의 글 가져오기
   rs = stmt.executeQuery("select * from redhat_member where uid='" + id + "' and passwd='" + pw + "'" );

   String name = null;
   while( rs.next() )
   {
	name = rs.getString("name");   
    session.setMaxInactiveInterval(3600);
    session.setAttribute( "name", name );
    
    isLogin = true;
    response.sendRedirect("main_page.jsp");
    %>
               
                <%
   }
   
   if( !isLogin )
   {
    out.print( "회원정보가 없습니다. " );
    %>
                    <input type="button" name="input" value="뒤로가기" onClick="javascript:window.location.href('login_page.jsp')"/>
                <%
   }
  }
  
  catch(ClassNotFoundException cnfe){
   out.println("해당 클래스를 찾을 수 없습니다." + cnfe.getMessage());
  }
  
  catch(SQLException se){
   out.println(se.getMessage());
  }
  
  try{
   	conn.close();
  }
  catch(SQLException e){
   out.println(e.getMessage());
  }
%>

</body>
</html>