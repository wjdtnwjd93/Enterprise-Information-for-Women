<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sns"%>
<jsp:useBean id="best" class="redhat.enterprise.BestEnterprise"/>
<jsp:setProperty name="best" property="*"/>
<jsp:useBean id="comment" class="redhat.enterprise.CorrentComment"/>
<jsp:setProperty name="comment" property="*"/>
<%request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE HTML>
<html>
<head>
   <link href="//fonts.googleapis.com/earlyaccess/nanumgothic.css" 
   rel="stylesheet" type="text/css">
   <link rel=icon href="" type="image/x-icon">
   <link rel="stylesheet" href="css/style.css" type="text/css">
   <meta name="description" content="여성 구직자를 위한 기업, 채용, 복지 정보가 모두 모인 곳!">
   <title>기업 정보 for Women</title>
   <script>
   function newuser() {
      window.open(
            "new_user.jsp",
            "newuser",
            "titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=700,height=500");
   }
   </script>
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
            <form action="searchPriority.jsp" method="post">
            <div class="main-priority-container">
             
                  <b>조회우선순위</b>
                  <form action="searchPriority" method="post">
             		총평점<input type="radio" value="1" name="priority">
                  	여성복지<input type="radio" value="2" name="priority">
                 	승진기회<input type="radio" value="3" name="priority">
                  	성평등<input type="radio" value="4" name="priority">
               		<input type="submit" class="button" value="조회"/>
               	 </form>
            </div>
            </form>
         </div>
         <div class="main-best-review-list">
         <!-- 베스트 리뷰 기업 리스트 -->
              <div class="sub-title">
               <b>베스트 평점 기업</b>
              <ul class="sub-list">
               	 <% 
                  String entName[] = {"","",""};
                  for(int i = 0;i<3;i++) 
                     entName[i] = best.getBestEnterpriseName(i);
                  %>
                  <li class="sub-list-item">
                  <form action="searchEnt.jsp" method="post" >
                  <input class="main-sub-item" type= "submit" name="entName" value="<%= entName[0]%>"  >       
                  </form></li>
                         
                   <li class="sub-list-item">
                  <form action="searchEnt.jsp" method="post" >
                  <input class="main-sub-item" type= "submit"  name="entName" value="<%= entName[1]%>"  >       
                  </form></li>
                  
                  <li class="sub-list-item">
                  <form action="searchEnt.jsp" method="post" >
                  <input class="main-sub-item" type = "submit"  name="entName" value="<%= entName[2]%>">
                  </form></li>     
                                     
               </ul>
            </div>
         </div>
         </div>
         <div class="main-recent-comment-list">
          <div class="sub-title">
               <b>최신 댓글</b>
               <ul class="sub-list">
                 <%
                 String enter[]={"","",""}; 
                 String com[]={"","",""};
                 String date[]={"","",""};
                 for(int i = 0;i<3;i++) {
                    enter [i]=comment.getEnterpriseName(i);
                    com[i] = comment.getComment(i);
                    date[i] = comment.getDate(i); 
                 }      %>
                 
                  <li class="sub-list-item2"><form action="searchEnt.jsp" method="post" >[<input class="main-sub-item-com" type= "submit" name="entName" value="<%= enter[0]%>">]  <%= com[0]%> | <%= date[0]%>
                  </form></li>
                  <li class="sub-list-item2"><form action="searchEnt.jsp" method="post" >[<input class="main-sub-item-com" type= "submit" name="entName" value="<%= enter[1]%>">] <%= com[1]%> | <%= date[1]%>   
                  </form></li>
                  <li class="sub-list-item2"><form action="searchEnt.jsp" method="post" >[<input class="main-sub-item-com" type= "submit" name="entName" value="<%= enter[2]%>">] <%= com[2]%> | <%= date[2]%>
                  </form></li>
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