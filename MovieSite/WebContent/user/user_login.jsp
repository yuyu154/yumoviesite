<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="user" class="user.User" scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<center>
<%System.out.println("유저_로그인.jsp 실행"); %>

<form name="myForm" method="post" action="user/user_control.jsp" >
	<input type="hidden" name="action" value="login">
	
		<table border="1" width="150" >
			<tr><th>ID</th> <td><input type="text" name="name_mem"></td></tr>
			<tr><th>비밀번호</th> <td><input type="password" name="password"></td> </tr>
			<tr>
			<td><input type="submit" value="로그인"></td> 
			<td><input type="reset" value="초기화"></td>
			</tr>
		</table>
</form>

<a href="admin_login.jsp">관리자 로그인</a>
<HR>
<a href="user_register.jsp">회원가입</a> <BR>
<HR>

<h3>
</h3>


</center>
</body>
</html>