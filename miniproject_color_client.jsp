<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<title>����ó��</title>
<link rel="stylesheet" href="style.css">
<script src="jquery-3.4.1.js"></script>
</head>
<body>
<%
//������ Ȯ���ؼ� ������� ��Ű�Ӥ�
String u_id = (String)session.getAttribute("u_id");
String u_pass = (String)session.getAttribute("u_pass");

if (u_id == null || u_pass == null){
    out.println("�����ΰ� �ƴ� <br><br>");
return;}
%>

<section class="login-form">
<h1>����ó��</h1>
<form name='fileForm' method='post' action='miniproject_color_server.jsp'
	enctype='multipart/form-data'>
	<p> <select name="algo">

<option value=""> ~~ ���� �ϼ��� ~~~ </option>
		<option value="101"> ���� ó�� </option>
		<option value="102"> ���/��Ӱ�</option>
	    <option value="103"> ���ó��(127)</option>
	    <option value="104"> �Ķ󺼶�</option>
	    <option value="201"> ���Ϲ��� </option>
        <option value="202"> �¿����  </option>
        <option value="203"> �����¿�̷���  </option>
        <option value="204">ȸ�� </option>       
        <option value="301"> ������  </option>
        <option value="302"> Ȯ��  </option>      
        <option value="303"> ���  </option>      
        
        <option value="304"> ���翬����  </option>
        <option value="305"> ��������  </option>     
        <option value="306"> ��輱 ����  </option>   
        <option value="307"> ������  </option>       
        <option value="308"> ����þ�  </option>    
        <option value="401"> ����  </option>    
        <option value="402"> ������  </option>    
        
         
         
             
           
                
         
        

        
</form>
         
        
	</select>
    <div>
	<p> <input type='file' name='filename'>
	</div>
	
	<div class="int-area">
	<p> <strong>value</strong> <input type='text' value = 10 name='addVal'>
	</div>
		
	<div class ="btn-area">
	 <button type='submit' value='Login'> ����ó��</button>
	</div>
   
</section>

</body>
</html>