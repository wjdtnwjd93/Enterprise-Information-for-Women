<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.w3c.dom.*" %>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="java.util.*" %>
<%
   // XML 데이터를 호출할 URL
   String url = "http://dart.fss.or.kr/api/company.xml?auth=fb2cb0d7a3430abf28c9f7f0a797c3fe3eb147e2&crp_cd=";
   String code =""; // 사용자로부터 받아올 코드 저장
   
   code = request.getParameter("code");
   url = url + code; // url 합치기
   
   // 가져온 정보를 저장할 변수
   String crp_nm=""; // 정식명칭
   String crp_nm_e=""; // 영문명칭
   String crp_nm_i=""; // 종목명
   String ceo_nm=""; // 대표자명
   String adr=""; // 주소
   String hm_url=""; // 홈페이지 주소
   String est_dt=""; // 설립일

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
            if (node.getNodeName().equals("adr")){ // 주소
               adr = node.getTextContent();
            }
            if (node.getNodeName().equals("hm_url")){ // 홈페이지 주소
               hm_url = node.getTextContent();
            }
            if (node.getNodeName().equals("est_dt")){ // 설립일
               est_dt = node.getTextContent();
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
<title>기업 정보</title>
</head>
<body>
   <div class="entinfo-header-container">
      <div class="entinfo-header-title-area">
         <h2 class="entinfo-header-title-korean"><%=crp_nm %></h2>
         <h3 class="entinfo-header-title-english"><%=crp_nm_e %></h3>
      </div>
   </div>
   <div class="entinfo-contents-container">
   <hr>
      <div class="entinfo-contents">
      <ul class="entinfo-contents-list">
         <li class="entinfo-contents-list-item">종목명: <%=crp_nm_i %></li>
         <li class="entinfo-contents-list-item">대표자 명: <%=ceo_nm %></li>
         <li class="entinfo-contents-list-item">주소: <%=adr %></li>
         <li class="entinfo-contents-list-item">설립일: <%=est_dt %></li>
         <li class="entinfo-contents-list-item">홈페이지:<a href="<%=hm_url %>"> <%=hm_url %></a> </li>
         
      </ul>
      </div>
   </div>
</body>
</html>