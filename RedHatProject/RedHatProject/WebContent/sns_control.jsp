<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, redhat.member.*, redhat.message.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="msg" class="redhat.message.Message" />
<jsp:useBean id="msgDAO" class="redhat.message.MessageDAO" />

<jsp:setProperty name="msg" property="uid" />
<jsp:setProperty name="msg" property="reply_content" />
<jsp:setProperty name="msg" property="e_code" />
<%
	String action = request.getParameter("action");
	//String uid = request.getParameter("uid");
	//String reply_content = request.getParameter("reply_content");
	//String e_code = request.getParameter("code");
	

	 if (action.equals("getall")) {
		ArrayList<String> nusers = new MemberDAO().getNewMembers();
		request.setAttribute("nusers", nusers);	
		pageContext.forward("main_page.jsp");
		}
	 
	 if(action.equals("newmsg")){
		 if(msgDAO.newMsg(msg))
				out.println("<Script>alert('댓글이 등록되었습니다.');history.go(-1);</Script>");	
		 else
			 out.println("<Script>alert('이미 댓글을 등록했습니다!');history.go(-1);</Script>");	
	 }
%>