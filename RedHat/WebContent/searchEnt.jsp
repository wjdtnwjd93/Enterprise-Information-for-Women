<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="edao" class="redhat.enterprise.EnterpriseDAO" />
<%
	// XML 데이터를 호출할 URL
	String url = "http://dart.fss.or.kr/api/company.xml?auth=fb2cb0d7a3430abf28c9f7f0a797c3fe3eb147e2&crp_cd=";
	String code = ""; //코드 저장
	String entName = ""; // 사용자로부터 받아올 기업 이름 저장

	entName = request.getParameter("entName"); // 기업 이름을 가져옴
	// 가져온 기업 이름을 이용해서 DB에서 코드 찾기
	code = edao.findEnterprise(entName); // 코드 저장 
	//code = request.getParameter("code");
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
				<input type="hidden" name="e_code" value=" <%=code%>" /> 
				<input type="hidden" name="e_name" value=" <%=entName%>" />
			</form>
		</div>
		<% }; %>
	</div>
	<div class="entinfo-contents-container">
		<h2 class="entinfo-header-title-korean"><%=crp_nm%></h2>
		<h3 class="entinfo-header-title-english"><%=crp_nm_e%></h3>
		<div class="entinfo-contents">
			<ul class="entinfo-contents-list">
				<li class="entinfo-contents-list-item">종목명: <%=crp_nm_i%></li>
				<li class="entinfo-contents-list-item">대표자 명: <%=ceo_nm%></li>
				<li class="entinfo-contents-list-item">주소: <%=adr%></li>
				<li class="entinfo-contents-list-item">설립일: <%=est_year%>년 <%=est_month%>월
					<%=est_day%>일
				</li>
				<li class="entinfo-contents-list-item">홈페이지: <a class="entinfo-contents-link" href="<%=hm_url%>"> <%=hm_url%></a>
				</li>
			</ul>
		</div>
		<div class="entinfo-contents-rating">
			총평점
		 	<form class="nakkebar">
			    <input type="radio" name="nakkerating" value="4" id="value-4" class="nakkeradio nakkeradio-4"><label for="value-4" class="nakkelabel">4</label>
			    <input type="radio" name="nakkerating" value="3" id="value-3" class="nakkeradio nakkeradio-3"><label for="value-3" class="nakkelabel">3</label>
			    <input type="radio" name="nakkerating" value="2" id="value-2" class="nakkeradio nakkeradio-2"><label for="value-2" class="nakkelabel">2</label>
			    <input type="radio" name="nakkerating" value="1" id="value-1" class="nakkeradio nakkeradio-1"><label for="value-1" class="nakkelabel">1</label>
			    <input type="radio" name="nakkerating" value="0" id="value-0" class="nakkeradio nakkeradio-0"><label for="value-0" class="nakkelabel">0</label>
			</form>
			여성복지
		 	<form class="nakkebar">
			    <input type="radio" name="nakkerating" value="4" id="value-4" class="nakkeradio nakkeradio-4"><label for="value-4" class="nakkelabel">4</label>
			    <input type="radio" name="nakkerating" value="3" id="value-3" class="nakkeradio nakkeradio-3"><label for="value-3" class="nakkelabel">3</label>
			    <input type="radio" name="nakkerating" value="2" id="value-2" class="nakkeradio nakkeradio-2"><label for="value-2" class="nakkelabel">2</label>
			    <input type="radio" name="nakkerating" value="1" id="value-1" class="nakkeradio nakkeradio-1"><label for="value-1" class="nakkelabel">1</label>
				<input type="radio" name="nakkerating" value="0" id="value-0" class="nakkeradio nakkeradio-0"><label for="value-0" class="nakkelabel">0</label>
			</form>
			승진기회
		 	<form class="nakkebar">
			    <input type="radio" name="nakkerating" value="4" id="value-4" class="nakkeradio nakkeradio-4"><label for="value-4" class="nakkelabel">4</label>
			    <input type="radio" name="nakkerating" value="3" id="value-3" class="nakkeradio nakkeradio-3"><label for="value-3" class="nakkelabel">3</label>
			    <input type="radio" name="nakkerating" value="2" id="value-2" class="nakkeradio nakkeradio-2"><label for="value-2" class="nakkelabel">2</label>
			    <input type="radio" name="nakkerating" value="1" id="value-1" class="nakkeradio nakkeradio-1"><label for="value-1" class="nakkelabel">1</label>
				<input type="radio" name="nakkerating" value="0" id="value-0" class="nakkeradio nakkeradio-0"><label for="value-0" class="nakkelabel">0</label>
			</form>
			성평등
		 	<form class="nakkebar">
			    <input type="radio" name="nakkerating" value="4" id="value-4" class="nakkeradio nakkeradio-4"><label for="value-4" class="nakkelabel">4</label>
			    <input type="radio" name="nakkerating" value="3" id="value-3" class="nakkeradio nakkeradio-3"><label for="value-3" class="nakkelabel">3</label>
			    <input type="radio" name="nakkerating" value="2" id="value-2" class="nakkeradio nakkeradio-2"><label for="value-2" class="nakkelabel">2</label>
			    <input type="radio" name="nakkerating" value="1" id="value-1" class="nakkeradio nakkeradio-1"><label for="value-1" class="nakkelabel">1</label>
				<input type="radio" name="nakkerating" value="0" id="value-0" class="nakkeradio nakkeradio-0"><label for="value-0" class="nakkelabel">0</label>
			</form>
		</div>
	</div>
</div>
</body>
</html>