<%@ page language="java"     contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title> Logout </title>
</head>
<body>
 
    <%
    // 로그아웃 버튼을 누르면 오게되는 곳인데
    // session을 재시작해서 저장된 정보를 날린다
   	session.removeAttribute("name");
    response.sendRedirect("main_page.jsp");

    %>
 
</body>
</html>
