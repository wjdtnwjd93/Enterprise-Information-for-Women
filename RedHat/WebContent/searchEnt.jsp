<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="edao" class="redhat.enterprise.EnterpriseDAO" />
<jsp:useBean id="avg" class="redhat.enterprise.evaluation.EvaluationAvg"/>
<jsp:setProperty name="avg" property="*"/>
<%
   String uid = String.valueOf(session.getAttribute("uid"));
	double avg1=0, avg2=0, avg3=0, avg4=0;
%>
<%
	// XML 데이터를 호출할 URL
	String url = "http://dart.fss.or.kr/api/company.xml?auth=fb2cb0d7a3430abf28c9f7f0a797c3fe3eb147e2&crp_cd=";
	String code = ""; //코드 저장
	String entName = ""; // 사용자로부터 받아올 기업 이름 저장
	entName = request.getParameter("entName"); // 기업 이름을 가져옴
	//entName = java.net.URLDecoder.decode( entName , "UTF-8" );
	// 가져온 기업 이름을 이용해서 DB에서 코드 찾기
	code = edao.findEnterprise(entName); // 코드 저장 
	if(code.equals("")){ //코드가 없는 경우 오류처리
		 response.sendRedirect("emptyResult.html");
	}
	
	url = url + code; // url 합치기
	// 가져온 정보를 저장할 변수
	String crp_nm = ""; // 정식명칭
	String crp_nm_e = ""; // 영문명칭
	String crp_nm_i = ""; // 종목명
	String ceo_nm = ""; // 대표자명
	String adr = ""; // 주소
	String hm_url = ""; // 홈페이지 주소
	String est_dt = ""; // 설립일
	// 설립 년, 월, 일
	String est_year = "", est_month = "", est_day = "";
	try {
		// XML 파싱
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document doc = builder.parse(url);
		// result 안의 정보들을 가져옴
		NodeList list = doc.getElementsByTagName("result");
		// 노드를 통해 정보를 가져옴
		for (int i = 0; i < list.getLength(); i++) {
			for (Node node = list.item(i).getFirstChild(); node != null; node = node.getNextSibling()) {
				if (node.getNodeName().equals("crp_nm")) { // 기업 정식 명칭
					crp_nm = node.getTextContent();
				} else if (node.getNodeName().equals("crp_nm_e")) { // 기업 영문 명칭
					crp_nm_e = node.getTextContent();
				} else if (node.getNodeName().equals("crp_nm_i")) { // 종목명
					crp_nm_i = node.getTextContent();
				} else if (node.getNodeName().equals("ceo_nm")) { // 대표자명
					ceo_nm = node.getTextContent();
				} else if (node.getNodeName().equals("adr")) { // 주소
					adr = node.getTextContent();
				} else if (node.getNodeName().equals("hm_url")) { // 홈페이지 주소
					hm_url = node.getTextContent();
				} else if (node.getNodeName().equals("est_dt")) { // 설립일
					est_dt = node.getTextContent();
					est_year = est_dt.substring(0, 4); // 년
					est_month = est_dt.substring(4, 6); // 월
					est_day = est_dt.substring(6, 8); // 일
				}
			}
		}
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/style.css" type="text/css">
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
	
<title>기업 정보: <%=crp_nm_i%></title>
</head>
<body>
<div class="wrapper">
	<div class="entinfo-header-title-area">
	<div class="main-header-contents">
         <img src="img/main_logo.png" class="main-header-logo-btn"> <!--로고 이미지-->
      </div>
		<div class="entinfo-header-scrape-area-left">
				<input class="button-top" type="button" value="메인으로" onClick="mainpage();" /> 
		</div>
		<div class="entinfo-header-search-area">
		       <form action="searchEnt.jsp" method="post">
               <input type="search" class="main-search-query" name="entName" placeholder="기업 이름을 입력하세요." onkeydown="if(event.keyCode==13) submit();"> 
               <img src="img/search_image.png" class="main-search-icon" onClick="submit();">
               </form>
		</div>
		   <%
           if(session.getAttribute("uid")!=null&&!session.getAttribute("uid").equals("admin"))
           {
           %>
		<div class="entinfo-header-scrape-area">
			<form action="scrap_list.jsp" method="post">
				<input class="button-top" type="submit" value="스크랩북"/> 
			</form>
		</div>
		<div class="entinfo-header-scrape-area">
			<form action="scrap.jsp" method="post">
				<input class="button-top" type="submit" value="스크랩" /> 
				<input type="hidden" name="e_code" value="<%=code%>" /> 
				<input type="hidden" name="e_name" value="<%=entName%>" />
			</form>
		</div>
		<% }; %>
	</div>
	
	<div class="entinfo-contents-container">
		<div class="entinfo-contents">
			<h1 class="entinfo-header-title-korean"><%=crp_nm%>
				<% if(edao.findEnterpriseFamily(entName)){%>
	         		<img class="entinfo-info-logo" src="img/family_logo.png">
	      		<% } %>
      		</h1>
			<h2 class="entinfo-header-title-english"><%=crp_nm_e%></h2>
			<ul class="entinfo-contents-list">
				<li class="entinfo-contents-list-item">종목명: <%=crp_nm_i%></li>
				<li class="entinfo-contents-list-item">대표자: <%=ceo_nm%></li>
				<li class="entinfo-contents-list-item">주소: <%=adr%></li>
				<li class="entinfo-contents-list-item">설립일: <%=est_year%>년 <%=est_month%>월 <%=est_day%>일</li>
				<li class="entinfo-contents-list-item">홈페이지: <a class="entinfo-contents-link" href="<%=hm_url%>"> <%=hm_url%></a></li>
			</ul>
		</div>
      
    
      <div class="entinfo-map" id="map">
     	 <!-- 카카오 지도 API 공간 -->
      </div>
    
	  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b15b9d5558a9cd5a1d9c0bcf59a76e5e&libraries=services,clusterer,drawing"></script>
	  <script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				level: 3 // 지도의 확대 레벨
			};  
	
		// 지도를 생성
		var map = new daum.maps.Map(mapContainer, mapOption); 
	
		// 주소-좌표 변환 객체를 생성
		var geocoder = new daum.maps.services.Geocoder();
	
		// 주소로 좌표 검색
		geocoder.addressSearch('<%=adr%>', function(result, status) {
	
			// 정상적으로 검색이 완료된 경우
			 if (status === daum.maps.services.Status.OK) {
				var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	
				// 결과값으로 받은 위치를 마커로 표시
				var marker = new daum.maps.Marker({
					map: map,
					position: coords
				});
	
				// 지도의 중심을 결과값으로 받은 위치로 이동
				map.setCenter(coords);
				} 
			}); 
	  </script>
	  
	  	            
      <!-- 평점 보여주기 -->
      <div class="entinfo-evaluation-avg">
	      <%
		      avg.setEvaluationAvg(code);
		      avg1 =  avg.getTotal_evaluation(); // 총평점
		      avg2 =  avg.getFemale_welfar(); //여성복지
		      avg3 =  avg.getPromotion_chance(); //승진기회
		      avg4 =  avg.getGender_equal(); //성평등
	      %>
      	<h2 class="entinfo-header-title-korean">평가 평균</h2>
	      <div class="entinfo-contents-rating">
				<b>총평점</b><br/>
				<div class="entinfo-star-rating-area">
					<p class="entinfo-star-rating" style="WIDTH: <%=avg1*20%>%;"></p>
				</div>
		  </div>
		  <div class="entinfo-contents-rating">
				<br/><b>여성복지</b><br/>
				<div class="entinfo-star-rating-area">
					<p class="entinfo-star-rating" style="WIDTH: <%=avg2*20%>%;"></p>
				</div>
		  </div>
		  <div class="entinfo-contents-rating">
				<br/><b>승진기회</b><br/>
				<div class="entinfo-star-rating-area">
					<p class="entinfo-star-rating" style="WIDTH: <%=avg3*20%>%;"></p>
				</div>
		 </div>
		 <div class="entinfo-contents-rating">
				<br/><b>성평등</b><br/>
				<div class="entinfo-star-rating-area">
					<p class="entinfo-star-rating" style="WIDTH: <%=avg4*20%>%;"></p>
				</div>
		 </div>
	 </div>
	     
      
	  <div class="entinfo-evaluate-area">
	  <h2 class="entinfo-header-title-korean">평가하기</h2>
      <%
         if(session.getAttribute("uid")!=null){
      %>
		         <form method="post" action="enterprise_evaluation.jsp">
		         <input type="hidden" name="uid" value="<%=uid%>" /> 
		         <input type="hidden" name="e_code" value="<%=code%>" /> 
		         <label><b>총평점</b></label><br/>
		         <select name="total_evaluation"> 
		            <option value='1'>1</option>
		            <option value='2'>2</option>
		            <option value='3'>3</option>
		            <option value='4'>4</option>
		            <option value='5'>5</option>
		         </select>
		         <br/>
		         <label><b>여성복지</b></label><br/>
		         <select name="female_welfare">
		            <option value='1'>1</option>
		            <option value='2'>2</option>
		            <option value='3'>3</option>
		            <option value='4'>4</option>
		            <option value='5'>5</option>
		         </select>
		         <br/>
		         <label><b>승진기회</b></label><br/>
		         <select name="promotion_chance">
		            <option value='1'>1</option>
		            <option value='2'>2</option>
		            <option value='3'>3</option>
		            <option value='4'>4</option>
		            <option value='5'>5</option>
		         </select>
		         <br/>
		         <label><b>성평등</b></label><br/>
		         <select name="gender_equal">
		            <option value='1'>1</option>
		            <option value='2'>2</option>
		            <option value='3'>3</option>
		            <option value='4'>4</option>
		            <option value='5'>5</option>
		         </select>
		         <br/>
		         <!-- 새로고침이 안 돼 -->
		         <input type="submit" value="저장"/>
		         <input type="button" value="새로고침" onClick="window.location.reload()"/>
		      </form>
	       
	      <%       
	         } else {
	        	 %>
	        	 <h3>로그인 해주세요!</h3>
	        	 <%
	         }
	      %>
	      </div>
</div>
</div>

</body>
</html>