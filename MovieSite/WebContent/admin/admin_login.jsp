<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>관리자 로그인</h2>
<HR>

<form name="myForm" method="post" action="/user/user_control.jsp" >
	<input type="hidden" name="action" value="admin_login">
	
	<table border="1">
		<tr><th>ID</th> <td><input type="text" name="name_mem" required></td></tr>
		<tr><th>비밀번호</th> <td><input type="password" name="password" required></td> </tr>
		<tr>
		<td><input type="submit" value="로그인"></td> 
		<td><input type="reset" value="초기화"></td>
		</tr>
	</table>
</form>

</body>
</html>