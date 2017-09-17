<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel=icon href="" type="image/x-icon">
	<link rel="stylesheet" href="css/style.css" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<meta name="description" content="여성 구직자를 위한 기업, 채용, 복지 정보가 모두 모인 곳!">
	<title>기업정보 For Women</title>
<title> 로그인 </title>
</head>
<body>
<center>
<div class="main-header-container"> <!--상단 메뉴 공간-->
		<div class="main-header-contents">
			<a href="main_page.jsp"><img src="img/temp_logo.png" class="main-header-logo-btn"></a> <!--로고 이미지-->
		</div>
		<ul class="main-header-menu">
			<li id="mainHeaderFamBtn" class="main-header-menu-item">
				<a href="#" class="main-header-link">가족친화기업이란?</a>
			</li>
			<li id="mainHeaderScrapeBtn" class="main-header-menu-item">
				스크랩
			</li>
			<li id="mainHeaderLoginBtn" class="main-header-menu-item">
				로그인
			</li>
			<li id="mainHeaderJoinBtn" class="main-header-menu-item">
				회원가입
			</li>
		</ul>
	</div>
	<div class="main-contents-container"> <!-- 내용 공간 -->
		<div class="main-contents">
<%
        // 현재 로그인된 아이디가 없다면 (= session에 저장된 id가 없다면)
        if(session.getAttribute("name") == null) {
            %>
           
            <form action="login_check.jsp" method="post">
            <table>
            	<tr><td><input name="id" type="text"></td></tr>
            	<tr><td><input name="pw" type="password"> </td></tr>
            	<tr><td><button> 로그인 </button><button onClick="#"> 회원가입 </button></td></tr>    	
            </table>
         
            </form>
            <%
        } 
        // 현재 로그인된 아이디가 있다면 (= session에 저장된 id가 있다면)
        else {
        	 response.sendRedirect("logout_page.jsp");
    
        }
    %>

	</div>	
</div>	
</center>
</body>
</html>