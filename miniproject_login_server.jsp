<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�α���</title>
<link rel="stylesheet" href="style.css">
<script src="jquery-3.4.1.js"></script>
</head>
<body>
<%@ include file="dbconn.jsp" %>
<%
String u_id = request.getParameter("u_id");
String u_pass = request.getParameter("u_pass");

//conn �� ���� ����
ResultSet rs = null;
Statement stmt = conn.createStatement(); // SQL �� ���� Ʈ���غ�
//INSERT INTO member_tbl(m_id,m_name,m_age) VALUES('lee', '�̼���', 25); �ߺ��� ������ �ΰ� �ϴ°� ����
//UPDATE member_tbl SET m_name='kys', m_age=31 WHERE m_id='kim';
String sql = "SELECT u_id,u_pass FROM user_table WHERE u_id='";
sql += u_id + "'";
rs = stmt.executeQuery(sql);// Ʈ���� ���� �Ǿ �ٸ� �ǳ� �ξ�ֱ�

String m_age2 ="";
while (rs.next()){ 
	m_age2 = rs.getString("u_pass");
}
if (m_age2.equals ("")){
	out.println("���̵� �����ϴ�.");
	
} else if (!u_pass.equals(m_age2)){
	out.println("���Ʋ�� Ȯ�ιٶ�");
}else{
out.println("<h1><a href='miniproject_color_client.jsp'> ����ó�� ���� </a></h1>");
/*    Header("miniproject_color_client");*/
	session.setAttribute("u_id",u_id);
	session.setAttribute("u_pass",u_pass);

	
}


stmt.close();
conn.close();

%>
</body>
</html>