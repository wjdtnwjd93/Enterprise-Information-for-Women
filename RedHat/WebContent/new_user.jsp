<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<link rel="stylesheet" href="css/style.css" type="text/css">
<title>회원가입</title>
</head>
<body>
<center>
<form method="post" action="user_control.jsp?action=new">
	<div class="join-header-area">
		<h2 class="join-title">회원가입</h2>
	</div>
	<div class="join-container">
	<p class="join-text">회원가입에 필요한 정보를 입력해주세요.</p>
	<table class="join-table">
		<tr>
			<td class="join-table-item"><b>이름</b></td>
			<td class="join-table-item"><input type="text" name="name" size="10" required></td>
		</tr>
		<tr>
			<td class="join-table-item"><b>아이디</b></td>
			<td class="join-table-item"><input type="text" name="uid" size="10" required></td>
		</tr>
		<tr>
			<td class="join-table-item"><b>비밀번호</b></td>
			<td class="join-table-item"><input type="password" name="passwd" size="10" required></td>
		</tr>
		<tr>
			<td class="join-table-item" colspan="2"><center>
			<input type="submit" value="회원등록" class="join-button">
			<input type="reset" value="가입취소" class="join-button">
			</center></td>
		</tr>
	</table>
	</div> 
	</form>
</center>
</body>
</html>