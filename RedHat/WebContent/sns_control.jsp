<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, redhat.member.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	String action = request.getParameter("action");
	if (action.equals("getall")) {
		ArrayList<String> nusers = new MemberDAO().getNewMembers();
		request.setAttribute("nusers", nusers);	
		pageContext.forward("main_page.jsp");
	}
	
%>