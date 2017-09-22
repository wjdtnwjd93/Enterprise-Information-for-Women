<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="org.w3c.dom.*" %>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="edao" class="redhat.enterprise.EnterpriseDAO"/>
<%
   // XML 데이터를 호출할 URL
   String url = "http://dart.fss.or.kr/api/company.xml?auth=fb2cb0d7a3430abf28c9f7f0a797c3fe3eb147e2&crp_cd=";
   String code =""; //코드 저장
   String entName =""; // 사용자로부터 받아올 기업 이름 저장
   
   entName = request.getParameter("entName"); // 기업 이름을 가져옴
   // 가져온 기업 이름을 이용해서 DB에서 코드 찾기
   code = edao.findEnterprise(entName); // 코드 저장 
   url = url + code; // url 합치기
   
   // 가져온 정보를 저장할 변수
   String crp_nm=""; // 정식명칭
   String crp_nm_e=""; // 영문명칭
   String crp_nm_i=""; // 종목명
   String ceo_nm=""; // 대표자명
   String adr=""; // 주소
   String hm_url=""; // 홈페이지 주소
   String est_dt=""; // 설립일
   // 설립 년, 월, 일
   String est_year = "", est_month = "", est_day = "";

   try{
      // XML 파싱
      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
      DocumentBuilder builder = factory.newDocumentBuilder();
      Document doc = builder.parse(url);

      // result 안의 정보들을 가져옴
      NodeList list = doc.getElementsByTagName("result");
      
      // 노드를 통해 정보를 가져옴
        for(int i=0; i<list.getLength(); i++){
         for(Node node = list.item(i).getFirstChild(); 
               node!=null; node=node.getNextSibling()){
            if (node.getNodeName().equals("crp_nm")){ // 기업 정식 명칭
               crp_nm = node.getTextContent();
            }
            else if (node.getNodeName().equals("crp_nm_e")){ // 기업 영문 명칭
               crp_nm_e = node.getTextContent();
            }
            else if (node.getNodeName().equals("crp_nm_i")){ // 종목명
               crp_nm_i = node.getTextContent();
            }
            else if (node.getNodeName().equals("ceo_nm")){ // 대표자명
               ceo_nm = node.getTextContent();
            }
            else if (node.getNodeName().equals("adr")){ // 주소
               adr = node.getTextContent();
            }
            else if (node.getNodeName().equals("hm_url")){ // 홈페이지 주소
               hm_url = node.getTextContent();
            }
            else if (node.getNodeName().equals("est_dt")){ // 설립일
               est_dt = node.getTextContent();
            	est_year = est_dt.substring(0, 4); // 년
            	est_month = est_dt.substring(4, 6); // 월
            	est_day = est_dt.substring(6, 8); // 일
            }
         }
        }
      
   } catch(Exception ex) {
      ex.printStackTrace();
   }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/style.css" type="text/css">
<title>기업 정보: <%=crp_nm_i%></title>
</head>
<body>
   <div class="entinfo-header-title-area">
      <h2 class="entinfo-header-title-korean"><%=crp_nm %></h2>
      <h3 class="entinfo-header-title-english"><%=crp_nm_e %></h3>
      <div class="entinfo-header-scrape-area">
      	<input class="scrape-button" type="submit" value="스크랩"/>
      </div>
   </div>
   <div class="entinfo-contents-container">
      <div class="entinfo-contents">
      <ul class="entinfo-contents-list">
         <li class="entinfo-contents-list-item">종목명: <%=crp_nm_i %></li>
         <li class="entinfo-contents-list-item">대표자 명: <%=ceo_nm %></li>
         <li class="entinfo-contents-list-item">주소: <%=adr %></li>
         <li class="entinfo-contents-list-item">설립일: <%=est_year %>년 <%=est_month %>월 <%=est_day%>일</li>
         <li class="entinfo-contents-list-item">홈페이지:<a href="<%=hm_url %>"> <%=hm_url %></a> </li>
      </ul>
      </div>
   </div>
</body>
</html>