<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="member" class="redhat.member.Member"/>
<jsp:setProperty name="member" property="*"/>
<jsp:useBean id="mdao" class="redhat.member.MemberDAO"/>

<%
	String action = request.getParameter("action");

	if(action.equals("new")) {
		if(mdao.addMember(member))
			out.println("<script>alert('정상적으로 등록 되었습니다. 로그인 하세요!!');opener.window.location.reload();window.close();</script>");
		else
			out.println("<script>alert('같은 아이디가 존재 합니다!!');history.go(-1);</script>");
	}
	else if(action.equals("login")) {
		if(mdao.login(member.getUid(),member.getPasswd())) {
			session.setAttribute("uid",member.getUid());
			response.sendRedirect("sns_control.jsp?action=getall");
		}
		else {
			out.println("<script>alert('아이디나 비밀번호가 틀렸습니다.!!');history.go(-1);</script>");
		}
	} 

	else if(action.equals("logout")) {
		session.removeAttribute("uid");
		//session.removeAttribute("suid");
		response.sendRedirect("sns_control.jsp?action=getall");		
	}
	
	else if(action.equals("dropout")) {
		mdao.outMember(member.getUid());
		session.removeValue("uid");
		//session.removeAttribute("uid");
		//session.removeAttribute("suid");
		//response.sendRedirect("sns_control.jsp?action=getall");		
	}
	
	else if(action.equals("setting")){
		response.sendRedirect("admin_page.jsp");
	}
%>