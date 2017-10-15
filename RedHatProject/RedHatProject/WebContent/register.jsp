<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.* "%>
<%@page import="com.mysql.jdbc.Driver"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="msg" class="redhat.message.Message" />
<jsp:useBean id="ent" class="redhat.enterprise.Enterprise" />
<jsp:useBean id="entDAO" class="redhat.enterprise.EnterpriseDAO" />
<jsp:setProperty name="msg" property="uid" />
<jsp:setProperty name="msg" property="reply_content" />
<jsp:setProperty name="msg" property="e_code" />
<jsp:useBean id="msgDAO" class="redhat.message.MessageDAO" />
<jsp:setProperty name="ent" property="e_code" />


<%
	int i = 0;
	String uid = String.valueOf(session.getAttribute("uid"));
	String reply_content = request.getParameter("reply_content");
	String e_code = request.getParameter("e_code");
	if (msgDAO.newMsg(msg)) {
		out.println("<Script>alert('댓글이 등록되었습니다.');</Script>");		
	} else {
		out.println("<Script>alert('이미 댓글을 등록했습니다.');</Script>");
	}
%>

<h5><%=entDAO.findEnterpriseName(e_code) %>의 모든 댓글</h5>
<%
    Class.forName("com.mysql.jdbc.Driver"); // mysql 연동
    String url = "jdbc:mysql://localhost:3306/jspbook"; // mysql 데이터베이스명
    String mysql_id = "jspbook";   // mysql id값
    String mysql_pw = "1234";   // mysql pw값
    int total = 0;

    try{
      Connection conn = DriverManager.getConnection(url, mysql_id, mysql_pw);    // 실제 DB 연동시도
      Statement stmt = conn.createStatement();
      String totalSql = "select count(*) from enterprise_reply;";  // 총 글갯수를 찾는 sql문
      ResultSet rs = stmt.executeQuery(totalSql);

      if(rs.next()){            // 결과가 있다면 true값을 반환합니다
        total = rs.getInt(1);   // total에 전체 글 갯수 값 대입\
      }

      // total은 나중에 페이징 처리시 사용

      String listSql = "select uid, reply_content, current from enterprise_reply where e_code="; // 전체 리스트를 가져오는 sql문
      
      String totlaSql = listSql+ent.getE_code()+";";
     // stmt.
      rs = stmt.executeQuery(totlaSql);

      // try catch에서 오류가없을시에 출력되는 내용입니다
  %>
  <table border=1>
    <tr>
      <th>글번호</th>
      <th>아이디</th>
      <th>글내용</th>
      <th>작성일자</th>
    <tr>

  <%
  // total이 0일때, 곧 게시글이 아무것도 없을때 출력되는 내용입니다.
    if(total==0){
  %>
    <tr>
      <td>게시글이 존재하지 않습니다</td>
    </tr>
  <%
  // total이 0이 아닐때 변수를 선언해주고 출력되는 내용을 순서에 맞게 대입하는 내용입니다.
    } else{
      while(rs.next()){ 
    	  i++;//rs값이 있을때까지 반복합니다.
       uid = rs.getString(1);           // sql문의 첫번째 컬럼내용을 담습니다.
       reply_content = rs.getString(2);   // sql문의 두번째 컬럼내용을 담습니다.
       String current = rs.getString(3); // sql문의 세번째 컬럼내용을 담습니다.

  // 실제 리스트가 출력되는 부분 입니다.
  %>
    <tr>
      <td><%=i%></td>
      <td><%=uid%></td>
      <td><%=reply_content%></td>
      <td><%=current%></td>
    </tr>
  <%
      }
    }
    rs.close();
    conn.close();
    stmt.close();
  }catch(SQLException e){
    out.println(e.toString());
  }
  %>
