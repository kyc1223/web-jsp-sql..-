<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인</title>
<link rel="stylesheet" href="style.css">
<script src="jquery-3.4.1.js"></script>
</head>

<body>

<section class="login-form">
<h1>영상처리 프로그램</h1>
<form method="post" action="miniproject_login_server.jsp">
    <div class="int-area">
	<p> <input type='text' name='u_id' id="id" autocomplete="off" required>
	       <label for="id">ID</label>
	</div>
	<div class="int-area">
	<p> <input type='password' name='u_pass' id='pw' autocomplete="off" required>
		       <label for="pw">PW</label>
		       </div>
		       <div class="btn-area">
		          <button type='submit' value='Login'> LOGIN</button>
		       </div>		       
</form>
     <div class="caption">
        <a href="miniproject_insert_client.html">회원가입</a>
     </div>
     
     <div class="caption">
        <a href="miniproject_delete_client.html">회원탈퇴</a>
     </div>
</section>

</body>
</html>