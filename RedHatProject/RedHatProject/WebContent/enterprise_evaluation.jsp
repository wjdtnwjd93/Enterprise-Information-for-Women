<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="evaDAO" class="redhat.enterprise.evaluation.EvaluationDAO" />
<jsp:useBean id="eva" class="redhat.enterprise.evaluation.Evaluation" />
<jsp:useBean id="ent" class="redhat.enterprise.Enterprise"/>
<jsp:useBean id="entDAO" class="redhat.enterprise.EnterpriseDAO"/>
<jsp:useBean id="memberDAO" class="redhat.member.MemberDAO"/>
<jsp:setProperty name="eva" property="*"/>
<jsp:setProperty name="ent" property="e_code"/>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
 
	String uid = String.valueOf(session.getAttribute("uid"));
	String e_code = request.getParameter("e_code");
	int total_evaluation = Integer.parseInt(request.getParameter("total_evaluation"));
	int female_welfare = Integer.parseInt(request.getParameter("female_welfare"));
	int promotion_chance = Integer.parseInt(request.getParameter("promotion_chance"));
	int gender_equal = Integer.parseInt(request.getParameter("gender_equal"));
	
	 if(evaDAO.insertEavaluationData(eva)){
		out.println("<Script>alert('평점이 등록 되었습니다.');history.go(-1);</Script>");
	}else{
		out.println("<Script>alert('이미 평가한 기업입니다.');history.go(-1);</Script>");
	}


%>