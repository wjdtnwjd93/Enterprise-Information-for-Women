<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sns"%>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="best" class="redhat.enterprise.BestEnterprise"/>
<jsp:setProperty name="best" property="*"/>
<!DOCTYPE HTML>
<html>
<head>
   <link href="//fonts.googleapis.com/earlyaccess/nanumgothic.css" 
   rel="stylesheet" type="text/css">
   <link rel=icon href="" type="image/x-icon">
   <link rel="stylesheet" href="css/style.css" type="text/css">
   <meta name="description" content="여성 구직자를 위한 기업, 채용, 복지 정보가 모두 모인 곳!">
   <title>기업 정보 for Women</title>
   
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

   <script>
   function newuser() {
      window.open(
            "new_user.jsp",
            "newuser",
            "titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=700,height=500");
   }
  
   </script>
</head>
<body>
   <div class="main-header-container"> <!--상단 메뉴 공간-->
      <div class="main-header-contents">
         <img src="img/main_logo.png" class="main-header-logo-btn"> <!--로고 이미지-->
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
         <li id="mainHeaderJoi `nBtn" class="main-header-menu-item">
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
         <div class="main-title">
         	<img class="main-image" src="img/main_img.png"><br>
            <b>여성 복지 우수 기업,<br>
            가족 친화 기업 정보를 한 곳에서!</b><br>
            <p class="main-title-link-text"><a href="info.html" class="main-contents-link" target="_blank">
            *가족 친화 인증이란?</a></p>
         </div>
         <div id=mainSearchArea class="main-search-area">
         <!-- 검색 기능 공간 -->
            <div class="main-search-container">
              <form action="searchEnt.jsp" method="post">
               <input type="search" class="main-search-query" name="entName" placeholder="기업 이름을 입력하세요." onkeydown="if(event.keyCode==13) submit();"> 
               <img src="img/search_image.png" class="main-search-icon" onclick="submit();">
               </form>
            </div>
            <!--우선 순위 선택 공간-->
            <div class="main-priority-container">
               <ul class="main-priority-menu">
                  <li class="main-priority-menu-item-top"><b>조회우선순위</b></li>
                  <li class="main-priority-menu-item">총평점<input type="radio" value="total" name="priority"></li>
                  <li class="main-priority-menu-item">여성복지<input type="radio" value="women" name="priority"></li>
                  <li class="main-priority-menu-item">승진기회<input type="radio" value="promotion" name="priority"></li>
                  <li class="main-priority-menu-item">성평등<input type="radio" value="gender" name="priority"></li>
                  <li class="main-priority-menu-item"><input type="button" class="button" value="조회" onClick="inquiry()"/></li>
               </ul>
            </div>
         </div>
         <div class="main-best-review-list">
         <!-- 베스트 리뷰 기업 리스트 -->
            <div class="sub-title">
               <b>베스트 평점 기업</b>
               <ul class="sub-list">
               	 <% String entName = best.getBestEnterpriseName1();%>
               	 <% String entName1 = best.getBestEnterpriseName2();%>
               	 <% String entName2 = best.getBestEnterpriseName3();%>
                  <li class="sub-list-item">
                  <form action="searchEnt.jsp" method="post" >
                  <input type= "submit" name="entName" value="<%=entName%>"  >       
                  </form></li>
                
                  <li class="sub-list-item">
                  <form action="searchEnt.jsp" method="post" >
                  <input type= "submit"  name="entName" value="<%=entName1%>"  >       
                  </form></li>
                  
                  <li class="sub-list-item">
                  <form action="searchEnt.jsp" method="post" >
                  <input type = "submit"  name="entName" value="<%=entName2%>">
                  </form></li>   
                                     
               </ul>
            </div>
         </div>
            </div>
         </div>
         <div class="main-recent-comment-list">
         <!-- 최근 댓글 리스트 -->
            <div class="sub-title">
               <b>최신 댓글</b>
               <ul class="sub-list">
                  <li class="sub-list-item">Test1</li>
                  <li class="sub-list-item">Test2</li>
                  <li class="sub-list-item">Test3</li>
               </ul>
            </div>
         </div>
         <div class="main-recent-employment-list">
            <div class="sub-title">
               <b>잡코리아 주간 공채</b>
            </div>
            <div class="main-recent-employment-calander">
               <iframe id="pageFrame" name="pageFrame" 
                  src="http://www.jobkorea.co.kr/Starter/calendar/sub/week?edu=5" frameborder="0"
                  width="890px" height="300px" scrolling="auto"></iframe>
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