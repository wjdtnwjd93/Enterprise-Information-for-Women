<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>기업정보 FOR WOMAN</title>
<head>
	<link rel=icon href="" type="image/x-icon">
	<link rel="stylesheet" href="css/style.css" type="text/css">
	<meta name="description" content="여성 구직자를 위한 기업, 채용, 복지 정보가 모두 모인 곳!">
	<title>기업정보 For Women</title>
	<script>
	
	function newuser() {
		window
				.open(
						"new_user.jsp",
						"newuser",
						"titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=300,height=240");
	}
	
	</script>
</head>
<body>
<form name="fomr1" method="post" action="searchEnt.jsp">
	<div class="main-header-container"> <!--상단 메뉴 공간-->
		<div class="main-header-contents">
		<a href="main_page.jsp"><img src="img/temp_logo.png" class="main-header-logo-btn"></a> 
		</div>
		<ul class="main-header-menu">
			<li id="mainHeaderFamBtn" class="main-header-menu-item">
				<a href="#" class="main-header-link">가족친화기업이란?</a>
			</li>
			<li id="mainHeaderScrapeBtn" class="main-header-menu-item">
				스크랩
			</li>
			<li id="mainHeaderLoginBtn" class="main-header-menu-item">
			<%  if(session.getAttribute("name") == null) { %>
			<li id="mainHeaderFamBtn" class="main-header-menu-item">
				<a href="login_page.jsp" class="main-header-link">로그인</a>
			</li>
			<%	}
			else { %>
				<li id="mainHeaderFamBtn" class="main-header-menu-item">
				<a href="login_page.jsp" class="main-header-link">로그아웃</a>
			</li>
			<%	} %>
			
			</li>
			<li id="mainHeaderFamBtn" class="main-header-menu-item">
				<a href="javascript:newuser()" class="main-header-link">회원가입</a>
			</li>
		</ul>
	</div>
	<div class="main-contents-container"> <!-- 내용 공간 -->
		<div class="main-contents">
			<div class="main-title">
				<b>여성 복지 우수 기업,<br>
				가족 친화 기업 정보를 한 곳에서!</b>
			</div>
			<div id=mainSearchArea class="main-search-area">
			<!-- 검색 기능 공간 -->
				<div class="main-search-container">
					 <input type="text" class="main-search-query" name="code" 
               placeholder="기업 이름을 입력하세요." onkeydown="if(event.keyCode==13) submit();">               >
               	<img src="img/search_logo.png" class="main-search-icon">
              	 <input type="submit" class="main-search-button">
				</div>
				<!--우선 순위 선택 공간-->
				<div class="main-priority-container">
					<ul class="main-priority-menu">
						<li class="main-priority-menu-item"><b>검색 우선 순위</b></li>
						<li class="main-priority-menu-item">총 평점<input type="radio"></li>
						<li class="main-priority-menu-item">여성복지<input type="radio"></li>
						<li class="main-priority-menu-item">승진 가능성<input type="radio"></li>
						<li class="main-priority-menu-item">성평등 정도<input type="radio"></li>
					</ul>
				</div>
			</div>
			<div class="main-best-review-list">
			<!-- 베스트 리뷰 기업 리스트 -->
				<div class="sub-title">
					<b>베스트 평점 기업</b>
					<ul class="sub-list">
						<li class="sub-list-item">Test1</li>
						<li class="sub-list-item">Test2</li>
						<li class="sub-list-item">Test3</li>
					</ul>
				</div>
			</div>
			<div class="main-recent-comment-list">
			<!-- 최근 댓글 리스트 -->
				<div class="sub-title">
					<b>최신 댓글</b>
					<ul class="sub-list">
						<li class="sub-list-item">Test1</li>
						<li class="sub-list-item">Test2</li>
						<li class="sub-list-item">Test3</li>
					</ul>
				</div>
			</div>
			<div class="main-recent-employment-list">
				<div class="sub-title">
					<b>채용 공고</b>
					<ul class="sub-list">
						<li class="sub-list-item">Test1</li>
						<li class="sub-list-item">Test2</li>
						<li class="sub-list-item">Test3</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="main-footer-contents">
	</div>
	<script src=https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js></script>
	<script src=https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js></script>
    <script src=https://cdnjs.cloudflare.com/ajax/libs/jquery.devbridge-autocomplete/1.2.26/jquery.autocomplete.min.js></script>
    <script src=jquery-ui.min.js></script>
	<script src=kj_init_mobile.1.0.0.52.min.js></script>
</form>
</body>
</html>