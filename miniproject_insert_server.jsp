<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ȸ������</title>
<link rel="stylesheet" href="style_insert_server.css">
<script src="jquery-3.4.1.js"></script>
</head>
<body>

<%@ include file="dbconn.jsp" %>
<%
String u_id = request.getParameter("u_id");
String u_pass = request.getParameter("u_pass");
String u_grade = request.getParameter("u_grade");

// conn�� ���� ����
Statement stmt = conn.createStatement(); // SQL�� ���� Ʈ���غ�
//INSERT INTO user_table(u_id,u_pass,u_grade) VALUES('KYC', '1234', 'A'); 
String sql = "INSERT INTO user_table(u_id,u_pass,u_grade) VALUES('";
sql += u_id + "', '" + u_pass + "', '" + u_grade + "')";
stmt.executeUpdate(sql); // Ʈ���� ���� �Ǿ �ٸ��ǳ� �ξ� �ֱ�.

stmt.close();
conn.close();

%>
<div class="btn-area">	
<button type="button" onclick="location.href='miniproject_login_client.jsp'">�α���â</button>
</div>	

</body>
</html>