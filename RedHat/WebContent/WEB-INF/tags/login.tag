<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>
<script>
   function updateEntDB() {
      window.open(
            "update.html",
            "admin",
            "titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=500,height=500");
   }

</script>
<form name="loginform" method="post" action="user_control.jsp">
<c:choose>
<c:when test="${uid != null}">
	<c:choose>
	<c:when test="${uid == 'admin'}"> <!-- 관리자 계정 로그인시 업데이트 버튼 보임 -->
	<input class="button-top-admin" type="button" name="admin" onClick="updateEntDB()" value="업데이트">
	</c:when>
	</c:choose>
	'${uid}'님 어서오세요.
	<input type="hidden" name="action" value="logout">
	<input class="button-top" type="submit" value="로그아웃">

</c:when>
<c:otherwise>
			<input type="hidden" name="action" value="login">
		&nbsp;<input placeholder="아이디" type="text" name="uid" size="10"> 
		<input placeholder="****" type="password" name="passwd" size="10">
		&nbsp;<input class="button-top" class="button" type="submit" value="로그인">
</c:otherwise>
</c:choose>
</form>