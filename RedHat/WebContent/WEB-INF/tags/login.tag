<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.button {
	font-weight:bold;
	text-decoration:none;
	font-family:Arial;
	box-shadow:#d6d6d6 1px 3px 2px;
	o-box-shadow:#d6d6d6 1px 3px 2px;
	-moz-box-shadow:#d6d6d6 1px 3px 2px;
	-webkit-box-shadow:#d6d6d6 1px 3px 2px;
	background:#ffffff;
	background:-o-linear-gradient(90deg, #ffffff, #c9c9c9);
	background:-moz-linear-gradient( center top, #ffffff 5%, #c9c9c9 100% );
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #ffffff), color-stop(1, #c9c9c9) );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#c9c9c9');
	background:-webkit-linear-gradient(#ffffff, #c9c9c9);
	background:-ms-linear-gradient(#ffffff, #c9c9c9);
	background:linear-gradient(#ffffff, #c9c9c9);
	text-indent:0px;
	line-height:8px;
	-moz-border-radius:12px;
	-webkit-border-radius:12px;
	border-radius:12px;
	text-align:center;
	vertical-align:middle;
	display:inline-block;
	font-size:12px;
	color:#821382;
	width:60px;
	height:8px;
	padding:12px;
	border-color:#ffffff;
	border-width:1px;
	border-style:solid;
}

.button:active {
	box-shadow:#d6d6d6 1px 0 2px;
	o-box-shadow:#d6d6d6 1px 0 2px;
	-moz-box-shadow:#d6d6d6 1px 0 2px;
	-webkit-box-shadow:#d6d6d6 1px 0 2px;
	position:relative;
	top:3px
}

.button:hover {
	background:#c9c9c9;
	background:-o-linear-gradient(90deg, #c9c9c9, #ffffff);
	background:-moz-linear-gradient( center top, #c9c9c9 5%, #ffffff 100% );
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #c9c9c9), color-stop(1, #ffffff) );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#c9c9c9', endColorstr='#ffffff');
	background:-webkit-linear-gradient(#c9c9c9, #ffffff);
	background:-ms-linear-gradient(#c9c9c9, #ffffff);
	background:linear-gradient(#c9c9c9, #ffffff);
}
</style>
<form name="loginform" method="post" action="user_control.jsp">
<c:choose>
<c:when test="${uid != null}">
	<input type="hidden" name="action" value="logout">
	<input type="submit" value="로그아웃">
</c:when>
<c:otherwise>
			<input type="hidden" name="action" value="login">
		&nbsp;<input placeholder="아이디" type="text" name="uid" size="10"> 
		<input placeholder="****" type="password" name="passwd" size="10">
		&nbsp;<input class="button" type="submit" value="로그인">
</c:otherwise>
</c:choose>
</form>