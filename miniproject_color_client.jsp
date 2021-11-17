<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<title>영상처리</title>
<link rel="stylesheet" href="style.css">
<script src="jquery-3.4.1.js"></script>
</head>
<body>
<%
//세션을 확인해서 통과여부 시키ㅣㄱ
String u_id = (String)session.getAttribute("u_id");
String u_pass = (String)session.getAttribute("u_pass");

if (u_id == null || u_pass == null){
    out.println("정상경로가 아님 <br><br>");
return;}
%>

<section class="login-form">
<h1>영상처리</h1>
<form name='fileForm' method='post' action='miniproject_color_server.jsp'
	enctype='multipart/form-data'>
	<p> <select name="algo">

<option value=""> ~~ 선택 하세요 ~~~ </option>
		<option value="101"> 반전 처리 </option>
		<option value="102"> 밝게/어둡게</option>
	    <option value="103"> 흑백처리(127)</option>
	    <option value="104"> 파라볼라</option>
	    <option value="201"> 상하반전 </option>
        <option value="202"> 좌우반전  </option>
        <option value="203"> 상하좌우미러링  </option>
        <option value="204">회전 </option>       
        <option value="301"> 엔드인  </option>
        <option value="302"> 확대  </option>      
        <option value="303"> 축소  </option>      
        
        <option value="304"> 유사연산자  </option>
        <option value="305"> 차연산자  </option>     
        <option value="306"> 경계선 검출  </option>   
        <option value="307"> 샤프닝  </option>       
        <option value="308"> 가우시안  </option>    
        <option value="401"> 블러링  </option>    
        <option value="402"> 엠보싱  </option>    
        
         
         
             
           
                
         
        

        
</form>
         
        
	</select>
    <div>
	<p> <input type='file' name='filename'>
	</div>
	
	<div class="int-area">
	<p> <strong>value</strong> <input type='text' value = 10 name='addVal'>
	</div>
		
	<div class ="btn-area">
	 <button type='submit' value='Login'> 영상처리</button>
	</div>
   
</section>

</body>
</html>