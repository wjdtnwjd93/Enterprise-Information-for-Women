<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="er" class="redhat.excel.ExcelFile"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>업데이트</title>
</head>
<body>
<%

	String file = ""; // 엑셀 파일 경로를 저장할 변수 선언
	file = request.getParameter("Xfile"); // 엑셀 파일 경로를 저장
	System.out.println(file); // 파일 경로 콘솔창으로 확인
	
	// 엑셀 파일 객체 생성 및 열기
	er.openFile(file);
	//er.readDatafromFile();
	
%>
</body>
</html>