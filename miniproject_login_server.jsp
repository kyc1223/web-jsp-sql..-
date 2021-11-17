<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인</title>
<link rel="stylesheet" href="style.css">
<script src="jquery-3.4.1.js"></script>
</head>
<body>
<%@ include file="dbconn.jsp" %>
<%
String u_id = request.getParameter("u_id");
String u_pass = request.getParameter("u_pass");

//conn 은 교량 개념
ResultSet rs = null;
Statement stmt = conn.createStatement(); // SQL 을 실을 트럭준비
//INSERT INTO member_tbl(m_id,m_name,m_age) VALUES('lee', '이순신', 25); 견본을 가져다 두고 하는게 좋음
//UPDATE member_tbl SET m_name='kys', m_age=31 WHERE m_id='kim';
String sql = "SELECT u_id,u_pass FROM user_table WHERE u_id='";
sql += u_id + "'";
rs = stmt.executeQuery(sql);// 트럭에 짐을 실어서 다리 건너 부어넣기

String m_age2 ="";
while (rs.next()){ 
	m_age2 = rs.getString("u_pass");
}
if (m_age2.equals ("")){
	out.println("아이디가 없습니다.");
	
} else if (!u_pass.equals(m_age2)){
	out.println("비번틀림 확인바람");
}else{
out.println("<h1><a href='miniproject_color_client.jsp'> 영상처리 실행 </a></h1>");
/*    Header("miniproject_color_client");*/
	session.setAttribute("u_id",u_id);
	session.setAttribute("u_pass",u_pass);

	
}


stmt.close();
conn.close();

%>
</body>
</html>