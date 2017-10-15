<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sns"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="evaDAO" class="redhat.enterprise.evaluation.EvaluationDAO" />
<jsp:useBean id="entDAO" class="redhat.enterprise.EnterpriseDAO" />
<jsp:useBean id ="ent" class="redhat.enterprise.evaluation.Evaluation"/>
<jsp:useBean id="best" class="redhat.enterprise.BestEnterprise"/>
<jsp:setProperty name="best" property="*"/>
<jsp:useBean id="comment" class="redhat.enterprise.CorrentComment"/>
<jsp:setProperty name="comment" property="*"/>
<jsp:setProperty name="ent" property="e_code"/>
<jsp:useBean id="avg" class="redhat.enterprise.evaluation.EvaluationAvg"/>
<!DOCTYPE HTML>
<html>
<head>
<link rel="stylesheet" href="css/style.css" type="text/css">
<link href="//fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet" type="text/css">
<%
		int number = Integer.parseInt(request.getParameter("priority"));
		String title=""; // 타이틀에 들어갈 문장
		switch(number){
		case 1: title="총평점"; break;
		case 2: title="여성복지"; break;
		case 3: title="승진기회"; break;
		case 4: title="성평등"; break;
		default: title=""; break;
		}
	%>
	<title><%=title%> 순위조회</title>
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
   <div class="main-contents-container-prio"> <!-- 내용 공간 -->
   		<h2 class="main-contents-prio-title"><%=title%> 우선 순위 조회</h2>
		<table border=1>
		    <tr>
		      <th>순서</th>
     			 <th>기업이름</th>
      		<th>총평점</th>
     		 <th>여성복지</th>
      		<th>승진기회</th>
     		 <th>성평등</th>
		    <tr>
			<%
				for(int i=0; i<evaDAO.searchEnterpriseEvaluation(number).size(); i++){
					if(evaDAO.searchEnterpriseEvaluation(number).size()==0){	
			%>
			<tr>
		      <td>기업이 존재하지 않습니다.</td>
		    </tr>
			<% 			
					}else{
			%>
			   <tr>
			   		<td><%=i+1 %></td>
	   		
			<td><%=entDAO.findEnterpriseName(evaDAO.searchEnterpriseEvaluation(number).get(i).getEvaluation().getE_code()) %></td>
			<%
				avg.setEvaluationAvg(evaDAO.searchEnterpriseEvaluation(number).get(i).getEvaluation().getE_code());
			%>
			<td><%=avg.getTotal_evaluation() %></td>
			<td><%=avg.getFemale_welfar() %></td>
			<td><%=avg.getPromotion_chance() %></td>
			<td><%=avg.getGender_equal() %></td>	
				</tr>
			<% 			
					}
			%>
					
			<% 
				}
			%>
		</table>
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
